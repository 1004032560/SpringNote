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