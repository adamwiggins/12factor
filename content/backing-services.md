## IV. Backing Services
### Treat backing services as attached resources

A *backing service* is any service the app consumes over the network as part of its normal operation.  Examples include datastores (such as [MySQL](http://dev.mysql.com/) or [CouchDB](http://couchdb.apache.org/)), messaging/queueing systems (such as [RabbitMQ](http://www.rabbitmq.com/) or [Beanstalkd](http://kr.github.com/beanstalkd/)), SMTP services for outbound email (such as [Postfix](http://www.postfix.org/)), and caching systems (such as [Memcached](http://memcached.org/)).

Traditionally, backing services like the database are managed by the same admins as the app's deploy.  In addition to these locally-managed services, the app may also have services provided and managed by third parties.  Examples include SMTP services (such as [Postmark](http://postmarkapp.com/)), metrics-gathering services (such as [New Relic](http://newrelic.com/) or [Loggly](http://www.loggly.com/)), binary asset services (such as [Amazon S3](http://aws.amazon.com/s3/)), and even API-accessible consumer services (such as [Twitter](http://dev.twitter.com/), [Google Maps](http://code.google.com/apis/maps/index.html), or [Last.fm](http://www.last.fm/api)).

**The code for a twelve-factor app makes no distinction between local versus third party services.**  To the app, both are backing services, accessed via a URL or other locator/credentials stored in the [config](/config).  A [deploy](/codebase) of the twelve-factor app should be able to swap out a local MySQL database with one managed by a third party (such as [Amazon RDS](http://aws.amazon.com/rds/)) without any changes to the app's code.  Likewise, or a local SMTP server could be swapped with a third-party SMTP service (such as Postmark) without code changes.  In both cases, only the resource handle in the config needs to change.

Provisioning a database from a cloud-based backing service like Amazon RDS is done via API.  Provisioning produces a *private resource*.  The provisioned resource has a resource handle (typically in URL form, like `mysql://user:pass@host/db`) which points to the private resource and provides everything the app needs to access it.  For a service Amazon RDS, the resource is a database.  For a service like New Relic or a consumer service like Last.fm, the resource is an account or a user.

The twelve-factor app treats these resources as *attached resources*, which indicates their loose coupling to the deploy they are attached to.  Resources can be attached and detached to deploys at will.

<img src="/images/attached-resources.png" style="float: none" alt="A production deploy attached to four backing services." />

For example, the process of upgrading a database to a server with more compute and memory will typically look like this:

1. Provision a new, larger database resource from the database service provider.
2. Put the app into maintenance mode.
3. Take a backup of the existing database.
4. Load the backup into the newly provisioned database.
5. Detach the existing database, by clearing the env var which contains its handle (e.g., `MYSQL_URL` or `DATABASE_URL`).
6. Attach the new database, by setting that same env var with the resource handle for the new resource.
7. Take the app out of maintenance mode.

A prudent administrator will keep the previous database around, unattached to any app deploy, for a few days while the new database is confirmed to be operating correctly.  Then the unattached database can be deprovisioned.

