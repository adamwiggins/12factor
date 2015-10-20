Introducción
============

En la época actual, el software se distribuye comunmente como un servicio: se le llama *web apps*, o *software as a service* (SaaS). "The twelve-factor app" es una metodología para construir aplicaciones SaaS que:

* Usan formatos **declarativos** para la automatización de la configuración, para minimizar el tiempo y el coste para los nuevos desarrolladores que se unan al proyecto;
* Tienen un **contrato claro** con el sistema operativo sobre el que trabaja, ofreciendo la **máxima portabilidad** entre los entornos de ejecución;
* Son apropiadas para **desplegarse** en modernas **plataformas en la nube**, obviando la necesidad de servidores y administración de sistemas;
* **Minimiza la divergencia** entre desarrollo y producción, posibilitando el **despliegue continuo** para conseguir la máxima agilidad;
* Y puede **escalar** sin cambios significativos para herramientas, arquitectura o practicas de desarrollo.

"The twelve-factor methodology"  puede ser aplicado a aplicaciones escritas en cualquier lenguaje de programación, y cualquier combinación de servicios de soporte (bases de datos, colas, memoria cache, etc).
