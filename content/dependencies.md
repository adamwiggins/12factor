## II. Dependencies
### Explicit dependency declaration and isolation

Most programming languages offer a packaging system for distributing support libraries, such as [CPAN](http://www.cpan.org/) for Perl or [Rubygems](http://rubygems.org/) for Ruby.  Libraries installed through a packaging system can typically be installed system-wide (known as "site packages") or only into the directory containing the app (known as "vendoring" or "bundling").

A twelve-factor app *never* relies on implicit existence of system-wide packages.  It declares all dependencies, completely and exactly, via a *dependency declaration* tool.  Furthermore, it uses *dependency isolation* tool during execution to ensure that no implicit dependencies "leak in" from the surrounding system.

For example, [Gem Bundler](http://gembundler.com/) for Ruby offers the `Gemfile` format for declaration and `bundle exec` for dependency isolation.  In, Python there are two separate tools for these steps - [Pip](http://www.pip-installer.org/en/latest/) is used for dependency declaration and [Virtualenv](http://www.virtualenv.org/en/latest/) for dependency isolation.  Regardless of tools, dependency declaration and isolation must be used together - only one or the other is not sufficient for the twelve-factor app.

A key benefit of explicit dependency declaration is setup for new developers on the project.  The new developer can check out the app's sourcecode onto a machine with only the language runtime and packager installed.  They will be able to set up everything needed to run the app in a single, deterministic command - such as `bundle install` for Ruby/Bundler or `lein deps` for Clojure/Leiningen.  In apps where dependencies are not explicit, the developer may have to pick through the documentation or readme to find out what dependency packages need to be installe dmanually.

In a related point, twelve-factor apps also do not rely on the implicit existence of any system tools.  Examples include shelling out to ImageMagick or Curl.  While these tools may exist on some systems, there is no guarantee that they will exist on all systems where the app may run in the future, or whether the version found on a future system will be compatible with the app.  If the app needs to shell out to a system tool, that tool must be vendored into the app.
