## VI. Processes
### Stateless, disposable processes handle application logic

The business logic of an app happens in the app code.  This code gets executed in the execution environment as one or more *processes*.  the simplest case, the code is a stand-alone script, the execution environment is a developer's local laptop and an installed language runtime, and the process is launched via a simple command line: for example, `python my_script.py`.  On the other end of the spectrum, a production deploy of a sophisticated app may use many [process types, instantiated into zero or more running processes](#).

Processes are stateless and share-nothing.  The filesystem sitting beneath the process is either read-only (attempting a write will produce an error), or completely ephemeral (when the process terminates, all state written to disk will be discarded).  Anything that needs to persist must be stored in a stateful [backing service](#), typically a [database](#).

The process memory space and filesystem can potentially be used as a brief, single-transacton cache.  For example, downloading a large file, operating on it, and storing the results of the operation in the database.  The twelve-factor app never assumes that anything cached in memory or on disk will be available on a future request or job - with many processes of each type running, chances are high that that a future request will be served by a different process.  Even with a single process, a restart (triggered by code deploy, config change, or the executing environment deciding to relocate the process to a different physical location) will wipe all state.

Asset packagers (such as [Jammit](http://documentcloud.github.com/jammit/)) or [django-assetpackager](http://code.google.com/p/django-assetpackager/)) use the filesystem as a cache for compiled assets.  A twelve-factor app is best served by doing this compiling during the [build stage](#) rather than at runtime.

Some web systems rely on "sticky sessions" - that is, caching user session data in memory of the app's process and expecting future requests from the same visitor to be routed to the same process.  Sticky sessions are a violation of twelve-factor and should never be used or relied upon.  Session state is a good candidate for a datastore that offers time-expiration, such as Memcached or Redis.

### Processes are disposable

Processes should be architected to be stopped and started at a moment's notice, faciliting fast elastic scaling and rapid deployment of code or config changes.  This is a key element in ensuring robustness of a production deployment.

Processes should be prepared to shut down gracefully at any time on receiving a [SIGTERM](http://en.wikipedia.org/wiki/SIGTERM) signal from the process manager.  The process will be granted a brief window (perhaps ten seconds) to shut down, after which it will be force-killed.

For a web process, graceful shutdown is achieved by ceasing to listen on the service port (thereby refusing any new requests), allowing any current requests to finish, and then exiting.  Implicit in this model is that HTTP requests are short (no more than a few seconds), or in the case of long polling, the client is written to seamlessly attempt a reconnect in the case of losing the long-poll connection.

For a worker process, graceful shutdown is achieved by returning the current job to the work queue.  For example, on RabbitMQ the worker can send a `NACK`; on Beanstalkd, the job is returned to the queue automatically whenever a worker disconnects.  Lock-based systems such as Delayed Job need to be sure to release their lock on the job record.  Implicit in this model is that all jobs are [reentrant](http://en.wikipedia.org/wiki/Reentrant_%28subroutine%29), which typically is achieved by wrapping the results in a transaction, or making the operation [idempotent](http://en.wikipedia.org/wiki/Idempotence).

Developers should attempt to keep process startup time low.  Ideally, it should only take a few seconds from the time the launch command is executed until the process is up and ready to receive requests or jobs.  But even a large app should try to keep its startup to to no more than 30 seconds.  Briefer startup time provides more agility for deploys, code changes, scaling up; moreover, it helps robustness, because the process manager can more easily move processes to new physical machines when warranted.

Processes should also be robust against sudden death, in the case of a failure in the underlying hardware.  While this is a much less common occurence than a graceful shutdown with `SIGTERM`, it can still happen.  Use of a robust queueing backend (such as Beanstalkd) that returns jobs to the queue when clients disconnect or time out, can make all the difference here.  Either way, a twelve-factor app is architected to handle unexpected, non-graceful terminations.  Taking this idea to its logical conclusion may even result in a [crash-only](http://lwn.net/Articles/191059/) [design](http://couchdb.apache.org/docs/overview.html).

