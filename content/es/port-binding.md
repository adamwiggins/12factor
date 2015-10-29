## VII. Asignación de puertos
### Publicar servicios mediante asignación de puertos

Las aplicaciones web a menudo se ejecutan mediante contenedores web. Por ejemplo, las aplicaciones PHP se pueden ejecutar como módulos del [HTTPD de Apache](http://httpd.apache.org/), y las aplicaciones Java en [Tomcat](http://tomcat.apache.org/).

**Las aplicaciones "twelve factor" son completamente auto-contenidas** y no dependen de un servidor web en ejecución para crear un servicio web público. Una aplicación web **usa HTTP como un servicio al que se le asigna un puerto**, y escucha las peticiones que recibe por dicho puerto.

En un entorno local de desarrollo, el desarrollador usa una URL del servicio como `http://localhost:5000/` para acceder al servicio que ofrece una aplicación. En la fase de despliegue, existe una capa de enrutamiento que se encarga de que las peticiones que llegan a una ruta pública se redirija hacia el proceso web que tiene asignado en su puerto correspondiente.

Normalmente se implementa usando una [declaracion de dependencias](./dependencies) para incluir librerías en las aplicaciones web, como en [Tornado](http://www.tornadoweb.org/) para Python, [Thin](http://code.macournoyer.com/thin/) para Ruby, o [Jetty](http://jetty.codehaus.org/jetty/) para Java y otros lenguajes basados en la Maquina Virtual de Java (JVM). Esto ocurre completamente en el *espacio del usuario*, es decir, dentro del código de la aplicación. El contrato con el entorno de ejecución obliga a un puerto a servir peticiones.

HTTP no es el único servicio que usa la asignación de puertos. Lo cierto es que cualquier servicio puede ejecutarse mediante un proceso al que se le asigne un puerto y que espere peticiones. Entre otros ejemplos podemos encontrar [ejabberd](http://www.ejabberd.im/) (que usa [XMPP](http://xmpp.org/)), y [Redis](http://redis.io/) (que usa [el protocolo Redis](http://redis.io/topics/protocol)).

También es cierto que la aproximación de asignación de puertos ofrece la posibilidad de que una aplicación puede llegar a ser un [servicio de respaldo](./backing-services) para otra aplicación, usando la URL de la aplicación de respaldo como un recurso declarado en la [configuración](./config) de la aplicación consumidora.
