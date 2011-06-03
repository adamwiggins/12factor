## III. Config
### Store config in the environment

*Config* of the app includes URLs to [attached resources](#) such as the app's database (including user/password, host, and database name), credentials to external services such as Amazon S3, or values such as the canonincal hostname of the app (used for redirects).

A twelve-factor app always strictly separates config from code.  Config varies substantially across deploys, code does not.  A good measure of whether an app is correctly factored on this point is whether it could be released as open source without compromising any credentials.

Developrs have a tendency to want to write config as constants in the code (poor factoring) or into a parseable config file such as `config/database.yml` in Rails (better, but still weak).

Config belongs in *environment variables* (often shortened to *env vars* or *env*).  Env vars are easy to change between deploys and there is no chance of them being checked into the code repo accidentally.

A common pattern with env vars is to fall back on sensible defaults when not set.  For example, an app may use the `CANONICAL_HOST` env var for redirects, but the app will not attempt a redirect the the value is not set (which is usually desirable for development deploys).  Or assuming a local memcached if the MEMCACHED_URL is not set.  In this way, no env vars means the app is running as a vanilla development deploy.

Environment variables are highly granular when compared to the config-file method.  Config files tend to batch up values into named groups often called environments (for example, `development`, `test`, and `production` in Rails).  As more deploys of the app are created, new environment names are necessary - for example, `staging` or `qa`.  As the project grows further, developers may add their own special environments like `joes-staging`.  The worst outcome of this is when the application begins using conditionals to change behavior based on the environment name - for example, deciding to redirect to a hardcoded canonical hostname `if Rails.environment == 'production'`.

This confusing explosion of config is not compatible with neat factoring of twelve-factor apps.  Config vars are each orthogonal values, not grouped together as "environments," but independently controllable for each deploy.  This is a model that scales up smoothly as the app naturally grows more deploys over its lifetime.
