## 安装RocketMQ

常见的安装在不同环境上，不同方式上。

Windows、Linux、MacOS 以及 Docker 上。



### 1、Linux安装RocketMQ

待定



### 2、Docker安装RocketMQ

#### 2.1、搜索镜像

docker search rocketmq

docker search rocketmq-console



#### 2.2、下载镜像

docker pull apache/rocketmq

docker pull styletang/rocketmq-console-ng



#### 2.3、准备挂载文件

~~~shell
# 供 namesrv 服务使用
mkdir -p /home/docker/rocketmq/data/nameser/logs
mkdir -p /home/docker/rocketmq/data/nameser/store

# 供 broker 服务使用
mkdir -p /home/docker/rocketmq/data/broker/logs 
mkdir -p /home/docker/rocketmq/data/broker/store 

# Broker 配置文件
mkdir -p /home/docker/rocketmq/conf
vim /home/docker/rocketmq/conf/broker.conf
~~~



编辑 `broker` 配置文件

~~~vim
brokerClusterName = DefaultCluster
brokerName = broker-a
brokerId = 0
deleteWhen = 04
fileReservedTime = 48
brokerRole = ASYNC_MASTER
flushDiskType = ASYNC_FLUSH
brokerIP1 = 192.79.33.54
~~~



#### 2.4、启动镜像

创建启动 nameServer 容器

~~~shell
docker run -d \
--restart=always \
--name rmqnamesrv \
-p 9876:9876 \
-v /home/docker/rocketmq/data/nameser/logs:/root/logs \
-v /home/docker/rocketmq/data/nameser/store:/root/store \
-e "MAX_POSSIBLE_HEAP=100000000" \
apache/rocketmq \
sh mqnamesrv
~~~



创建启动 broker 容器

~~~shell
docker run -d  \
--restart=always \
--name rmqbroker \
--link rmqnamesrv:namesrv \
-p 10911:10911 \
-p 10909:10909 \
-v /home/docker/rocketmq/data/broker/logs:/root/logs \
-v /home/docker/rocketmq/data/broker/store:/root/store \
-v /home/docker/rocketmq/conf/broker.conf:/opt/rocketmq-4.4.0/conf/broker.conf \
-e "NAMESRV_ADDR=namesrv:9876" \
-e "MAX_POSSIBLE_HEAP=200000000" \
apache/rocketmq \
sh mqbroker -c /opt/rocketmq-4.4.0/conf/broker.conf
~~~

`--link rmqnamesrv:namesrv \` 表示和 rmqnamesrv 容器通讯



创建启动 rockermq-console 容器

```shell
docker run -d \
--restart=always \
--name rmqconsoleng \
-e "JAVA_OPTS=-Drocketmq.namesrv.addr=192.79.33.54:9876 -Dcom.rocketmq.sendMessageWithVIPChannel=false" \
-p 9999:8080 \
styletang/rocketmq-console-ng
```



正常访问 RocketMQ 控制台页面：

```text
http://192.79.33.54:9999/
```

