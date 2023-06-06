## 1、Maven

Maven 项目对象模型（POM：Project Object Model），通过一小段描述信息（pom.xml）来管理项目的构建，报告和文档的管理工具。

Maven 坐标：唯一确定 Maven 仓库中的一个 jar 的坐标

* G：（GroupId）组织的 id，公司域名的倒写
* A：（ArtifactId）工程名
* V：（Version）版本号

~~~xml
<!-- https://mvnrepository.com/artifact/org.springframework/spring-context -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>
~~~

<br>

<br>

## 2、maven的工作原理

![looper_2020-05-29_10-50-28](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_10-50-28.png)

通过在文件 pom.xml 中配置需要的 jar 包的坐标之后，根据坐标先去本地仓库中查，是否有相应的 jar 包，如果有直接引用过来，如果没有则回去 Maven 中央仓库中去下载，相应坐标的 jar 包到本地仓库，再进行引用

<br>

<br>

## 3、Maven下载

### 3.1、浏览器搜索 Maven

<br>

### 3.2、[Maven 官网](https://maven.apache.org)

![looper_2020-05-29_11-17-00](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-17-00.png)

<br>

### 3.3、进入官网，选 download

![looper_2020-05-29_11-17-52](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-17-52.png)

<br>

### 3.4、下载压缩包

![looper_2020-05-29_11-19-49](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-19-49.png)

<br>

### 3.5、解压到本地文件夹

![looper_2020-05-29_11-23-35](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-23-35.png)

<br>

<br>

## 4、Maven配置

### 3.1、配置环境变量

#### 3.1.1、在系统变量中新建一个系统变量

* 变量名：Maven_HOME
* 变量值：[Maven 下载好的之后，本地 Maven 文件 bin 目录之前的路径]

![looper_2020-05-29_11-04-52](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-04-52.png)

例如：我自己的 Maven 下载的在 `E:\Dev\Apache\apache-maven-3.6.3-bin\apache-maven-3.6.3` 该目录下

![looper_2020-05-29_11-07-45](E:\1.soft\personalNotes\Spring\image\looper_2020-05-29_11-07-45.png)

<br>

#### 3.1.2、在系统变量中找到变量名为 path 的系统变量

* 在最后边添加变量值：`;%MAVEN_HOME%\bin`，其中分号表示和前后隔开

![looper_2020-05-29_10-59-26](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_10-59-26.png)

<br>

#### 3.1.3、点击确定之后，在任意地方 `win键+R` 输入 `cmd` 打开命令行窗口

![looper_2020-05-29_11-02-18](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-02-18.png)

<br>

#### 3.1.4、输入 `mvn -v` 出现如下字样，表示环境变量配置成功

![looper_2020-05-29_11-03-30](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-03-30.png)

<br>

### 3.2、开发配置

#### 3.2.1、IDE（Eclipse）自动配置

`window-preference-maven-installations-maven` 解压路径（不配置的话使用默认）

![looper_2020-05-29_11-30-45](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-30-45.png)

<br>

#### 3.2.2、自己手动配置

##### 3.2.2.1、在 conf 目录下的 setting.xml 文件中配置

1. 配置本地仓库的位置，默认是 C 盘下的一个目录，不推荐使用 C 盘目录，后续本地仓库中的 jar 包使用的多了之后，特别占内存（土豪可以忽略），配置如下节点

   `<localRepository>E:\Dev\Apache\apache-maven-3.6.3-bin\repository</localRepository>`（找对 setting.xml 文件中的位置添加该节点）

   ![looper_2020-05-29_11-37-29](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_11-37-29.png)

   <br>

2. 配置阿里云镜像（提升从中央仓库往本地仓库下载 jar 包的速度）

   ~~~xml
   <mirror>
   	<id>alimaven</id>
   	<name>aliyun maven</name>
   	<url>http://maven.aliyun.com/nexus/content/groups/public/</url>
   	<mirrorOf>central</mirrorOf>        
   </mirror>
   ~~~

   ![looper_2020-05-29_11-42-48](image/looper_2020-05-29_11-42-48.png)

   <br>

3. 配置 JDK

   ~~~xml
   <profile>    
   	<id>jdk-1.8</id>    
   	<activation>    
   		<activeByDefault>true</activeByDefault>    
   		<jdk>1.8</jdk>    
   	</activation>    
   	<properties>    
   		<maven.compiler.source>1.8</maven.compiler.source>    
   		<maven.compiler.target>1.8</maven.compiler.target>
   		<maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion> 
   	</properties>    
   </profile>
   ~~~

   ![looper_2020-05-29_11-43-14](image/looper_2020-05-29_11-43-14.png)

<br>

##### 3.2.2.2、在 Eclipse 中添加刚才的配置

1. 在刚才默认配置的地方，选择右边的 add 添加 Maven 下载解压好的 Maven 路径 bin目录 之前的路径

![looper_2020-05-29_11-30-45](E:\MyBlog\SpringNote\image\looper_2020-05-29_11-30-45.png)

2. 在 User Setting 下，配置 setting.xml 的路径和本地仓库的路径，完成后基本配置成功

![looper_2020-05-29_12-09-37](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_12-09-37.png)

<br>

<br>

## 5、创建 Maven 工程

一切准备工作完成之后，就进行测试工作，首先来创建一个 Maven 工程，来体验 Maven 带来的便利之处

### 5.1、创建 Maven Project

![looper_2020-05-29_17-26-21](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_17-26-21.png)

<br>

### 5.2、填写 GVN，选择打包方式

![looper_2020-05-29_17-27-32](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_17-27-32.png)

> jar：普通的 Java 工程
>
> war：Web 工程
>
> pom：父工程（让别的包去引用，不干活）
>

<br>

### 5.3、Maven 的工程目录结构

![looper_2020-05-29_17-29-52](https://raw.githubusercontent.com/1004032560/images/master/looper_2020-05-29_17-29-52.png)

<br>

<br>

## 6、总结

1. 原来的项目中需要的 jar 包必须手动“复制”、”粘贴” 到 WEB-INF/lib 项目下，而借助 Maven，可以将 jar 包仅仅保存在“仓库”中，有需要使用的工程只需要“引用”这个文件，并不需要重复复制到工程中。

2. 原来的项目中所需要的 jar 包都是提前下载好的，而 Maven 在联网状态下会自动下载所需要的 jar 包。首先在本地仓库中找，找不到就在网上进行下载。

3. 原来的项目中一个 jar 包所依赖的其他 jar 包必须手动导进来，而 Maven 会自动将被依赖的 jar 包导进来。

4. 原来的项目一个项目就是一个工程，而借助 Maven 可以将一个项目拆分成多个工程。