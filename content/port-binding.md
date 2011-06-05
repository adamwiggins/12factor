## VII. Port binding
### Services exported via port binding

Historically, web apps are often executed inside some kind of runtime container.  For example, PHP apps might run as a module inside Apache, or Java apps might run inside Tomcat.

A twelve-factor app is completely self-contained and does not rely on runtime injection of a webserver into the execution environment to create a web-facing service.  The web app exports HTTP as a service by binding to a port, and listening to requests coming in on that port.

In a local development environment, the developer visits a service URL like `http://localhost:5000/` to access the service exported by their app.  In deployment, a routing layer handles routing requests from a public-facing hostname to the port-bound web processes.

This is typically implemented by using [dependency declaration](/dependencies) to add a webserver library to the app, such as [Tornado](http://www.tornadoweb.org/) for Python, [Thin](http://code.macournoyer.com/thin/) for Ruby, or [Jetty](http://jetty.codehaus.org/jetty/) for Java and other JVM-based languages.  But this happens completely inside the app (known in this context as [*user space*](http://en.wikipedia.org/wiki/User_space)), and if the app developers chose to, they could write app code to accept raw TCP requests and parse the HTTP without any supporting libraries.  Either way looks the same to the execution environment: the contract with the execution environment is binding to a port to serve requests, leaving the implementation details of what webserver is being used up to the web framework and/or the app's developers.

HTTP is not the only service that can be exported by port binding.  Nearly any kind of server software can be run via process-binds-to-a-port-to-receive-requests model.  To examples include ejabberd (speaking XMPP), and Redis (speaking the Redis protocol).
