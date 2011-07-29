## VI. Processes
### Stateless processes handle application logic

The business logic of an app is codified in its [codebase](/codebase).  The code is executed in the execution environment as one or more *processes*.

In the simplest case, the code is a stand-alone script, the execution environment is a developer's local laptop with an installed language runtime, and the process is launched via the command line (for example, `python my_script.py`).  On the other end of the spectrum, a production deploy of a sophisticated app may use many [process types, instantiated into zero or more running processes](/concurrency).

**Twelve-factor processes are stateless and [share-nothing](http://en.wikipedia.org/wiki/Shared_nothing_architecture).**  The filesystem sitting beneath the process is either read-only (attempting a write will produce an error), or completely ephemeral (when the process terminates, all state written to disk will be discarded).  Any data that needs to persist must be stored in a stateful [backing service](/backing-services), typically a database.

Process memory space and ephemeral filesystem can potentially be used as a brief, single-transaction cache.  For example, downloading a large file, operating on it, and storing the results of the operation in the database.  The twelve-factor app never assumes that anything cached in memory or on disk will be available on a future request or job -- with many processes of each type running, chances are high that that a future request will be served by a different process.  Even when running only one process, a restart (triggered by code deploy, config change, or the execution environment relocating the process to a different physical location) will wipe all filesystem and in-memory state.

Asset packagers (such as [Jammit](http://documentcloud.github.com/jammit/) or [django-assetpackager](http://code.google.com/p/django-assetpackager/)) use the filesystem as a cache for compiled assets.  A twelve-factor app is best served by doing this compiling during the [build stage](/build-release-run) rather than at runtime.

Some web systems rely on "sticky sessions" -- that is, caching user session data in memory of the app's process and expecting future requests from the same visitor to be routed to the same process.  Sticky sessions are a violation of twelve-factor and should never be used or relied upon.  Session state is a good candidate for a datastore that offers time-expiration, such as [Memcached](http://memcached.org/) or [Redis](http://redis.io/).

