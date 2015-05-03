## VIII. Concorrência
### Escale através do processo modelo

Qualquer programa de computador, uma vez executado, está representado por um ou mais processos. Aplicações web têm tomado uma variedade de formas de processo de execução. Por exemplo, processo PHP rodam como processos filho do Apache, iniciados sob demanda conforme necessário por volume de requisições. Processos Java tomam o caminho inverso, com a JVM proporcionando um processo uber maciço que reserva um grande bloco de recursos do sistema (CPU e memória) na inicilização, com concorrência gerenciada internamente via threads. Em ambos os casos, o processo(os) executando é apenas minimamente visível para o desenvolvedores da aplicação.

![Escala é expressado como processos em execução, a diversidade da carga de trabalho é expressada como tipos de processo.](/images/process-types.png)

**Na aplicação twelve-factor, processos são cidadãos de primeira classe.**  Processos na aplicação twelve-factor tomam fortes sinais do [modelo de processo unix para a execução de serviços daemons](http://adam.heroku.com/past/2011/5/9/applying_the_unix_process_model_to_web_apps/). Usando este modelo, o desenvolvedor pode arquitetar a aplicação dele para lidar com diversas cargas de trabalho, atribuindo a cada tipo de trabalho a um *tipo de processo*. Por exemplo, solicitações HTTP podem ser manipuladas para um processo web, e tarefas background de longa duração podem ser manipuladas por um processo trabalhador.  

This does not exclude individual processes from handling their own internal multiplexing, via threads inside the runtime VM, or the async/evented model found in tools such as [EventMachine](http://rubyeventmachine.com/), [Twisted](http://twistedmatrix.com/trac/), or [Node.js](http://nodejs.org/).  But an individual VM can only grow so large (vertical scale), so the application must also be able to span multiple processes running on multiple physical machines.

The process model truly shines when it comes time to scale out.  The [share-nothing, horizontally partitionable nature of twelve-factor app processes](./processes) means that adding more concurrency is a simple and reliable operation.  The array of process types and number of processes of each type is known as the *process formation*.

Twelve-factor app processes [should never daemonize](http://dustin.github.com/2010/02/28/running-processes.html) or write PID files.  Instead, rely on the operating system's process manager (such as [Upstart](http://upstart.ubuntu.com/), a distributed process manager on a cloud platform, or a tool like [Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) in development) to manage [output streams](./logs), respond to crashed processes, and handle user-initiated restarts and shutdowns.
