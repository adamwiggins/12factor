## V. Construir, distribuir, ejecutar
### Separar rigurosamente la fase de construcción de la fase de ejecución

La [base de código](./codebase) se transforma en un despliegue (que no es de desarrollo) mediante tres fases:

* La *fase de construcción* es una transformación que convierte un repositorio de código en un paquete ejecutable conocido como *construcción* (build). Usando una versión del código de un commit específico por el proceso de despliegue, la fase de construcción trae todas las [dependencias](./dependencies) y compila los binarios y las herramientas.
* En la *fase de distribución* se coje la construcción creada en la fase de construcción y se combina con la [configuración](./config) del despliegue actual. La *distribución* resultante contiene tanto la construcción como la configuración y está lista para ejecutar inmediatamente en el entorno de ejecución.
* La *fase de ejecución* (también conocida como "runtime") ejecuta la aplicación en el entorno de ejecución, lanzando un conjunto de [procesos](./processes) de la aplicación contra una distribución seleccionada.

![El código se convierte en una construcción, que se combina con la configuración para crear una distribución.](/images/release.png)

**Las aplicaciones "twelve-factor" hacen una separación rigurosa entre las fases de construcción, de distribución y de ejecución.** Por ejemplo, es imposible hacer cambios en el código en la fase de ejecución, porque no hay una manera de propagar dichos cambios de vuelta a la fase de construcción.

Las herramientas de despliegue ofrecen normalmente herramientas de gestión de distribuciones (releases), especialmente la habilidad de volver a una versión anteriormente distribuida. Por ejemplo, la herramienta de despliegues [Capistrano](https://github.com/capistrano/capistrano/wiki) almacena distribuciones en un subdirectorio llamado `releases`, donde la distribución actual es un enlace simbólico al directorio de la distribución actual. Su mandato `rollback` hace fácil y rápidamente el trabajo de volver a la versión anterior.

Cada distribución siempre debería tener un identificador único de distribución, como por ejemplo la marca de tiempo (timestamp) de la distribución (`2011-04-06-20:32:17`) o un número incremental (como `v100`). Las distribuciones son como los libros de contabilidad al que solo se le pueden agregar registros y no puede ser modificada una vez es creada. Cualquier cambio debe crear una nueva distribución.

Las construcciones son iniciados por los desarrolladores de la aplicación cuando el nuevo código se despliega. La fase de ejecución, en cambio, puede suceder automáticamente por ejemplo cuando se reinicia un servidor, o cuando un proceso termina inesperadamente siendo reiniciado por el gestor de procesos. Por tanto, la fase de ejecución debería mantenerse lo más estático como sea posible, ya que evita que una aplicación en ejecución pueda causar una interrupción en mitad de la noche cuando no hay desarrolladores a mano. La fase de construcción puede ser más compleja, ya que los errores están siempre en la mente de un desarrollador que está dirigiendo el despliegue.
