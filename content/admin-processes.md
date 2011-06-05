## XII. Admin processes
### One-off admin/management tasks

The [process formation](/concurrency) represents the array of processes that are used to do the app's regular business (such as handling web requests) as it runs.  Separately, developers will often wish to do one-off administrative or maintenance tasks for the app, such as:

* Running database migrations (e.g. `manage.py syncdb` in Django, `rake db:migrate` in Rails).
* Running a console (also known as a REPL shell) to run arbitrary code or inspect the app's models against the live database.  Most languages provide a REPL by running the interpreter without any arguments (e.g. `python` or `node`) or in some cases have a separate command (e.g. `irb` for Ruby, `rails console` for Rails).
* Running one-time scripts committed into the app's repo (e.g. `php scripts/fix_bad_records.php`).

Twelve-factor apps are best written in languages which provide a REPL shell out of the box, and which make it easy to run one-off scripts.  In a local deploy, developers invoke one-off admin processes by a direct shell command inside the app's checkout directory.  In a production deploy, developers can use ssh or other remote command execution mechanism provided by that deploy's execution environment to run such a process.
