

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



