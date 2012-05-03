## II. 依赖
### 明确的声明和剥离依赖(*dependency*)

大多数编程语言都会提供一个打包系统，用来为各个类库提供打包服务，就像Perl的 [CPAN](http://www.cpan.org/) 或是Ruby的 [Rubygems](http://rubygems.org/) 。打包系统安装的这些类库可以选择全系统生效（称之为"site packages"）或仅在需要时将路径包含进来（称之为"vendoring"或"bunding"）。

**一个应用遵守twelve-factor意味着永远不信任系统类库中的隐藏内容** 它一定通过 *依赖声明* 清单，完整而又准确的声明了所有依赖。此外，在运行过程中通过一个 *依赖剥离* 工具来确保系统中没有“遗漏”的依赖冲突。完整而明确的依赖规范，统一适用于生产和开发环境。

例如， [Gem Bundler](http://gembundler.com/) 为Ruby提供了`Gemfile`清单从而规范了依赖声明的格式，以及`bundle exec`来剥离依赖。在Python中，有2个独立的工具来分别做这2件事情 -- [Pip](http://www.pip-installer.org/en/latest/) 用来声明， [Virtualenv](http://www.virtualenv.org/en/latest/) 用来剥离。甚至C语言也有 [Autoconf](http://www.gnu.org/s/autoconf/) 来声明依赖，静态链接提供剥离帮助。无论用什么工具，依赖的声明和剥离总是一起使用 -- 其中的任意一个都不是满足twelve-factor的充分条件。

明确的声明依赖所带来的好处之一是，为应用的新开发者简化了配置流程。新的开发者可以签出应用的代码库到开发机器，仅仅需要一个编程语言环境和它对应的依赖管理工具即可开始工作。只需要一些固定的 *构建命令* ，它们可以帮你装好代码中所需的一切。例如，Ruby/Bundler的构建命令是`bundle install`，而Clojure/[Leiningen](https://github.com/technomancy/leiningen#readme) 对应的则是`lein deps`。

Twelve-factor应用同样不会不信任那些隐藏着的系统工具。这其中包括ImageMagick或是`curl`。即使这些工具存在于很多甚至决大多数系统，但终究无法保证所有系统都能支持应用顺利运行，或者说将来的系统是否兼容现有版本。假设应用必须使用系统工具，那么就将这个工具完整的包含进来。
