## III. Configurazione
### Memorizza le informazioni di configurazione nell'ambiente

La "configurazione" di un'applicazione è tutto quello che può variare da un [deploy](./codebase) all'altro (staging, production, ambienti di sviluppo). Ad esempio:

* Valori da usare per connettersi ad un database, Memcached, oppure altri [backing service](./backing-services);
* Credenziali per servizi esterni, come Amazon S3 o Twitter;
* Valori eventualmente definiti per i singoli deploy, come l'hostname;

Molto spesso, queste informazioni vengono memorizzate come costanti nel codice: la cosa viola la metodologia twelve-factor, che richiede una **separazione ben definita delle impostazioni di configurazione dal codice**. Le impostazioni possono infatti variare da un deploy all'altro: il codice, invece, no.

Il codice dell'applicazione, infatti, potrebbe essere reso open-source in ogni momento: un buon motivo per separare le due cose.

Nota che comunque la definizione di "configurazione" **non** include eventuali configurazione interne dell'applicazione, come `config/routes.rb` in Rails, o come [i moduli di codice sono connessi](http://static.springsource.org/spring/docs/2.5.x/reference/beans.html) in [Spring](http://www.springsource.org/). Questo tipo di configurazione non varia da deploy a deploy: come giusto che sia, quindi, rimane nel codice.

Un ottimo approccio al "rispetto" di questo principio consiste nell'usare dei file di configurazione non coinvolti dal version control, come ad esempio `config/database.yml` in Rails. Stiamo parlando di un miglioramento enorme rispetto all'uso di costanti nel codice, ma c'è da dire la cosa ha il suo lato negativo: basta poco per sbagliarsi ed includere nel repo il file di configurazione che, invece, non dovrebbe essere lì. C'è una certa tendenza, infatti, a non avere tutti i file di configurazione necessari nello stesso posto. Inoltre, i vari formati tendono ad essere collegati ad un certo linguaggio/framework.

**L'applicazione che rispetta la metodologia twelve-factor memorizza tutte le impostazioni in *variabili d'ambiente*** (spesso dette *env vars* o *env*). Le variabili d'ambiente sono molto semplici da cambiare di deploy in deploy senza dover toccare il codice direttamente. Inoltre, a differenza dei file di configurazione classici, c'è una probabilità molto bassa di venire inclusi nel repo. Infine, questi file sono indipendenti sia dal linguaggio che dal sistema operativo utilizzato.

Un altro aspetto del config management è il raggruppamento. A volte, infatti, alcune applicazioni prevedono la memorizzazione delle impostazioni in gruppi (chiamati spesso "ambienti") dal nome ben preciso: "development", "test" e "production", ad esempio. Questo metodo non scala correttamente, se ci pensi: potrebbero essere necessari nuovi ambienti, come "staging" e "qa". Oppure, i vari sviluppatori potrebbero aver bisogno di creare i propri ambienti "speciali", come "joes-staging" e così via. Il risultato? Una quantità di combinazioni ingestibile e disordinata.

In una buona twelve-factor app, le variabili di ambiente sono controllate in modo più "granulare", in modo totalmente ortogonale alle altre. Non sono mai raggruppate e classificate sotto "ambienti" specifici, ma vengono gestite in modo totalmente indipendente per ogni deploy. Il prodotto finale ne risente positivamente in termini di scalabilità.