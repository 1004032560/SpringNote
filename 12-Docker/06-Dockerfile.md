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

制作一个 Centos7 镜像包括 Tomcat 和 JDK，准备编写 Dockerfile 文件。

```shell
FROM centos:7
# 通过镜像标签声明了作者信息
LABEL maintainer="looper"

# 设置工作目录
WORKDIR /usr/local
# 新镜像构建成功以后创建指定目录
RUN mkdir -p /usr/local/java && mkdir -p /usr/local/tomcat
# 拷贝文件到镜像中并解压
ADD jdk-8u371-linux-x64.tar.gz /usr/local/java
ADD apache-tomcat-8.5.89.tar.gz /usr/local/tomcat
# 暴露容器运行时的 8080 监听端口给外部
EXPOSE 8080
# 设置容器内 JAVA_HOME 环境变量
ENV JAVA_HOME /usr/local/java/jdk1.8.0_371
ENV PATH $PATH:$JAVA_HOME/bin
# 启动容器时启动 tomcat
CMD ["/usr/local/tomcat/apache-tomcat-8.5.89/bin/catalina.sh", "run"]
```

![image-20230609111704376](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230609111704376.png)

制作好新的 Dockerfile 文件之后，进行构建 Docker 镜像。

### 4、构建DockerFile内容

执行构建命令 `docker build -f Dockerfile -t centosAndVim:1.0 .` 参数 t 表示为新镜像设置名称及标签，参数 f 表示指定 Dockerfile 文件。

![image-20230608141247962](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230608141247962.png)

新的镜像名必须小写。构建命令结尾必须使用  `.` 。

换一个新的名称 `docker build -f Dockerfile -t mycentos:1.0 .` 。

![image-20230609111609622](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230609111609622.png)

通过 `docker images` 中就可以看到自己的构建好的镜像了。



通过 `docker run -d -it -p 8080:8080 --name mycentos mycentos:1.0` 启动 mycentos 镜像。

访问 `curl localhost:8080` 获取到信息。

![image-20230609113038293](https://raw.githubusercontent.com/1004032560/images/master/imagesimage-20230609113038293.png)
