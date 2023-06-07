## Dockerfile

### 1、Dockerfile简介

DockerFile 就是用来构建 Docker 镜像的构建文件，命令脚本。

通过 DockerFile 可以生成镜像，生成镜像的同时可以挂载目录。

可以通过 DockerFile 构建自己个性化的 Docker 镜像；例如：CentOS + Nginx + Tomcat + MySQL + Redis + ElasticSearch 这样一个体系的环境。



### 2、DockerFile 指令

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



### 3、准备DockerFile文件

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



### 4、构建DockerFile内容

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



