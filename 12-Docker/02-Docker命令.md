## Docker命令

下载安装好 Docker 之后，需要学习了解一些新的 Docker 语法命令去在 Linux 中对 Docker 进行操作，Docker 命令类似于 Linux 命令，有相似之处，但是 Docker 的命令都以 docker 开始的，详细命令参考后续内容。

### 1、启动关闭命令

Docker 下载好之后，对于 Linux 操作系统而言需要先启动这个 Docker 应用。

通过以下命令对 Docker 应用进行操作和查看应用状态。

~~~shell
# 设置开机自动启动 Docker
systemctl enable docker
# 启动 Docker
systemctl start docker
# 重启 Docker
systemctl restart docker
# 查看 Docker 状态
systemctl status docker
# 关闭 Docker
systemctl stop docker
# 查看 Dcoker 版本信息
docker version
# 查看 Dcoker 全部信息（镜像和容器数量等）
docker info
~~~

### 2、帮助命令docker --help

~~~shell
# 帮助命令，可以通过 help 查看更多的命令参数
docker 命令 --help
# -h 查看 help 命名已经不推荐使用了，推荐使用 --help
Flag shorthand -h has been deprecated, please use --help
~~~

### 3、镜像命令

#### 3.1、查看本机镜像docker images

~~~shell
# 查看 Docker 本机所有的镜像
docker images

REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    feb5d9fea6a5   8 months ago   13.3kB

# 解释
REPOSITORY    镜像在本地仓库的名字（去远程仓库下载也是通过这个名字）
TAG           镜像的标签
IMAGE ID      镜像的Id
CREATED       镜像的创建时间
SIZE          镜像的大小

# 可选参数
-a --all     列出所有镜像
-q --quiet   只显示镜像的Id

#####################################################################

# 显示所有镜像的Id
docker images -aq
~~~



#### 3.2、搜索镜像docker search

~~~shell
# 搜索 DockerHub 中所需要的镜像
docker search 镜像名（mysql）

# 可选参数
 --filter -f     按照某个条件进行过滤
~~~

搜索 MySQL 镜像

`docker search mysql`

![image-20230606171621312](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230606171621312.png)

搜索 MySQL 镜像时，通过 Stars 属性进行过滤搜索（搜索Stars数量大于等于3000的MySQL镜像）

`docker search mysql --filter=stars=3000`

![image-20230606171801158](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230606171801158.png)

#### 3.3、下载镜像docker pull

~~~shell
# 下载搜索出来的所需要的镜像, 如果不标注 tag 默认是最新的 latest
docker pull 镜像名(mysql)[:tag]

#####################################################################

# 下载 MySQL 的镜像
docker pull mysql
# 使用默认 tag 最新的 latest
Using default tag: latest              
latest: Pulling from library/mysql
# 采用的分层下载 Docker Image 的核心（联合文件系统）
72a69066d2fe: Pull complete
93619dbc5b36: Pull complete 
......
# 签名（防止伪造）
Digest: sha256:e9027fe4d91c0153429607251656806cc784e914937271037f7738bd5b8e7709
Status: Downloaded newer image for mysql:latest
# 真实地址
docker.io/library/mysql:latest

# 这俩个操作等价 (docker pull mysql) = (docker pull docker.io/library/mysql:latest)

#####################################################################

# 指定版本下载
docker pull mysql:5.7

5.7: Pulling from library/mysql
# 采用的分层下载的好处，之前版本下载过的内容可以复用的就不会再下载
72a69066d2fe: Already exists 
93619dbc5b36: Already exists 
......
0ceb82207cd7: Pull complete 
37f2405cae96: Pull complete 
......
Digest: sha256:f2ad209efe9c67104167fc609cca6973c8422939491c9345270175a300419f94
Status: Downloaded newer image for mysql:5.7
docker.io/library/mysql:5.7
~~~



#### 3.4、删除镜像docker rmi

~~~shell
# 删除 Docker 镜像, rm = remove, i = image, 
docker rmi [可选参数] 镜像名(mysql)

# 可选参数
 -f      # 强制删除

#####################################################################

# 通过镜像名强制删除
docker rmi -f mysql
# 通过镜像名删除，删除的则是最新 Tag 的镜像
Untagged: mysql:latest
Untagged: mysql@sha256:e9027fe4d91c0153429607251656806cc784e914937271037f7738bd5b8e7709
# 删除只会删除这个 Tag 特有的部分，同镜像名公共部分不会删除（对应分层下载）
Deleted: sha256:3218b38490cec8d31976a40b92e09d61377359eab878db49f025e5d464367f3b
Deleted: sha256:aa81ca46575069829fe1b3c654d9e8feb43b4373932159fe2cad1ac13524a2f5
......

#####################################################################

# 通过镜像 id 强制删除指定的镜像
docker rmi -f 镜像Id(c20987f18b13)

#####################################################################

# 通过多个镜像Id，删除这些指定的镜像
docker rmi -f 镜像Id(c20987f18b13) 镜像Id(feb5d9fea6a5) 镜像Id(3218b38490ce)

#####################################################################

# 通过 $() 传参，删除所有的镜像
docker rmi $(docker images -aq)
~~~



### 4、容器命令

有镜像之后，才可以创建容器。

~~~shell
docker images
docker search centos
docker pull centos      # using default tag:latest
~~~



#### 4.1、创建启动容器docker run

~~~shell
# 启动容器的基本命令
docker run [可选参数] 镜像Id(5d0da3dc9764)

# 可选参数
 --name="ContainerName"         # 启动容器的名字，用于区分（例如：tomcat01、tomcat02等）
 -d                             # 该容器以后台的方式运行
 -it                            # 使用交互的方式，进入容器内查看内容
 -p（小写）                      # 指定容器端口
	-p ip:主机端口:容器端口
	-p 主机端口:容器端口    # 常用
	-p 容器端口
	容器端口
 -P（大写）                      # 随机指定容器的端口

#####################################################################

# 启动容器，并且进入容器查看
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -it centos
# 进入的容器内的CentOS中，root后边的主机名已经发生变化，主机名=容器Id
[root@7de2fba86cbc /]# exit
# 从容器中退出到主机
exit
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker ps -a
CONTAINER ID   IMAGE         COMMAND       CREATED          STATUS
7de2fba86cbc   centos        "/bin/bash"   14 minutes ago   Exited (1) 7 seconds ago
d9b589fb8548   hello-world   "/hello"      47 hours ago     Exited (0) 47 hours ago
~~~



#### 4.2、查看容器docker ps

~~~shell
# 查看容器
docker ps [可选参数]

# 可选参数
 -a     # 列出之前运行过的所有容器
 -n=1   # 列出最近运行的一个容器
 -q     # 只显示容器的Id

#####################################################################

# 查看当前正在运行的Container
docker ps
# 查看历史运行过的Container
docker ps -a
# 按照数量查找最近运行过的Container
docker ps -n=1
# 查看历史运行过的容器的Id
docker ps -aq
docker ps -aq -n=1
~~~



#### 4.3、进入容器docker attach/exec

启动容器的时候使用 `-d` 参数时，容器启动后会进入后台。

需要进入容器进行操作时，可以使用 `docker attach` 命令或 `docker exec` 命令。

~~~shell
# 方式一: 进入正在执行的终端
docker attach 容器Id
# 方式二: 进入容器后，开启一个新的终端，路径不唯一
docker exec -it 容器Id /bin/bash
~~~

通过 `docker exec` 进入容器时，需要指定容器路径，容器的路径可以通过 `docker inspect` 查看路径

![image-20230612154251962](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230612154251962.png)

#### 4.4、退出容器exit

* `exit` 方式：

通过 `docker attach` 进入容器之后，使用 `exit` 退出时会使容器直接结束。

通过 `docker exec` 进入容器之后，使用 `exit` 退出时不会使容器直接结束。

* `CTRL + P + Q` 方式：

`CTRL + P + Q` 方式下退出容器，不会在宿主机中结束该容器的进程。

![image-20230612153405339](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230612153405339.png)



#### 4.5、删除容器docker rm

~~~shell
# 删除指定容器Id的容器
docker rm [可选参数] 容器Id

# 可选参数
 -f       # 强制删除，可以删除正在运行中的容器

#####################################################################

[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS
5ed16b23ac73   centos    "/bin/bash"   23 seconds ago   Up 22 seconds

# 强制删除容器 5ed16b23ac73
docker rm -f 5ed16b23ac73
# 删除所有的容器
docker rm -f $(docker ps -aq)
# 删除所有的容器
docker ps -aq | xargs docker rm -f
~~~



#### 4.6、启动停止容器docker start/stop

~~~shell
# 启动容器
docker start 容器Id
# 重启容器
docker restart 容器Id
# 停止容器
docker stop 容器Id
# 强制停止容器
docker kill 容器Id
~~~



### 5、其他常用命令

#### 5.1、后台启动容器docker run

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -d centos
5ecf2432a6ac5f1dc876b68562ba5357fe2284bf1c06aaf5de1476c6f881f318
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# 
~~~

以后台的模式启动了一个 CentOS 的容器，docker ps 时没有发现正在运行的容器，启动的 CentOS 的容器停止了，是因为后台启动一个容器，必须要有个一个前台进程，Docker 没有发现前台进程就会自动停止。

容器启动之后，自己发现容器没有提供服务，就会立刻停止。



#### 5.2、查看日志信息docker logs

~~~shell
# 查看日志所以信息
docker logs [可选参数] 镜像Id

# 可选参数
 -t --timestamps       # 显示日志的时间戳
 -f --follow           # 动态显示日志信息，保存日志窗口，持续打印
 -n --tail 行数         # 显示指定行数日志

#####################################################################

# 启动运行一个 CentOS 守护进程，并且持续输出 Shell 脚本
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -itd centos /bin/sh -c "while true; do echo looper; sleep 2; done"
2fe2453aa7e2074fec2ffba882857d5ad5e7d04f665b7054382b14f2d854c053
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS     NAMES
2fe2453aa7e2   centos    "/bin/sh -c 'while t…"   33 seconds ago   Up 32 seconds             keen_jepsen
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker logs -tf --tail 10 2fe2453aa7e2
# 上下命令等价
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker logs -tfn 10 2fe2453aa7e2
2022-05-29T11:19:03.931726639Z looper
2022-05-29T11:19:05.933569425Z looper
2022-05-29T11:19:07.935330987Z looper
......
~~~



#### 5.3、查看进程信息docker top

~~~shell
# 查看Docker容器内部的进程信息
docker top 容器ID

#####################################################################

[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker top 6990f597c9b5
用户Id       当前进程Id   父进程Id
UID         PID         PPID        C           STIME       TTY
root        3019        3000        0           19:40       pts/0
root        3058        3019        0           19:41       pts/0
~~~



#### 5.4、查看容器元数据docker inspect

~~~shell
# 查看容器的所有信息
docker inspect 容器ID

#####################################################################

docker inspect 6990f597c9b5
[
    {
        "Id": "6990f597c9b5c40c9af01463ec622f98520f63813b0f30fc424068f10bf5526b",
        "Created": "2022-05-29T11:40:48.270035543Z",
        "Path": "/bin/sh",
        "Args": [
            "-c",
            "while true; do echo looper; sleep 2; done"
        ],
        "State": {
            ......
        },
        "Image": "sha256:5d0da3dc976460b72c77d94c8a1ad043720b0416bfc16c52c45d4847e53fadb6",
        ......
        "HostConfig": {
            ......
        },
        "GraphDriver": {
            ......
        },
        "Mounts": [],
        "Config": {
            ......
        },
        "NetworkSettings": {
            ......
            "Networks": {
                "bridge": {
                    "MacAddress": "02:42:ac:11:00:02",
                    ......
                }
            }
        }
    }
]
~~~



#### 5.5、从容器内拷贝文件到主机docker cp

~~~shell
# 拷贝容器内部文件到主机上
docker cp 容器Id:容器内路径 主机目标路径

#####################################################################

docker cp 6990f597c9b5:/home/Looper.java /home

# 拷贝是手动的同步文件的过程，可以使用 -v 数据卷的技术进行自动同步
~~~



