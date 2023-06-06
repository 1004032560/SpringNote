## Docker



虚拟化容器技术：Docker基于镜像，可以秒级启动各种容器，每一个容器都是一个完整的运行环境，容器之间相互隔离。



Docker 主机（Host）：

Docker 客户端（Client）：

Docker 仓库（Repository）：本地用来存放下载的各种打包好的软件镜像

Docker 镜像（Image）：

Docker 容器（Container）：





## Docker安装

默认 CentOS 8，Linux 操作系统







## Docker安装Nginx

### 1、查找 Nginx 镜像

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker search nginx
NAME                      DESCRIPTION                            STARS
nginx                     Official build of Nginx.               16867
linuxserver/nginx         An Nginx container, brought...         168
bitnami/nginx             Bitnami nginx Docker Image             131
~~~

### 2、下载 Nginx 镜像

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
a2abf6c4d29d: Pull complete 
a9edb18cadd1: Pull complete 
589b7251471a: Pull complete 
186b1aaa4aa6: Pull complete 
b4df32aa5a72: Pull complete 
a0bcbecc962e: Pull complete 
Digest: sha256:0d17b565c37bcbd895e9d92315a05c1c3c9a29f762b011a10c54a66cd53c9b31
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest
~~~

### 3、启动 Nginx

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -d --name nginx01 -p 3344:80 nginx
66d71b16468c3ebf6dcf1291a0aa2d80de5286bb36db247281582ea56b0085b0
~~~

### 4、测试访问 Nginx

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# curl localhost:3344
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
~~~





## Docker安装Tomcat

### 1、启动Tomcat

~~~shell
# 之前都是启动容器之后，在后台运行，现在官方使用命令，用完即删除，一般用于测试
docker run -it --rm tomcat:9.0
# 启动 Tomcat，执行run命令是会自动下载不存在的镜像
docker run -it -p 3355:8080 --name tomcat01 tomcat
~~~

### 2、通过外网访问Tomcat

~~~shell
# 通过阿里云下载的 Tomcat 属于阉割版的，不会下载一些不必要的内容所有 webapps 下边没有内容
# 解决方式
# 进入Tomcat容器内
docker exec -it tomcat01 /bin/bash
# 把 webapps.dist 中的内容 copy 到 webapps 中，即可通过外网访问 tomcat 主页
cp -r webapps.dist/* webapps
~~~





## Docker镜像

### 1、镜像是什么

镜像（Image）是一种轻量级、可执行的独立软件包，包含了软件运行所需要的运行环境和内容（代码、运行是库、环境变量以及配置文件等）。

所有应用打包成 Docker 镜像，就可以直接运行起来。

镜像的来源：从远程仓库下载；从其他服务器拷贝镜像；自己制作一个镜像。



### 2、镜像加载原理

#### 2.1、联合文件系统UnionFS

UnionFS（联合文件系统）：是 Linux 中一种分层的，轻量级的高性能文件系统，它支持对文件系统的修改作为一次提交，来一层层的进行叠加（类似于 Git 对每次修改的代码进行版本控制），同时可以将不同的目录挂载到同一个虚拟文件系统下。

UnionFS 文件系统是 Docker 镜像的基础。Docker 可以通过分层思想对基础镜像改造出各种的具体应用镜像。

特性：一次同时加载多个文件系统，但是从外边看起来，只能看到一个文件系统；联合加载会吧各层文件系统叠加起来，这样最终的文件系统会包含所有底层文件和目录。



#### 2.2、镜像加载原理

Docker 的镜像实际上由一层一层的文件系统组成，这种层级的文件系统 UnionFS。

BootFS（Boot File System）主要包含 Bootloader（Boot 加载器） 和 Kernel（内核），Bootloader 主要是引导加载 Kernel，Linux  刚启动时会加载 BootFS文件系统，在 Docker 镜像的最底层是 BootFS。这一层与我们典型的 Linux/Unix 系统是一样的，包含 Boot 加载器和内核。当 Boot 加载完成之后整个内核就都在内存中了，此时内存的使用权已由 BootFS 转交给内核，此时系统也会卸载 BootFS。

RootFS（Root File System），在 BootFS 之上。包含的就是典型 Linux 系统中的 /dev，/proc，/bin，/etc 等标准目录和文件。RootFS就是各种不同的操作系统发行版，比如 Ubuntu , Centos 等等。



#### 2.3、分层理解

通过 Docker pull 下载镜像的时候是分层下载的。这样下载的好处：复用，节省磁盘空间，相同的内容只需加载一份到内存。

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker pull redis
Using default tag: latest
latest: Pulling from library/redis
a2abf6c4d29d: Already exists # 已经下载过的就不会再下载了
c7a4e4382001: Pull complete # 下载当前版本镜像特有的内容
4044b9ba67c9: Pull complete 
c8388a79482f: Pull complete 
413c8bb60be2: Pull complete 
1abfd3011519: Pull complete 
# 镜像签名
Digest: sha256:db485f2e245b5b3329fdc7eff4eb00f913e09d8feb9ca720788059fdc2ed8339
Status: Downloaded newer image for redis:latest
docker.io/library/redis:latest
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
redis         latest    7614ae9453d1   5 months ago   113MB
hello-world   latest    feb5d9fea6a5   8 months ago   13.3kB
centos        latest    5d0da3dc9764   8 months ago   231MB
# 查看 Redis 镜像的元数据
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker inspect 7614ae9453d1
......
"RootFS": {
            "Type": "layers",
            "Layers": [
            	# 镜像层级，对应 docker pull 时的下载过程的层级
                "sha256:2edcec3590a4ec7f40cf0743c15d78fb39d8326bc029073b41ef9727da6c851f",
                "sha256:9b24afeb7c2f21e50a686ead025823cd2c6e9730c013ca77ad5f115c079b57cb",
                "sha256:4b8e2801e0f956a4220c32e2c8b0a590e6f9bd2420ec65453685246b82766ea1",
                "sha256:529cdb636f61e95ab91a62a51526a84fd7314d6aab0d414040796150b4522372",
                "sha256:9975392591f2777d6bf4d9919ad1b2c9afa12f9a9b4d260f45025ec3cc9b18ed",
                "sha256:8e5669d8329116b8444b9bbb1663dda568ede12d3dbcce950199b582f6e94952"
            ]
        }
......
# 查看 CentOS 镜像的元数据
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker inspect 5d0da3dc9764
......
	# CentOS 镜像签名
    "Id": "sha256:5d0da3dc976460b72c77d94c8a1ad043720b0416bfc16c52c45d4847e53fadb6",
    "RepoTags": [
        "centos:latest"
    ]
......
~~~



#### 2.4、Commit镜像

自己制作一个镜像，进行提交，可以在原有的镜像的基础上，对该镜像进行修改之后，以后其他服务器就可以用这个修改后的镜像，无需再次修改镜像内容（以安装的 Tomcat 镜像为例，修改了 webapps 目录里的内容，生成一个自己的镜像）

镜像分层类似于 Git 的版本控制，Linux 快照；状态内容更新之后，会有个版本记录可以回到之前的状态内容。

通过 DockerFile 也可以进行镜像创建。

~~~shell
# 提交修改过的 Docker 容器; -a 作者; -m 描述信息; 类似于 Git 提交代码控制版本信息
docker commit -a="作者" -m="描述" 容器Id(e30fa0ebaa5b) 新镜像名:版本号

#####################################################################

[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker ps
CONTAINER ID  IMAGE   COMMAND            CREATED       STATUS        PORTS                    NAMES
e30fa0ebaa5b  tomcat  "catalina.sh run"  18 hours ago  Up 6 minutes  0.0.0.0:3355->8080/tcp   tomcat01
# 提交修改后的 tomcat00 镜像
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker commit -a="looper" -m="add webapps" e30fa0ebaa5b tomcat00:1.0
# 提交后返回一个签名
sha256:d543f21d737ca34ebf2abceb8fe39e2fbf459930b4fcbd93617987c146df1b3b
# 查看本地现有的镜像，其中就包含 tomcat00 版本号为 1.0
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
tomcat00      1.0       d543f21d737c   2 seconds ago   684MB
tomcat        latest    fb5657adc892   5 months ago    680MB
~~~





## Docker容器数据卷

### 1、数据卷

为了防止容器被删除之后，造成容器内的数据丢失，所以通过容器数据卷技术，将容器内的数据同步到容器外部的 Linux 操作系统上。

总结：容器和主机之间的数据同步操作（持久化），容器和容器之间也可以数据共享。

主机和容器之间挂载好之后，停止运行容器，修改主机指定目录下的内容，容器内部也会自动修改



### 2、使用数据卷

#### 2.1、使用命令进行挂载

文件挂载是将宿主机的指定文件挂载到 Docker 容器中的文件，文件位置由用户自行管理。

数据卷挂载的目录是由Docker管理的，优点是位置统一，操作简单一些。

~~~shell
# 容器数据卷通过 -v, --volume list 命令, 将容器和主机之间的数据相互同步
docker run -it -v 主机目录:容器目录 镜像Id /bin/bash

#####################################################################

[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -it -v /home/test:/home centos /bin/bash
[root@f6723156a6d3 /]# cd home
[root@f6723156a6d3 home]# ls
# 容器内部 /home 目录下添加 Test.java 文件
[root@f6723156a6d3 home]# touch Test.java
[root@f6723156a6d3 home]# ls
Test.java

# 主机 /home/test 目录下自动同步数据
[root@iZ2ze4jen9kd2w1c52zfe0Z test]# ls
[root@iZ2ze4jen9kd2w1c52zfe0Z test]# ls 
Test.java

# 查看 CentOS 容器的元数据
[root@iZ2ze4jen9kd2w1c52zfe0Z test]# docker inspect f6723156a6d3
......
"Mounts": [
            {
                "Type": "bind",
                # 源
                "Source": "/home/test",
                # 目标
                "Destination": "/home",
                "Mode": "",
                "RW": true,
                "Propagation": "rprivate"
            }
        ]
......
~~~



### 3、数据卷优缺点

优点：修改文件只需要在本地修改即可，不需要每次都进入到容器内部。

缺点：占用存储空间，容器内部数据量特别大时，主机占用的数据量也很大。



### 4、匿名挂载和具名挂载

#### 4.1、匿名挂载

~~~shell
# -P 大写P, 随机指定端口号
# -v /etc/nginx 后边的目录是容器内部目录
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -d -P --name nginx02 -v /etc/nginx nginx
0bbcb5a31ef353aaa185a0f47ffa06b0a5e81be1b6bd8e0f5b09ac0614afdb95
# 查看所有的匿名挂载；每个 VOLUME NAME 都是一个存在的目录
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker volume ls
DRIVER     VOLUME NAME 
		  # 未指定具体名字
local     070dfc7c118191140fa7a5fc653cd6033d32711d9a320d5d1065437aee8dd427
~~~



#### 4.2、具名挂载

~~~shell
# -P 大写P, 随机指定端口号
# -v this_nginx:/etc/nginx (this_nginx) 指定具体的目录名字
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -d -P --name nginx03 -v this_nginx:/etc/config nginx
8ebbab0748e70e82624cb8b77bd87b893e672747296f719e7544e4058d2e8f91
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker volume ls
DRIVER    VOLUME NAME
local     070dfc7c118191140fa7a5fc653cd6033d32711d9a320d5d1065437aee8dd427
		  # 指定具体名字
local     this_nginx
~~~



#### 4.3、挂载路径

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker volume ls
DRIVER    VOLUME NAME
local     070dfc7c118191140fa7a5fc653cd6033d32711d9a320d5d1065437aee8dd427
local     this_nginx
# 根据挂载的名字查找路径
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker volume inspect this_nginx
[
    {
        "CreatedAt": "2022-05-30T21:30:46+08:00",
        "Driver": "local",
        "Labels": null,
        # 真实路径
        "Mountpoint": "/var/lib/docker/volumes/this_nginx/_data",
        "Name": "this_nginx",
        "Options": null,
        "Scope": "local"
    }
]
# 根据挂载的名字查找路径
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker volume inspect 070dfc7c118191140fa7a5fc653cd6033d32711d9a320d5d1065437aee8dd427
[
    {
        "CreatedAt": "2022-05-30T19:43:48+08:00",
        "Driver": "local",
        "Labels": null,
        # 真实路径
        "Mountpoint": "/var/lib/docker/volumes/070dfc7c118191140fa7a5fc653cd6033d32711d9a320d5d1065437aee8dd427/_data",
        "Name": "070dfc7c118191140fa7a5fc653cd6033d32711d9a320d5d1065437aee8dd427",
        "Options": null,
        "Scope": "local"
    }
]
~~~

挂载路径一般在 /var/lib/docker/volumes/（具名or匿名）/_data 目录下

判断是匿名挂载还是具名挂载

> -v /容器内路径                      匿名挂载
>
> -v 卷名:/容器内路径             具名挂载
>
> -v /主机路径:/容器内路径    指定路径挂载

通过 -v 容器内路径:ro/rw 来改变读写权限；如果设置了读写权限，就会

ro：read-only

rw：read-write

> docker run -d -P --name nginx03 -v this_nginx:/etc/config:ro nginx
>
> docker run -d -P --name nginx03 -v this_nginx:/etc/config:rw nginx



#### 4.4、数据卷容器

先看 DockerFile 章节第一二节，再看此节内容。容器之间的挂载数据同步。

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker images
REPOSITORY      TAG       IMAGE ID       CREATED        SIZE
looper/centos   1.0       47762f1907a9   12 hours ago   231MB
tomcat00        1.0       d543f21d737c   19 hours ago   684MB
nginx           latest    605c77e624dd   5 months ago   141MB
tomcat          9.0       b8e65a4d736d   5 months ago   680MB
tomcat          latest    fb5657adc892   5 months ago   680MB
redis           latest    7614ae9453d1   5 months ago   113MB
mysql           5.7       c20987f18b13   5 months ago   448MB
hello-world     latest    feb5d9fea6a5   8 months ago   13.3kB
centos          latest    5d0da3dc9764   8 months ago   231MB
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -it --name docker01 looper/centos
Unable to find image 'looper/centos:latest' locally
^Z
[1]+  Stopped                 docker run -it --name docker01 looper/centos
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -it --name docker01 looper/centos:1.0
[root@25e1fef5a34e /]# ls     
bin  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var  volume01  volume02
[root@25e1fef5a34e /]# [root@iZ2ze4jen9kd2w1c52zfe0Z /]# 
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS     NAMES
25e1fef5a34e   looper/centos:1.0   "/bin/sh -c /bin/bash"   20 seconds ago   Up 19 seconds             docker01
# 通过 --volume-from 容器名，将指定容器挂载
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -it --name docker02 --volumes-from docker01 looper/centos:1.0
[root@18feb341c972 /]# ls
bin  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var  volume01  volume02

#####################################################################

[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker ps
CONTAINER ID   IMAGE               NAMES
18feb341c972   looper/centos:1.0   docker02
25e1fef5a34e   looper/centos:1.0   docker01
# 用 Docker inspect 检查 2 个容器会发现其实都映射到了宿主机的相同目录
# Docker02 容器删除之后，Docker01 仍然会存在数据
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker inspect 25e1fef5a34e
"Mounts": [
            {
                "Type": "volume",
                "Name": "61aa40db830504f8ebdf4e5f95d09581eebe333bf869edbf7b2766f8698fe4da",
                "Source": "/var/lib/docker/volumes/61aa40db830504f8ebdf4e5f95d09581eebe333bf869edbf7b2766f8698fe4da/_data",
                "Destination": "volume01",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            },
            {
                "Type": "volume",
                "Name": "ffbf0d122390611a6470bada078e8d2b1665e7731e519db80508141242a6c4f9",
                "Source": "/var/lib/docker/volumes/ffbf0d122390611a6470bada078e8d2b1665e7731e519db80508141242a6c4f9/_data",
                "Destination": "volume02",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
        ]
.......
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker inspect 25e1fef5a34e
.......

        "Mounts": [
            {
                "Type": "volume",
                "Name": "61aa40db830504f8ebdf4e5f95d09581eebe333bf869edbf7b2766f8698fe4da",
                "Source": "/var/lib/docker/volumes/61aa40db830504f8ebdf4e5f95d09581eebe333bf869edbf7b2766f8698fe4da/_data",
                "Destination": "volume01",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            },
            {
                "Type": "volume",
                "Name": "ffbf0d122390611a6470bada078e8d2b1665e7731e519db80508141242a6c4f9",
                "Source": "/var/lib/docker/volumes/ffbf0d122390611a6470bada078e8d2b1665e7731e519db80508141242a6c4f9/_data",
                "Destination": "volume02",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
        ]
.......
~~~





## Docker安装MySQL

### 1、搜索镜像

docker search mysql

### 2、下载镜像

docker pull mysql:5.7

### 3、启动镜像

~~~shell
# 启动 MySQL 镜像；对 MySQL 配置文件和数据进行挂载；同时需要设置 MySQL 的密码
# -d 后台运行
# -p 端口号映射
# -v 数据卷挂载
# -e 环境配置
# --name 配置容器名
docker run -d -p 3366:3306 -v /home/mysql/conf:/etc/mysql/conf.d -v /home/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=looper123456 --name mysql01 mysql:5.7
a53bc3b84a2cbbef0a622695550712b303c5189b2c7f4bb5b0149fa4648fa457
~~~

### 4、测试连接

在 Navicat （或者其他的数据库客户端）上进行连接测试即可。Navicat 中创建 test_docker_sql 数据库，新建 student 表。

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z data]# cd /
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# cd /home/mysql/data
# 主机的 date 目录中也就有了新建的 test_docker_sql 数据库了
[root@iZ2ze4jen9kd2w1c52zfe0Z data]# ls
auto.cnf    ca.pem           client-key.pem  ibdata1      ib_logfile1  mysql               private_key.pem  server-cert.pem  sys
ca-key.pem  client-cert.pem  ib_buffer_pool  ib_logfile0  ibtmp1       performance_schema  public_key.pem   server-key.pem   test_docker_sql
# 数据库中有 student 表
[root@iZ2ze4jen9kd2w1c52zfe0Z test_docker_sql]# ls
db.opt  student.frm  student.ibd
~~~





## DockerFile

DockerFile 就是用来构建 Docker 镜像的构建文件，命令脚本。

通过 DockerFile 可以生成镜像，生成镜像的同时可以挂载目录。

可以通过 DockerFile 构建自己个性化的 Docker 镜像；例如：CentOS + Nginx + Tomcat + MySQL + Redis + ElasticSearch 这样一个体系的环境。



### 1、DockerFile 指令

DockerFile 指令关键字，通过关键字控制生成所需要的镜像。

~~~shell
FROM               # 基础镜像; 新制作的镜像是基于什么镜像制作的，一般都是基于 CentOS
MAINTANER          # 镜像的作者，维护者; 格式: 姓名+邮箱
RUN                # Docker镜像构建的时候需要运行的命令
ADD                # 添加步骤，将需要的东西添加进去；Redis，MySQL 压缩包之类的
WORKDIR            # 工作目录
COLUME             # 挂载目录
EXPOSE             # 端口配置
CMD                # 指定容器启动的时候运行的命令，只有最后一个命令会生效
ENTRYPONT          # 指定容器启动的时候运行的命令，可以追加命令
OBBUILD            # 当构建一个被继承的 DockerFile 时这个命令就会运行，触发指令
COPY               # 类似于 ADD ，将文件拷贝到镜像中
ENV                # 构建的时候设置环境变量，
~~~



### 2、准备DockerFile文件

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z docker_test_volume]# pwd
/home/docker_test_volume
# 创建 DockerFile 文件，名字随机，最好见名知意
[root@iZ2ze4jen9kd2w1c52zfe0Z docker_test_volume]# vim dockerfile01
[root@iZ2ze4jen9kd2w1c52zfe0Z docker_test_volume]# cat dockerfile01 
# 文件的内容  指令（忽略大小写，推荐大写） 参数
FROM centos


VOLUME ["volume01", "volume02"]


CMD echo "---------------end--------------"


CMD /bin/bash

~~~



### 3、构建DockerFile内容

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z docker_test_volume]# docker build -f /home/docker_test_volume/dockerfile01 -t looper/centos:1.0 .   
Sending build context to Docker daemon  2.048kB
# 第一步：提供有一个基础的镜像
Step 1/4 : FROM centos
 ---> 5d0da3dc9764
# 第二步：通过 VOLUME 进行挂载
Step 2/4 : VOLUME ["volume01", "volume02"]
 ---> Running in deee5d01328a
Removing intermediate container deee5d01328a
 ---> 1961255fb573
# 第三步：执行脚本程序中的命令
Step 3/4 : CMD echo "---------------end--------------"
 ---> Running in a90163472bc8
Removing intermediate container a90163472bc8
 ---> 2d921fdc5780
# 第三步：进入 /bin/bash
Step 4/4 : CMD /bin/bash
 ---> Running in 3ade91186871
Removing intermediate container 3ade91186871
 ---> 47762f1907a9
Successfully built 47762f1907a9
Successfully tagged looper/centos:1.0
[root@iZ2ze4jen9kd2w1c52zfe0Z docker_test_volume]# docker images
REPOSITORY      TAG       IMAGE ID       CREATED          SIZE
# 自己制作的镜像
looper/centos   1.0       47762f1907a9   38 minutes ago   231MB
tomcat00        1.0       d543f21d737c   7 hours ago      684MB
nginx           latest    605c77e624dd   5 months ago     141MB
tomcat          9.0       b8e65a4d736d   5 months ago     680MB
redis           latest    7614ae9453d1   5 months ago     113MB
centos          latest    5d0da3dc9764   8 months ago     231MB
# 启动自己制作的镜像
[root@iZ2ze4jen9kd2w1c52zfe0Z docker_test_volume]# docker run -itd -P --name centos04 47762f1907a9
6764dc184a65a22d0bde23b90b2c1297cb7c3ee5c3001674f1c058f64636a015
[root@iZ2ze4jen9kd2w1c52zfe0Z docker_test_volume]# docker ps
CONTAINER ID  IMAGE         COMMAND     CREATED            NAMES
6764dc184a65  47762f1907a9  "/bin/sh"   17 seconds ago     centos04
# 进入容器中
[root@iZ2ze4jen9kd2w1c52zfe0Z docker_test_volume]# docker exec -it centos04 /bin/bash
[root@6764dc184a65 /]# ls
# 可以看到前边 DockerFile 中挂载的 volume01  volume02 目录
bin  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var  volume01  volume02
# 
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker volume ls
DRIVER    VOLUME NAME
local     9e5766e74999b4bac2133a42e7f3dc7b74447fa8acc7d2a1cbea3a4d03465fb5
local     070dfc7c118191140fa7a5fc653cd6033d32711d9a320d5d1065437aee8dd427
local     b192f2b6089d893e18c4f8439e39c738ec58659f28b403ce48a097c5c7a95933
local     this_nginx
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker inspect 6764dc184a65 
......
"Mounts": [
            {
                "Type": "volume",
                "Name": "b192f2b6089d893e18c4f8439e39c738ec58659f28b403ce48a097c5c7a95933",
                "Source": "/var/lib/docker/volumes/b192f2b6089d893e18c4f8439e39c738ec58659f28b403ce48a097c5c7a95933/_data",
                "Destination": "volume02",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            },
            {
                "Type": "volume",
                "Name": "9e5766e74999b4bac2133a42e7f3dc7b74447fa8acc7d2a1cbea3a4d03465fb5",
                "Source": "/var/lib/docker/volumes/9e5766e74999b4bac2133a42e7f3dc7b74447fa8acc7d2a1cbea3a4d03465fb5/_data",
                "Destination": "volume01",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
        ]
......
~~~





docker build -t 镜像名 .











## Docker网络

### 1、理解Docker0

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:16:3e:32:78:df brd ff:ff:ff:ff:ff:ff
    inet 172.22.230.201/20 brd 172.22.239.255 scope global dynamic noprefixroute eth0
       valid_lft 312922524sec preferred_lft 312922524sec
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:35:2c:33:ae brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
~~~

通过 ip addr 命令显示的三个网卡的信息为：lo：表示本机回环地址；eth0：表示阿里云内网地址；docker0：表示 docker 地址。

Docker 是如何处理容器网络访问的？

Docker 创建一个容器之后，会给每个容器分配一个可用的 IP 地址；容器之间访问则是通过 Docker0 进行路由寻找到要访问的容器。
