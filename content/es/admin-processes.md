## XII. Procesos de administración
### Ejecutar las tareas de gestión/administración como procesos de un solo uso

El [juego de procesos](./concurrency) es un conjunto de procesos que se usan para hacer las tareas habituales de la aplicación (como procesar las peticiones web). Por separado, a menudo los desarrolladores desean ejecutar procesos de administración o mantenimiento de un solo uso, como:

* Ejecutar migraciones de bases de datos (e.g. `manage.py migrate` en Django, `rake db:migrate` en Rails).
* Ejecutar una consola (conocidas también como [REPL](http://en.wikipedia.org/wiki/Read-eval-print_loop)) para ejecutar código arbitrario o inspeccionar los modelos de la aplicación en una base de datos con datos reales. La mayoría de los lenguajes proporcionan un interprete de tipo REPL si se ejecuta el mismo mandato sin ningún argumento (e.g. `python` o `perl`) y en algunos casos tienen un mandato distinto (e.g. `irb` en Ruby, `rails console` en Rails).
* Ejecutar scripts de un solo uso incluidos en el repositorio de la aplicación (e.g. `php scripts/fix_bad_records.php`).

Los procesos de administración únicos deberían ejecutarse en un entorno idéntico al que se usa normalmente en [procesos de larga duración](./processes) de la aplicación. Estos procesos se ejecutan en una [distribución](./build-release-run) concreta, usando la misma [base de código](./codebase) y la misma [configuración](./config), que cualquier proceso que ejecuta esa distribución. El código de administración debe ser enviado con el código de la aplicación para evitar problemas de sincronización.

Se deberían usar las mismas técnicas de [aislamiento de dependencias](./dependencies) en todos los tipos de procesos. Por ejemplo, si el proceso web Ruby usa el mandato `bundle exec thin start`, entonces una migración de la base de datos debería usar `bundle exec rake db:migrate`. De la misma manera, un programa Python que usa Virtualenv debería usar `bin/python` para ejecutar tanto el servidor web Tornado como cualquier proceso de administración `manage.py`.

"Twelve-factor" recomienda encarecidamente lenguajes que proporcionan una consola del tipo REPL, ya que facilitan ejecutar scripts de un solo uso. En un despliegue local, los desarrolladores invocarán procesos de administración de un solo uso con un mandato directo en la consola dentro del directorio de la aplicación. En un despliegue de producción, los desarrolladores pueden usar ssh u otro mecanismo de ejecución de mandatos remoto proporcionado por el entorno de ejecución del despliegue para ejecutar dicho proceso.
