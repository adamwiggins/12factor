## I. Código base (Codebase)
### Un código base sobre el que hacer el control de versiones y multiples despliegues

Una aplicación "twelve-factor" se gestiona siempre con un sistema de control de versiones, como [Git](http://git-scm.com/), [Mercurial](http://mercurial.selenic.com/), o [Subversion](http://subversion.apache.org/). A la copia de la base de datos de seguimiento de versiones se le conoce como un *repositorio de código*, a menudo abreviado como *repo de código* o simplemente *repo*.

El *código base* es cualquier repositorio (en un sistema de control de versiones centralizado como Subversion), o cualquier conjunto de repositorios que comparten un commit raíz (en un sistema de control de versiones descentralizado como Git).

![El código base se usa en muchos despliegues](/images/codebase-deploys.png)

Siempre hay una relación uno a uno entre el código base y la aplicación:

* Si hay multiples códigos base, no es una aplicación -- es un sistema distribuido. Cada componente en un sistema distribuido es una aplicación, y cada uno, individualmente, puede cumplir los requisitos de una aplicación "twelve-factor".
* Multiples aplicaciones que comparten el mismo código se considera como una violación de la metodología "twelve factor". La solución en este caso es separar el código compartido en librerías que pueden estar enlazadas mediante un [gestor de dependencias](./dependencies).

Existe solo un código base por aplicación, pero habrá muchos despliegues de la aplicación. Un *despliegue* es una instancia de la aplicación que está en ejecución. Ésto, normalmente, es un sitio en producción, y uno o más sitios de pruebas.  Además, cada desarrollador tiene una copia de la aplicación ejecutandose en su entorno de desarrollo propio, cada uno de los cuales se considera también como un despliegue.

El código base es el mismo en todos los despliegues, aun que pueden ser diferentes versiones en cada despliegue. Por ejemplo, un desarrollador tiene algunos commits sin desplegar en preproducción; preproducción tiene algunos commits que no están desplegados en producción. Pero todos ellos comparten el mismo código base, de este modo todos son identificables como diferentes despliegues de la misma aplicación.
