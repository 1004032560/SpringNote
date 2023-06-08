## Dockerfile

### 1、Dockerfile简介

DockerFile 就是用来构建 Docker 镜像的文本文件，由一条条构建镜像所需的指令和参数构成的脚本文件。

可以通过 DockerFile 构建自己个性化的 Docker 镜像；例如：CentOS + Nginx + Tomcat + MySQL + Redis + ElasticSearch 这样一个体系的环境。

#### 构建三步骤：

* 编写 Dockerfile 文件
* docker build 命令构建镜像
* docker run 依镜像运行容器实例

#### Dockerfile内容基础知识

1. 每条保留字指令都必须为大写字母且后面要跟随至少一个参数
2. 指令按照从上到下，顺序执行
3. #表示注释
4. 每条指令都会创建一个新的镜像层并对镜像进行提交

#### Docker执行Dockerfile的大致流程

1. docker 从基础镜像运行一个容器

2. 执行一条指令并对容器作出修改

3. 执行类似 docker commit 的操作提交一个新的镜像层

4. docker 再基于刚提交的镜像运行一个新容器

5. 执行 dockerfile 中的下一条指令直到所有指令都执行完成

从应用软件的角度来看，Dockerfile、Docker 镜像与 Docker 容器分别代表软件的三个不同阶段。Dockerfile 是软件的原材料，Docker 镜像是软件的交付品， Docker 容器则可以认为是软件镜像的运行态，也即依照镜像运行的容器实例。

Dockerfile 面向开发，Docker 镜像成为交付标准，Docker 容器则涉及部署与运维，三者缺一不可，合力充当 Docker 体系的基石。 



### 2、DockerFile 指令

DockerFile 指令关键字，通过关键字控制生成所需要的镜像。

~~~shell
FROM        # 基础镜像; 新制作的镜像是基于什么镜像制作的，一般都是基于 CentOS
MAINTANER   # 镜像的作者，维护者; 格式: 姓名+邮箱
RUN         # Docker镜像构建的时候需要运行的命令
ADD         # 添加步骤，将宿主机目录下的文件拷贝进镜像且会自动处理URL和解压tar压缩包
WORKDIR     # 指定在创建容器后，终端默认登陆的进来工作目录，一个落脚点
VOLUME      # 容器数据卷，用于数据保存和持久化工作
USER        #指定该镜像以什么样的用户去执行，如果都不指定，默认是root
EXPOSE      # 当前容器对外暴露出的端口配置
CMD         # 指定容器启动的时候运行的命令，只有最后一个命令会生效
ENTRYPONT   # 指定容器启动的时候运行的命令，可以追加命令
OBBUILD     # 当构建一个被继承的 DockerFile 时这个命令就会运行，触发指令
COPY        # 类似于 ADD ，将文件拷贝到镜像中
ENV         # 构建的时候设置环境变量
~~~



### 3、制作DockerFile文件

所有镜像的基础：FROM scratch



制作一个 Centos7 镜像具备 vim 和 ifconfig 的功能，准备编写 Dockerfile 文件。

```shell
FROM centos
MAINTAINER looper<looper555@gmail.com>

# 配置环境变量 MYPATH
ENV MYPATH /usr/local
# 通过环境变量 MYPAYTH 指定进入容器的之后的目录，$ 表示取地址符
WORKDIR $MYPATH

RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

RUN yum clean all && yum makecache fast

RUN yum -y install vim
RUN yum -y install net-tools

EXPOSE 80

CMD echo $MYPATH
CMD echo "success--------------ok"
CMD /bin/bash
```

![image-20230608155428212](D:\typora\Typora-image\image-20230608155428212.png)

制作好新的 Dockerfile 文件之后，进行构建 Docker 镜像。

执行构建命令 `docker build -f Dockerfile -t centosAndVim:1.0 .` 参数 t 表示为新镜像设置名称及标签，参数 f 表示指定 Dockerfile 文件。

![image-20230608141247962](D:\typora\Typora-image\image-20230608141247962.png)

新的镜像名必须小写。构建命令结尾必须使用  `.` 。

换一个新的名称 `docker build -f Dockerfile -t mycentos:1.0 .` 。





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



