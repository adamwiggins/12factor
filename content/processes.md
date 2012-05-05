## VI. 进程
### 以一个或多个无状态进程(*process*)运行应用

在运行环境中，以一个或多个无状态进程运行应用程序。

最简单的场景中，代码是一个独立的脚本，运行环境是开发人员自己的笔记本电脑，进程由一条命令行(例如 `python my_script.py`)启动。相对的，另外一个极端情况是复杂的应用可能会使用很多 [进程类型](/concurrency) ，也就是多个进程实例。

**Twelve-factor应用的进程必须无状态且 [无共享](http://en.wikipedia.org/wiki/Shared_nothing_architecture) 。** 任何需要持久化的数据都要存储在 [后端服务](/backing-services) 内，比如数据库。

内存或硬盘的空间对于进程而言，应该是一个简单的，单项的缓存。例如用来下载一个很大的文件，对其操作并将结果写入数据库。Twelve-factor应用根本不用考虑这些缓存的内容是不是可以保留给之后的请求来使用，这是因为应用启动了多种类型的进程，将来的请求多半会由其他进程来服务。即使只有一个进程，你也别指望这些缓存的内容可以在机器重启（比如部署新的代码，修改配置文件，或是更换运行环境）后还可以保留。

源文件打包工具([Jammit](http://documentcloud.github.com/jammit/), [django-assetpackager](http://code.google.com/p/django-assetpackager/)) 使用文件系统来缓存编译过的源文件。Twelve-factor应用更倾向于在 [构建步骤](/build-release-run) 做此动作——正如 [Rails asset pipline](http://ryanbigg.com/guides/asset_pipeline.html) ，而不是在运行阶段。

一些互联网系统依赖于 [“粘性session”] (http://en.wikipedia.org/wiki/Load_balancing_%28computing%29#Persistence) ， 这是指将用户session中的数据缓存至某进程的内存中，并希望将来的同一用户被指向同一个进程。粘性Session是twelve-factor极力反对的。Session中可以用来记录诸如 [Memcached](http://memcached.org/) 或 [Redis](http://redis.io/) 过期时间的数据。

