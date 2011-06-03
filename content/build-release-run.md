## V. Build, release, run
### Separate build and run stages

The *build* stage is a transform which converts a [code repo](#) into an executable bundle with no external dependencies, suitable for immediate execution in the execution environment.  This bundle is known as a *build* (noun).  The build stage typically checks out a fresh copy of the code at a commit specified by the release process, fetches and vendors dependencies, and compile binaries or assets.  One well-known example of a build stage is creating a JAR file for a Java (or other JVM-based) language.

The *run* stage (commonly also referred to as "at runtime") takes the bundle produced by the build stage and executes it in the execution environment.  This typically happens by fetching and expanding the executable bundle, setting up the environment with the [config](#), and then launching one or more of the app [processes](#).

In a traditional server-based hosting environment, it's easy to muddle together the build and run stages.  For example, one might create the fresh checkout and install dependencies, but then tweak the code in-place on the disk.

The twelve-factor app uses strict separation between the build and run stages.  It is impossible to make changes to the code at runtime, since there is no way to propagate those changes back to the build stage (or to other runtimes).  Config is only accessible at runtime, since config can change without triggering a build.

Builds only happen as the result of a developer-initiated action: deploying new code.  Runtime execution, however, can often happen automatically in cases such as a server reboot, or a process restarting after it crashes.  Therefore the run stage should be kept to as few moving parts as possible, since problems that prevent an app from running can cause it to break in the middle of the night when no developers are around.  The build stage can be more complex, since errors are always in the foreground for a developer who is actively engaged, and a failed build will abort the release process and avoid disrupting the running application.

### Release = build + config

A *release* is a combination of a build (an executable bundle generated in the [build stage](#)) and a [config](#), a set of environment variables to determine runtime behavior.

New builds always trigger new releases (since the build has been updated).  Config changes also trigger a new release (since the config has been updated).  A release requires restarting all running [processes](#) in order to bring all processes onto the new release.

Deployment tools typically offer release management tools, most notably the ability to roll back to a previous release.  For example, the [Capistrano](https://github.com/capistrano/capistrano/wiki) deployment tool stores releases in a subdirectory named `releases`, where the current release is a symlink to the current release directory; and offers a `rollback` command.
