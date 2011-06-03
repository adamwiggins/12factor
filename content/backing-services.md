## IV. Backing Services
### Treat backing services as attached resources

An *backing service* is any service the app accesses over the network as part of its normal operation.  Examples include SQL or NoSQL databases (such as MySQL or CouchDB), messaging/queueing systems (such as RabbitMQ or Beanstalkd), SMTP servers (such as Sendmail or Postfix), and caching systems (such as Memcached).

Backing services are traditionally considered "local" and part of the app.  In addition to these locally-managed services, the app may also have services provided and managed by third parties.  Examples include SMTP services (such as Sendgrid or Postmark), metrics-gathering services (such as New Relic or Loggly), binary asset services (such as Amazon S3 or Rackspace Cloudfiles), and even API-accessible consumer services (such as Twitter, Google Maps, or Last.fm).

**The twelve-factor app makes no differentiation between local and third party services**.  To the app, both are backing services, accesed via a URL or other locator/credentials stored in the [config](#).  A deploy of the twelve-factor app should be able to swap out a local MySQL database with one running as a managed service (such as [Amazon RDS](http://aws.amazon.com/rds/)) without any changes to the app's code.  Likewise, or a local SMTP server could be swapped with a managed service (such as [Sendgrid](http://sendgrid.com/)) without code changes.  In both cases, only the resource handle in the config needs to change.
