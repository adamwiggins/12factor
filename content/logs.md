## X. Logs
### Logs are event streams

Logs provide oversight and introspection of the behavior of a running app.  Logs often appear as files on disk, but this is only one possible output format, not their true form.

Logs for a twelve-factor app are the aggregated, time-ordered output streams from all of the app's running processes and backing services.  The logs have no fixed beginning or end, and can be thought of as a [stream of events](http://adam.heroku.com/past/2011/4/1/logs_are_streams_not_files/).  This is typically represented as a text format with one event per line (though backtraces from exceptions may span multiple lines).

A twelve-factor app never concerns itself with routing or storage of its output stream.  It should not attempt to write to or manage logfiles.  Instead, each running process writes its stream, unbuffered, to standard output (STDOUT).  During local development, the developer will view this stream in the foreground of their terminal to observe the app's behavior.

In deployment, each process' stream will be captured by the execution environment, collated together with all other streams from the app, and routed to one or more final destinations for viewing and long-term archival.  These archival destinations are not visible to or configurable by the app, and instead are completely managed by the execution environment.

The event stream for an app can be routed to a file, or watched via realtime tail in a terminal.  Most significantly, the stream can be sent to into an log indexing and analysis system such as Splunk, or a general-purpose data warehousing system such as Hadoop/Hive.  These systems allow for great power and flexibility with introspecting the app's behavior over time: from finding specific events in the past, to large-scale graphing of trends (such as requests per minute), to active alerting according to user-defined heuristics (such as an alert when the quantity of errors per minute exceeds a certain threshold).
