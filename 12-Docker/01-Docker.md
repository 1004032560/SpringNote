## 1、Docker

### 1.1、什么是Docker

开源引擎，可以轻松为任何应用创建一个轻量级、可重用、自给自用的容器

<br>

### 1.2、Docker核心组件

Docker 主机：

Docker 客户端：连接 docker 主机进行操作

Docker 仓库：用来保存各种打包好的软件镜像

Docker 镜像：软件打包好的镜像，放在 docker 仓库中

Docker 容器：镜像启动后的实例称之为一个容器，容器时独立运行的一个或者一组容器

<br>

### 1.3、Docker安装

1. 检测内核版本，必须是 3.10 及以上

   `[root@hadoop01 ~]# uname -r`

2. 安装 Docker

   `[root@hadoop01 ~]# yum install docker`

3. 输入 `y` 确认安装

4. 启动 Docker

   `[root@hadoop01 ~]# systemctl start docker`

5. 开机启动 Docker

   `[root@hadoop01 ~]# systemctl enable docker`

6. 停止 Docker

   `[root@hadoop01 ~]# uname -r`

