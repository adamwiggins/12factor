﻿## VIII. Nebenläufigkeit
### Mit dem Prozess-Modell skalieren

Jedes Computerprogramm wird, wenn es läuft, repräsentiert durch einen oder mehrere Prozesse. Webapps nutzen verschiedenste Arten der Prozess-Ausführung. Zum Beispiel laufen PHP-Prozesse als Kind-Prozesse von Apache und werden nach Bedarf gestartet, wenn Requests kommen. Java-Prozesse gehen anders vor: die JVM stellt einen massiven Über-Prozess zur Verfügung der große Mengen an Systemressourcen (Speicher und CPU) reserviert und die Nebenläufigkeit wird intern über Threads verwaltet. In beiden Fällen sind die laufenden Prozesse für die Entwickler der App nur minimal zu sehen.

![Die Skalierung wird dargestellt als laufende Prozesse, die Diversität der Workload wird dargestellt als Prozesstypen.](/images/process-types.png)

**In der Zwölf-Faktor-App sind Prozesse First Class Citizens.** Die Prozesse der Zwölf-Faktor-App orientieren sich am [Unix-Prozess-Modell für Service Daemons](https://adam.herokuapp.com/past/2011/5/9/applying_the_unix_process_model_to_web_apps/). Mit diesem Model können Entwickler ihre App für die Bearbeitung verschiedenster Aufgaben konzipieren in dem sie jeder Aufgabe einen *Prozesstyp* zuweisen. Zum Beispiel können HTTP-Requests durch einen Web-Prozess bedient werden und langlaufende Hintergrundarbeiten durch einen Worker-Prozess.

Dies hindert die einzelnen Prozesse nicht daran, ihr internes Multiplexing zu verwalten, mittels Threads in der Laufzeit-VM oder mit dem Async/Event-Modell von Werkzeugen wie [EventMachine](http://rubyeventmachine.com/), [Twisted](http://twistedmatrix.com/trac/) oder [Node.js](http://nodejs.org/). Aber eine einzelne VM ist in der Größe dadurch beschränkt (vertikale Skalierung), dass eine App noch in der Lage sein muss, mehrere Prozesse auf mehreren physikalischen Maschinen zu starten.

Das Prozess-Modell glänzt besonders, wenn es um Skalierung geht. Die [Share-Nothing, horizontal teilbare Art und Weise der Prozesse der Zwölf-Faktor-App](./processes) hat zur Folge, dass weitere Nebenläufigkeit einfach und zuverlässig hinzugefügt werden kann. Das Bündel von Prozesstypen und die Zahl der Prozesse wird auch *Prozess-Formation* genannt.

Die Prozesse einer Zwölf-Faktor-App [sollten nie als Daemons laufen](http://dustin.github.com/2010/02/28/running-processes.html) oder PID-Dateien schreiben. Stattdessen sollen sie sich auf den Prozessmanager des Betriebssystems verlassen (wie [Upstart](http://upstart.ubuntu.com/), den verteilten Prozessmanager einer Cloud-Plattform oder ein Werkzeug wie [Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) während der Entwicklung) um [Output-Streams](./logs) zu verwalten, auf abgestürzte Prozesse zu reagieren und mit von Benutzern angestoßenen Restarts und Shutdowns umzugehen.
