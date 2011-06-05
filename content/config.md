## III. Config
### Store config in the environment

An app's *config* is everything that can vary between [deploys](/codebase).  This includes:

* Resource handles to the database, memcached, and other [backing services](#)
* Credentials to external services such as Amazon S3 or Twitter
* Per-deploy values such as the canonical hostname for each deploy

A common practice is for apps to store config as constants in the code.  This is a violation of twelve-factor, which requires **strict separatation of config from code**.  Config varies substantially across deploys, code does not.  A litmus test for whether an app has all config correctly factored out of the code is whether the codebase could open sourced as-is without compromising any credentials.

Another approach to config is storing it in config files which are not checked into revision control, such as `config/database.yml` in Rails.  This is a huge improvement over using constants which are checked into the code repo, but still has weaknesses: it's easy to mistakenly check in a config file to the repo, and there is a tendency for config files to be scattered about in different places and different formats, making it hard to see and manage all the config in one place.

**The twelve-factor app stores config in *environment variables*** (often shortened to *env vars* or *env*).  Env vars are easy to change between deploys without changing any code, and unlike config files, there is little chance of them being checked into the code repo accidentally.

Yet another method of managing config is batching it up into named groups (often called "environments") named after specific deploys, such as the `development`, `test`, and `production` environments in Rails.  This method does not scale cleanly: as more deploys of the app are created, new environment names are necessary - for example, `staging` or `qa`.  As the project grows further, developers may add their own special environments like `joes-staging`.  The worst outcome of this is when the application begins using conditionals to change behavior based on the environment name - code that looks like `do_something_for_production if Rails.environment == 'production'`.

In a twelve-factor app, env vars are granular controls, each fully orthogonal to other env vars.  They are never grouped together as "environments," but instead are independently controllable for each deploy.  This is a model that scales up smoothly as the app naturally expands into more deploys over its lifetime.

A common pattern with env vars is to fall back on sensible defaults when not set.  For example, an app may use the `CANONICAL_HOST` env var for redirects, but the app will not attempt a redirect the the value is not set (which is usually desirable for development deploys).  Or assuming a local memcached if the MEMCACHED_URL is not set.  In this way, no env vars means the app is running as a vanilla development deploy.
