## XI. Logs
### Logs are event streams

*Logs* provide visibility into the behavior of a running app.  While they are sometimes written to a file on disk, this is only an output format - not the essence of what logs really are.

**Logs for a twelve-factor app are the [stream](http://adam.heroku.com/past/2011/4/1/logs_are_streams_not_files/) of aggregated, time-ordered events collected from the output streams of all its running processes and backing services.**  Their raw form typically apepars as a text format with one event per line (though backtraces from exceptions may span multiple lines).  The logs have no fixed beginning or end, but flow continously as long as the app is operating.

A twelve-factor app never concerns itself with routing or storage of its output stream.  It should not attempt to write to or manage logfiles.  Instead, each running process writes its stream, unbuffered, to `stdout`.  During local development, the developer will view this stream in the foreground of their terminal to observe the app's behavior.

In staging or production deploys, each process' stream will be captured by the execution environment, collated together with all other streams from the app, and routed to one or more final destinations for viewing and long-term archival.  These archival destinations are not visible to or configurable by the app, and instead are completely managed by the execution environment.

The event stream for an app can be routed to a file, or watched via realtime tail in a terminal.  Most significantly, the stream can be sent to into an log indexing and analysis system such as [Splunk](http://www.splunk.com/), or a general-purpose data warehousing system such as [Hadoop/Hive](http://hive.apache.org/).  These systems allow for great power and flexibility with introspecting the app's behavior over time: from finding specific events in the past, to large-scale graphing of trends (such as requests per minute), to active alerting according to user-defined heuristics (such as an alert when the quantity of errors per minute exceeds a certain threshold).
