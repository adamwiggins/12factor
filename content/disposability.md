## IX. Disposability
### Fast startup and graceful shutdown maximize robustness

The twelve-factor app's [processes](/processes) are architected to be stopped and started at a moment's notice, facilitating fast elastic scaling and rapid deployment of [code](/codebase) or [config](/config) changes.  This is a key element in ensuring robustness of a production deployment.

Processes shut down gracefully when they receive a [SIGTERM](http://en.wikipedia.org/wiki/SIGTERM) signal from the process manager.  For a web process, graceful shutdown is achieved by ceasing to listen on the service port (thereby refusing any new requests), allowing any current requests to finish, and then exiting.  Implicit in this model is that HTTP requests are short (no more than a few seconds), or in the case of long polling, the client is written to seamlessly attempt a reconnect in the case of losing the long-poll connection.

For a worker process, graceful shutdown is achieved by returning the current job to the work queue.  For example, on RabbitMQ the worker can send a `NACK`; on Beanstalkd, the job is returned to the queue automatically whenever a worker disconnects.  Lock-based systems such as Delayed Job need to be sure to release their lock on the job record.  Implicit in this model is that all jobs are [reentrant](http://en.wikipedia.org/wiki/Reentrant_%28subroutine%29), which typically is achieved by wrapping the results in a transaction, or making the operation [idempotent](http://en.wikipedia.org/wiki/Idempotence).

In this model, minimizing startup time of any individual app process is desirable.  Ideally, a process takes a few seconds from the time the launch command is executed until the process is up and ready to receive requests or jobs.  But even a large app should try to keep its startup to to no more than 30 seconds.  Briefer startup time provides more agility for deploys, code changes, scaling up; and it aids robustness, because the process manager can more easily move processes to new physical machines when warranted.

Processes should also be robust against sudden death, in the case of a failure in the underlying hardware.  While this is a much less common occurrence than a graceful shutdown with `SIGTERM`, it can still happen.  Use of a robust queueing backend (such as Beanstalkd) that returns jobs to the queue when clients disconnect or time out, can make all the difference here.  Either way, a twelve-factor app is architected to handle unexpected, non-graceful terminations.  [Crash-only design](http://lwn.net/Articles/191059/) takes this concept to its [logical extreme](http://couchdb.apache.org/docs/overview.html).


