## IV. 后端服务
### 把后端服务(*backing services*)当作附加资源

*后端服务* 是指任何需要应用程序通过网络与之通讯来维持应用自身正常运行的服务。示例包括数据存储(例如 [MySQL](http://dev.mysql.com/) 或 [CouchDB](http://couchdb.apache.org/))，消息/队列系统(例如 [RabbitMQ](http://www.rabbitmq.com/) 或 [Beanstalkd](http://kr.github.com/beanstalkd/))，发送外部邮件用到的SMPT服务([Postfix](http://www.postfix.org/))，以及缓存系统(例如 [Memcached](http://memcached.org/))。

类似数据库的后端服务，通常由部署应用程序的系统管理员一起管理。除了本地服务之外，应用程序有可能使用了第三方发布和管理的服务。示例包括SMPT(例如 [Postmark](http://postmarkapp.com/))，数据收集服务（例如 [New Relic](http://newrelic.com/) 或 [Loggly](http://www.loggly.com/)）， 以及使用API访问的服务(例如 [Twitter](http://dev.twitter.com/), [Google Maps](http://code.google.com/apis/maps/index.html), [Last.fm](http://www.last.fm/api))。

**twelve-factor应用的代码不会区分本地和第三方服务。** 对应用程序而言，两种都是附加资源，通过一个url或是其他存储在 [配置](/config) 中的服务定位/证书来获取数据。Twelve-factor应用的任意 [部署](/codebase) ，都应该可以在不进行任何代码改动的情况下，任意将本地MySQL数据库换作一个第三方的对应服务(例如 [Amazon RDS](http://aws.amazon.com/rds/))。类似的，本地SMTP服务应该也可以和第三方SMTP服务(例如Postmark)互换。上述2个例子中，仅仅配置中相关资源地址需要修改。

每个不同的后端服务是一份 *资源* 。例如，一个MySQL数据库是一个资源，两个MySQL数据库(用来数据分区)就被当作是2个不同的资源。Twelve-factor应用将这些数据库都视作 *附加资源* ，这些资源和它们附属的部署保持松耦合。

<img src="/images/attached-resources.png" class="full" alt="一种部署附加4个后端服务" />

资源可以按需的加载或卸载。例如，如果应用的数据库服务由于硬件问题出现异常，管理员可以从最近的备份中恢复一个数据库，卸载当前的数据库，然后加载新的数据库 -- 整个过程都不需要修改代码。

