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

