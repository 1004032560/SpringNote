## Docker网络

### 1、理解docker0

通过 `ip addr` 命令显示的三个网卡的信息为：`lo`：表示本机回环地址；`eth0`：表示阿里云内网地址；`docker0`：表示 Docker 网络地址。

![image-20230613143228730](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613143228730.png)

Docker 安装启动后会在宿主主机上创建一个名为 docker0 的虚拟网桥，处于七层网络模型的数据链路层。

当新的 Docker 容器，在不指定容器网络模式的情况下，Docker 会通过 docker0 与主机的网络连接，docker0 相当于网桥。

通过 Docker 创建一个容器之后，会给每个容器分配一个可用的 IP 地址，容器之间访问则是通过 docker0 进行路由寻找到要访问的容器。



### 2、Docker网络模式

`docker run` 创建 Docker 容器时，可以用 `--net` 选项指定容器的网络模式，Docker 主要有 4 种网络模式。

![image-20230613144413384](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613144413384.png)

- bridge 模式：`--net=bridge` 或者 `--network bridge` 默认为 bridge 模式。
- host 模式：`--net=host` 或者 `--network host` 
- container 模式：`--net=container:容器名 or 容器ID` 或者 `--network container:容器名 or 容器ID` 
- none 模式：`--net=none` 或者 `--network none` 



#### 2.1、bridge模式

Docker 安装启动之后，宿主机上会创建出一个名为 docker0 的虚拟网桥，处于七层网络模型的数据链路层。每当创建 run 一个新的容器时，没有指定网络模式的情况下，Docker 会通过 docker0 与主机网络进行连接，docker0 相当于网桥。

1. 启动两个 Ubuntu 容器。

![image-20230613150534481](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613150534481.png)

2. 网关都是通过 docker0 进行路由，分别分配了 0.3 和 0.4 两个 ip

![image-20230613150843806](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613150843806.png)

3. 关闭 u2 启动 u3，可以看出 u2 关闭之后，bridge 分配的 ip 会释放掉，运行 u3 时会继续分配给新的容器，所以容器每次启动停止 ip 都会发生变化。

![image-20230613151457407](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613151457407.png)

**结论：Docker 容器内部的 ip 是有可能会发生改变的。**

通过 `ip addr` 可以看出 docker 容器启动之后创建的虚拟网络接口，用于连接宿主机和容器之间的通信。

![image-20230613151916494](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613151916494.png)



Docker 服务默认会创建一个 docker0 网桥（其上有一个 docker0 内部接口），该桥接网络的名称为 docker0，它在内核层连通了其他的物理或虚拟网卡，这就将所有容器和本地主机都放到同一个物理网络。Docker 默认指定了 docker0 接口 的 IP 地址和子网掩码，让主机和容器之间可以通过网桥相互通信。

查看 bridge 网络的详细信息。

通过 `docker network inspect bridge | grep name` 和 `ip addr` 可以看出通过 docker0 映射到 Docker 网络接口。

![image-20230613152525934](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613152525934.png)

##### bridge模式的工作流程

1. Docker 使用 Linux 桥接，在宿主机虚拟一个 Docker 容器网桥 docker0，Docker 启动一个容器时会根据 Docker 网桥的网段分配给容器一个 IP 地址，称为 Container-IP，同时 Docker 网桥是每个容器的默认网关。因为在同一宿主机内的容器都接入同一个网桥，这样容器之间就能够通过容器的 Container-IP 直接通信。
2. docker run 的时候，没有指定 network 的话默认使用的网桥模式就是 bridge，使用的就是 docker0。在宿主机 ifconfig 就可以看到 docker0 和自己 create 的 network 和 eth0，eth1，eth2 …… 代表网卡一，网卡二，网卡三 ……，lo 代表127.0.0.1，即 localhost，inet addr 用来表示网卡的IP地址。
3. 网桥 docker0 创建一对对等虚拟设备接口一个叫 veth，另一个叫 eth0，成对匹配。
   * 整个宿主机的网桥模式都是 docker0，类似一个交换机有一堆接口，每个接口叫 veth，在本地主机和容器内分别创建一个虚拟接口，并让他们彼此联通（这样一对接口叫 veth pair）；
   * 每个容器实例内部也有一块网卡，每个接口叫 eth0；
   * docker0 上面的每个veth匹配某个容器实例内部的 eth0，两两配对，一一匹配。

通过上述，将宿主机上的所有容器都连接到这个内部网络上，两个容器在同一个网络下，会从这个网关下各自拿到分配的 ip，此时两个容器的网络是互通的。

bridge 模式下，网络模型图：

![image-20230613161506865](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613161506865.png)



#### 2.2、host模式

直接使用宿主机的 IP 地址与外界进行通信，不再需要额外进行 NAT（Network Address Translation，网络地址转换）转换。

容器将不会获得一个独立的 Network Namespace， 而是和宿主机共用一个 Network Namespace。容器将不会虚拟出自己的网卡而是使用宿主机的 IP 和端口。

![image-20230613164907390](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613164907390.png)

Docker 启动时总是遇见标题中的警告 Docker 启动时指定 `--network host` 或 `-net=host`，如果还指定了`-p` 映射端口，那这个时候就会有此警告，并且通过 `-p` 设置的参数将不会起到任何作用，端口号会以主机端口号为主，重复时则递增。

host 模式下，网络模型图：

![image-20230613170646653](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613170646653.png)



#### 2.3、container模式

新建的容器和已经存在的一个容器共享一个网络 IP 配置而不是和宿主机共享。

新创建的容器不会创建自己的网卡，配置自己的 IP，而是和一个指定的容器共享 IP、端口范围等。

同样，两个容器除了网络方面，其他的如文件系统、进程列表等还是隔离的。

![image-20230613171012923](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613171012923.png)



#### 2.4、none模式

在 none 模式下，并不为 Docker 容器进行任何网络配置。 也就是说这个 Docker 容器没有网卡、IP、路由等信息，只有一个 lo 

需要我们自己为 Docker 容器添加网卡、配置IP等。

禁用网络功能，只有 lo 标识（就是 `127.0.0.1` 表示本地回环）

![image-20230613170429701](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613170429701.png)

none 模式下，网络模型图：

![image-20230613170722720](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230613170722720.png)



