## I. Base de código (Codebase)
### Una base de código sobre el que hacer control de seguimiento, muchos despliegues

Una "twelve-factor app" se encuentra siempre en un sistema de control de versiones, tales como [Git](http://git-scm.com/), [Mercurial](http://mercurial.selenic.com/), o [Subversion](http://subversion.apache.org/). A una copia de la base de datos de seguimiento de actualización se le conoce como un *repositorio de código*, a menudo abreviado como *repo de código* o simplemente *repo*.

Una *base de código* es cualquier repositorio (en un sistema de control de versiones centralizado como Subversion), o cualquier conjunto de repositorios que comparten un commit raíz (en un sistema de control de versiones descentralizado como Git).

![Una base de código se aplica a muchos despliegues](/images/codebase-deploys.png)

Siempre hay una correlación uno a uno entre la base de código y la aplicación:

* Si hay muchas bases de código, no es una aplicación -- es un sistema distribuido. Cada componente en un sistema distribuido es una aplicación, y cada uno, individualmente, puede cumplir los requisitos de una "twelve-factor app".
* Multiples aplicaciones que comparten el mismo código es considerado como una violación de "twelve factor".  La solución en este caso es separar el código compartido en librerías que pueden estar incluidas mediante un [gestor de dependencias](./dependencies).

Hay una sola base de código por aplicación, pero habrá muchos despliegues de la aplicación.  Un *despliegue* es una instancia de la aplicación que está corriendo .  Esto es normalmente un sitio en producción, y uno o más sitios de pruebas.  Además, cada desarrollador tiene una copia de la aplicación corriendo en su entorno de desarrollo local, cada uno de los cuales es considerado también como un despliegue.

La base de código es el mismo en todos los despliegues, aun que pueden ser diferentes versiones en cada despliegue.  Por ejemplo, un desarrollador tiene algunos commits sin desplegar en pruebas; pruebas tiene algunos commits que no están desplegados en producción.  Pero todos ellos comparten la misma base de código, de este modo todos son identificables como diferentes despliegues de la misma aplicación.
