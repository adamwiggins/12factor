## VI. Processos
### Execute a aplicação como um ou mais processos que não armazenam estado

A aplicação é executada em um ambiente de exeução como um ou mais *processos*.

No caso mais simples, o código é um script autônomo, o ambiente de excução é o laptop local de um desenvolvedor com o runtime da linguagem instalado, e o processo é iniciado pela linha de comando (por exemplo, `python my_script`). Na outra extremidade do espectro, o deploy em produção de uma aplicação sofisticada pode utilizar vários [tipos de processos, instanciado em zero ou mais processos em andamento](./concurrency).

**Processos twelve-factor são stateless(não armazenam estado) e [share-nothing](http://en.wikipedia.org/wiki/Shared_nothing_architecture).** Quaisquer dados que precise persistir deve ser armazenado em um serviço de apoio stateful(que amazena o seu estado), tipicamente uma base de dados.

O espaço de memória ou sistema de arquivos do processo pode ser usado como um breve, cache de transacção única. Por exemplo, o download de um arquivo grande, operando sobre ele, e armazenando os resultados da operação no banco de dados. A aplicação twelve-factor nunca assume que qualquer coisa cacheada na memória ou no disco estará disponível em um futuro request ou job -- com muitos processos de cada tipo rodando, as chances são altas de que um futuro request será servido por um processo diferente. Mesmo quando rodando em apenas um processo, um restart (desencadeado pelo deploy de um código, mudança de configuração, ou o ambiente de execução realocando o processo para uma localização física diferente) geralmente vai acabar com todo o estado local (por exemplo, memória e sistema de arquivos). 

Empacotadores de assets (como [Jammit](http://documentcloud.github.com/jammit/) ou [django-assetpackager](http://code.google.com/p/django-assetpackager/)) usa o sistema de arquivos como um cache para assets compilados. Uma aplicação twelve-factor prefere fazer isto compilando durante a [fase de build](./build-release-run), tal como o [Rails asset pipeline](http://ryanbigg.com/guides/asset_pipeline.html), do que em tempo de execução. 

Some web systems rely on ["sticky sessions"](http://en.wikipedia.org/wiki/Load_balancing_%28computing%29#Persistence) -- that is, caching user session data in memory of the app's process and expecting future requests from the same visitor to be routed to the same process.  Sticky sessions are a violation of twelve-factor and should never be used or relied upon.  Session state data is a good candidate for a datastore that offers time-expiration, such as [Memcached](http://memcached.org/) or [Redis](http://redis.io/).

Alguns sistemas web dependem de ["sessões persistentes"](http://en.wikipedia.org/wiki/Load_balancing_%28computing%29#Persistence) -- ou seja, fazem cache dos dados da sessão do usuaŕio na memória do processo da aplicação, esperando futuras requisições do mesmo visitante para serem encaminhadas para o mesmo processo. Sessões persistentes são uma violação do twelve-factor e nunca devem ser utilizadas ou invocadas. Dados do estado da sessão é um bom canditado para um datastore que oferece tempo de expiração, tal como [Memcached](http://memcached.org/) ou [Redis](http://redis.io/).       

