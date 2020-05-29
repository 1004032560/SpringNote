## 3、Maven

### 3.1、Maven

Maven 项目对象模型（POM），通过一小段描述信息（pom.xml）来管理项目的构建，报告和文档的管理工具。

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

### 3.2、maven的工作原理

![looper_2020-05-29_10-50-28](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_10-50-28.png)

通过在文件 pom.xml 中配置需要的 jar 包的坐标之后，根据坐标先去本地仓库中查，是否有相应的 jar 包，如果有直接引用过来，如果没有则回去 Maven 中央仓库中去下载，相应坐标的 jar 包到本地仓库，再进行引用

<br>

### 3.3、Maven下载

* 浏览器搜索 Maven

* [Maven 官网](https://maven.apache.org)

![looper_2020-05-29_11-17-00](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_11-17-00.png)

* 进入官网，点 download

![looper_2020-05-29_11-17-52](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_11-17-52.png)

* 下载压缩包

![looper_2020-05-29_11-19-49](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_11-19-49.png)

* 解压到本地文件夹

![looper_2020-05-29_11-23-35](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_11-23-35.png)

<br>

### 3.4、Maven配置

#### 3.4.1、配置环境变量

1. 在系统变量中新建一个系统变量
   * 变量名：Maven_HOME
   * 变量值：[Maven 下载好的之后，本地 Maven 文件 bin 目录之前的路径]

![looper_2020-05-29_11-04-52](E:\1.soft\personalNotes\Spring\image\looper_2020-05-29_11-04-52.png)

例如：我自己的 Maven 下载的在 `E:\Dev\Apache\apache-maven-3.6.3-bin\apache-maven-3.6.3` 该目录下

![looper_2020-05-29_11-07-45](E:\1.soft\personalNotes\Spring\image\looper_2020-05-29_11-07-45.png)

2. 在系统变量中找到变量名为 path 的系统变量
   * 在最后边添加变量值：`;%MAVEN_HOME%\bin`，其中分号表示和前后隔开

![looper_2020-05-29_10-59-26](E:\1.soft\personalNotes\Spring\image\looper_2020-05-29_10-59-26.png)

3. 点击确定之后，在任意地方 `win键+R` 输入 `cmd` 打开命令行窗口

![looper_2020-05-29_11-02-18](E:\1.soft\personalNotes\Spring\image\looper_2020-05-29_11-02-18.png)

4. 输入 `mvn -v` 出现如下字样，表示环境变量配置成功

![looper_2020-05-29_11-03-30](E:\1.soft\personalNotes\Spring\image\looper_2020-05-29_11-03-30.png)

<br>

#### 3.4.2、开发配置

1. IDE（Eclipse）自动配置

`window-preference-maven-installations-maven` 解压路径（不配置的话使用默认）

![looper_2020-05-29_11-30-45](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_11-30-45.png)

2. 自己手动配置

   * 在 conf 目录下的 setting.xml 文件中配置

     1. 配置本地仓库的位置，默认是 C 盘下的一个目录，不推荐使用 C 盘目录，后续本地仓库中的 jar 包使用的多了之后，特别占内存（土豪可以忽略），配置如下节点

        `<localRepository>E:\Dev\Apache\apache-maven-3.6.3-bin\repository</localRepository>`（找对 setting.xml 文件中的位置添加该节点）

        ![looper_2020-05-29_11-37-29](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_11-37-29.png)

     2. 配置阿里云镜像（提升从中央仓库往本地仓库下载 jar 包的速度）

        ~~~xml
        <mirror>
        	<id>alimaven</id>
        	<name>aliyun maven</name>
        	<url>http://maven.aliyun.com/nexus/content/groups/public/</url>
        	<mirrorOf>central</mirrorOf>        
        </mirror>
        ~~~

        ![looper_2020-05-29_11-42-48](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_11-42-48.png)

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

        ![looper_2020-05-29_11-43-14](E:/1.soft/personalNotes/Spring/image/looper_2020-05-29_11-43-14.png)

<br>

### 3.5、创建 Maven 工程

jar：普通的 Java 工程

war：Web 工程

pom：父工程（让别的包去引用，不干活）

<br>







