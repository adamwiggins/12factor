## Example: Canonical host config

[`rack-canonical-host`](https://github.com/tylerhunt/rack-canonical-host) is of Rack middleware for Ruby web apps which redirects the user to the canonical hostname for the app.  For example, if your production deploy can be reached at both hostnames `www.example.com` and `example.com`, but you wish for `www.example.com` to be the canonical host, using `rack-canonical-host` will automatically redirect users there when they access it on `example.com`.

## Doing it wrong #1: Hostname as a constant in the code

    CANONICAL_HOST = 'www.example.com'
    use(Rack::CanonicalHost, CANONICAL_HOST)

This violates twelve-factor because it stores config in the codebase.

## Doing it wrong #2: Hostname from conditional on "environment"

    use Rack::CanonicalHost do
      case ENV['RACK_ENV'].to_sym
        when :staging then 'example.com'
        when :production then 'staging.example.com'
      end
    end

This violates twelve-factor because it uses a conditional on the RACK_ENV value which stores an deploy name like `staging` or `production`.  This stores config in the codebase (the hardcoded hostnames), and uses a non-granular, non-orthogonal deploy name to choose the canonical host.  Both of these things make it impossible to add new deploys without changing the code.  (As a thought experiment, imagine what it would take to open-source an app that had the above block of code in it.)

## Doing it right: Hostname from an env var

    use(Rack::CanonicalHost, ENV['CANONICAL_HOST']) if ENV['CANONICAL_HOST']

## Doing it really right: Library uses env var directly

A well-written library of the nature of `rack-canonical-host` will use the enviroment variable directly, simplifying the code even further:

    use Rack::CanonicalHost

