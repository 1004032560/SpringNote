## Docker安装Nginx

#### 1、查找 Nginx 镜像

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker search nginx
NAME                      DESCRIPTION                            STARS
nginx                     Official build of Nginx.               16867
linuxserver/nginx         An Nginx container, brought...         168
bitnami/nginx             Bitnami nginx Docker Image             131
~~~

#### 2、下载 Nginx 镜像

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

#### 3、启动 Nginx

~~~shell
[root@iZ2ze4jen9kd2w1c52zfe0Z /]# docker run -d --name nginx01 -p 3344:80 nginx
66d71b16468c3ebf6dcf1291a0aa2d80de5286bb36db247281582ea56b0085b0
~~~

#### 4、测试访问 Nginx

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

#### 1、启动Tomcat

~~~shell
# 之前都是启动容器之后，在后台运行，现在官方使用命令，用完即删除，一般用于测试
docker run -it --rm tomcat:9.0
# 启动 Tomcat，执行run命令是会自动下载不存在的镜像
docker run -it -p 3355:8080 --name tomcat01 tomcat
~~~

#### 2、通过外网访问Tomcat

~~~shell
# 通过阿里云下载的 Tomcat 属于阉割版的，不会下载一些不必要的内容所有 webapps 下边没有内容
# 解决方式
# 进入Tomcat容器内
docker exec -it tomcat01 /bin/bash
# 把 webapps.dist 中的内容 copy 到 webapps 中，即可通过外网访问 tomcat 主页
cp -r webapps.dist/* webapps
~~~



## Docker安装MySQL

#### 1、搜索镜像

docker search mysql

#### 2、下载镜像

docker pull mysql:5.7

#### 3、启动镜像

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

#### 4、测试连接

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



