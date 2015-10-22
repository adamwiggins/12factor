## III. Configuración
### Almacenar la configuración en el entorno

Una configuración de una aplicación es todo lo que puede variar entre [despliegues](./codebase) (entorno de pruebas, producción, desarrollo, etc). Lo que incluye:

* Recursos que manejan la base de datos, Memcached, y otros [backing services](./backing-services)
* Credenciales para servicios externos tales como Amazon S3 o Twitter
* Valores de despliegue como por ejemplo el nombre canónico del equipo para el despliegue

Las aplicaciones a veces almacenan configuraciones como constantes en el código. Lo cual conduce a una violación de la metodología "twelve-factor", que requiere una **estricta separación de la configuración y el código**. La configuración varía sustancialmente en cada despliegue, el código no.

La prueba definitiva para saber si una aplicación tiene toda su configuración correctamente separada del código es comprobar que la base de código puede ser código abierto en cualquier momento, sin comprometer las credenciales.

Hay que resaltar que la definición de "configuración" **no** incluye las configuraciones internas de la aplicación, tales como `config/routes.rb` en Rails, o como [se conectan los módulos de código](http://docs.spring.io/spring/docs/current/spring-framework-reference/html/beans.html) en [Spring](http://spring.io/). Este tipo de configuraciones no varían entre despliegues, y por eso están mejor en el código.

Otra estrategia de la configuración es el uso de ficheros de configuración que no se guardan en el control de versiones, como ocurre con el `config/database.yml` de Rails. Lo cual supone una gran mejora con respecto a las constantes que se guardan en el repositorio de código, pero todavía tiene debilidades: es fácil guardar un fichero de configuración en el repo por error; se tiende a desperdigar los ficheros de configuración en diferentes sitios y con distintos formatos, siendo más difícil la tarea de ver y gestionar toda la configuración en un solo sitio. Además, esos formatos tienden a ser específicos del lenguaje o del framework.

**Las aplicaciones "twelve-factor" almacenan la configuración en *variables de entorno*** (a menudo acortadas como *env vars* o *env*). Las variables de entorno se intercambian fácilmente entre despliegues sin modificar nada en el código; a diferencia de los ficheros de configuración, hay una pequeña posibilidad de que se guarden en el repositorio de código accidentalmente; y a diferencia de los ficheros de configuración personalizados, u otros mecanismos de configuración como los System Properties de Java, son un estándar independiente+ del lenguaje y del sistema operativo.

Otro aspecto de la gestión de la configuración es el agrupamiento. A veces las aplicaciones agrupan las configuraciones en grupos identificados (a menudo llamados "entornos" o "environments") identificando después despliegues específicos, como ocurre en Rails con los entornos `development`, `test`, y `production`. Este método no escala de manera limpia: según se van creando despliegues de la aplicación, se van necesitando nuevos entornos, tales como `staging` o `qa`. Según va creciendo el proyecto, los desarrolladores van añadiendo sus propios entornos especiales como `joes-staging`, resultando en una explosión combinatoria de configuraciones que hacen la gestión de despliegues de la aplicación muy frágil.

En una aplicación "twelve-factor", las variables de entorno son controles granulares, cada una de ellas completamente ortogonales a las otras. Nunca se agrupan juntas como "entornos", pero en su lugar se gestionan independientemente para cada despliegue. Este es un modelo que escala con fluidez según la aplicación se extiende, naturalmente, en más despliegues a lo largo de su vida.
