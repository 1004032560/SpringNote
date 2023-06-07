## Docker



虚拟化容器技术：Docker基于镜像，可以秒级启动各种容器，每一个容器都是一个完整的运行环境，容器之间相互隔离。



Docker 主机（Host）：

Docker 客户端（Client）：

Docker 仓库（Repository）：本地用来存放下载的各种打包好的软件镜像

Docker 镜像（Image）：

Docker 容器（Container）：





## Docker安装

默认 CentOS 8。

#### 1、Docker删除

是否安装过 Docker，如果安装过可以使用 yum remove 进行删除。

```sh
yum remove docker \
   docker-client \
   docker-client-latest \
   docker-common \
   docker-latest \
   docker-latest-logrotate \
   docker-logrotate \
   docker-engine
```

#### 2、更新yum

```shell
yum update -y
```

#### 3、安装必备工具包

该命令的作用是安装一系列软件包，其中包括了 LVM 逻辑卷管理器的软件包，以及其他相关的依赖项和工具。通过执行该命令，系统可以获得使用 LVM 管理逻辑卷的相关功能和工具，从而实现对硬盘空间的更加灵活和高效的管理。

```shell
yum install -y yum-utils device-mapper-persistent-data lvm2
```

- `yum` 代表 Yellowdog Updater, Modified，是一个在 Fedora 和 RedHat 等发行版中的软件包管理器。
- `install` 表示要执行的操作是安装指定的软件包。
- `-y` 表示自动回答 "yes"，即在安装过程中不需要手动确认安装。
- `yum-utils` 是一个提供了 YUM 常用功能的扩展软件包，在本例中用于安装脚本工具等。
- `device-mapper-persistent-data` 是用于管理设备映射的软件包，它允许 LVM 逻辑卷管理器以及 Docker 等容器技术等使用设备映射来管理块设备。
- `lvm2` 是 Linux 的逻辑卷管理器软件包，可以用于创建、删除、调整和管理逻辑卷，支持快照、镜像等高级功能。

#### 4、配置阿里云的 yum 源

将阿里云提供的 Docker 官方镜像源的配置文件添加到系统中，以便在使用 yum 进行安装、升级和删除 Docker-ce 时，能够自动从该镜像源下载软件包。

```shell
yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

#### 5、安装docker-ce

```shell
yum install -y docker-ce docker-ce-cli containerd.io
```

- `docker-ce` 是 Docker 社区版的安装包，提供了 Docker 引擎和相关的 CLI 工具。
- `docker-ce-cli` 是 Docker 社区版的 CLI 工具安装包，提供了运行 Docker 命令所需的命令行工具。
- `containerd.io` 提供了容器运行时软件，是 Docker 依赖的一个组件。

#### 6、开机自启

```shell
systemctl enable docker
```

#### 7、启动docker

```shell
systemctl start docker
```

### 8、查看版本

```shell
docker -v

Docker version 23.0.3, build 3e7cbfd
```
