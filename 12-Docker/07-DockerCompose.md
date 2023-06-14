## DockerCompose

### 1、docker-compose简介

`Docker Compose` 是 Docker 官方编排（Orchestration）项目之一，负责快速的部署分布式应用。

一致通过 Dockerfile 文件可以快速创建出一个 Docker 镜像快速启动一个单独的应用容器。但是在实际开发中，应用往往都不是单独存在的，还需要其他应用的支持和协助。例如要实现一个 Web 项目，除了 Web 服务容器本身，往往还需要再加上后端的数据库服务容器，甚至还包括负载均衡容器等。

因此出现了 `Docker Compose`。他的作用是允许用户通过一个单独的 `docker-compose.yml` 模板文件来定义一组相关联的应用容器为一个项目（project）。一个文件，两个要素。

 `Docker Compose` 中有两个重要的概念：

- 服务 (`service`)：一个应用的容器，实际上可以包括若干运行相同镜像的容器实例。
- 项目 (`project`)：由一组关联的应用容器组成的一个完整业务单元，在 `docker-compose.yml` 文件中定义。

可见，一个项目可以由多个服务（容器）关联而成，`Compose` 面向项目进行管理。

`Docker Compose` 的默认管理对象是项目，通过子命令对项目中的一组容器进行便捷地生命周期管理。

`Docker Compose` 项目由 Python 编写，实现上调用了 Docker 服务提供的 API 来对容器进行管理。因此，只要所操作的平台支持 Docker API，就可以在其上利用 `Docker Compose` 来进行编排管理。



### 2、docker-compose安装配置

执行 `docker-compose -v` 命令

会报错：`-bash: docker-compose: command not found`

但是 Docker 在新版本中 23+ 默认已经安装了 docker-compose 了，不需要额外安装了。 输入  `docker info` 后，可以看到 compose 中是存在 Docker Compose 的

```shell
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.10.4
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.17.2
    Path:     /usr/libexec/docker/cli-plugins/docker-compose
```

所以需要对 docker-compose 进行一个类似于环境变量的配置

#### 2.1、创建软链接

执行 `docker info ` 后，查看 docker-compose 插件所在位置，我的是在 `/usr/libexec/docker/cli-plugins/docker-compose`，创建软链接 `/usr/bin/docker-compose` 地址指向真正的 docker-compose 所在的位置

```shell
ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/bin/docker-compose
```

如果软链接创建错了，可以使用 rm 进行删除。但是有个小细节必须要特别注意！

```shell
rm -fr xxxx/ # 加了个 / 表示删除文件夹

rm -fr xxxx  # 没有加 / 表示删除软链接
```

#### 2.2、查看docker-compose版本

```shell
docker-compose -v

Docker Compose version v2.17.2
```

docker-compose 配置成功。



### 3、docker-compose常用命令

~~~shell
docker compose --help             # 查看帮助命令

docker compose up                 # 启动所有的 docker-compose 服务
docker compose up -d              # 启动所有的 docker-compose 服务，并在后台运行

docker compose down               # 停止并删除容器、网络、卷和镜像

docker compose exec yml里的服务id   # 进入 docker-compose 服务实例内部

docker compose ps                  # 查看 docker-compose 编排过所正在运行的容器
docker compose top                 # 查看 docker-compose 编排过所正在运行的容器的进程

docker compose logs yml里的服务id    # 查看 docker-compose 编排容器的日志

docker compose config               # 查看 docker-compose 编排容器的配置
docker compose config -q            # 查看 docker-compose 编排容器的配置，有问题才有输出

docker compose start
docker compose restart
docker compose stop
~~~



### 4、docker-compose编排服务

#### 4.1、编写docker-compose.yml文件

~~~shell
version: "3"
services:
  microService:
    image: ruoyi-admin:1.0
    container_name: ms01
    ports:
      - "8080:8080"
    volumes:
      - /app/microService:/data
    network:
      - ruoyi_network
    depends_on:
      - redis
      - mysql
  
  redis:
  	image: redis:6.0.8
  	ports: 
  	  - "6379:6379"
  	volumes:
  	  - /app/redis/redis.conf:/etc/redis/redis.conf
  	  - /app/redis/data:/data
  	network:
      - ruoyi_network
    command: redis-server /etc/redis/redis.conf
    
  mysql:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: '123456'
      MYSQL_ALLOW_EMPTY_PASSWORD: 'no'
      MYSQL_DATABASE: 'db-ruoyi'
      MYSQL_USER: 'ruoyi'
      MYSQL_PASSWORD: 'ruoyi123456'
  	ports: 
  	  - "3306:3306"
  	volumes:
  	  - /app/mysql/db:/var/lib/mysql
  	  - /app/mysql/conf/my.cnf:/etc/my.cnf
  	  - /app/mysql/init:/docker-entrypoint-initdb.d
  	network:
      - ruoyi_network
    command: --default-authentication-plugin=mysql_natice_password # 解决外部无法访问问题

# 先定义再使用。类似于先执行命令 docker network create ruoyi_network
networks:
  ruoyi_network
~~~



#### 4.2、执行docker-compose命令

执行 `docker compose config -q` 如果没输出任何信息，则表示编排的 `docker-compose.yml` 文件没有问题。

再执行 `docker compose up -d` 对项目进行启动。

