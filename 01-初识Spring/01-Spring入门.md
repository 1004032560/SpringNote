## 1、Spring



### 1.1、Spring目标

Spring FrameWork 的目标

* 使用声明性事务，向 EJB（Enterprise Java Beans：企业 Java Beans）发出挑战
* 框架整合（整合多个框架，协同工作）



### 1.2、Java EE（Jakarta） 

#### Java EE

* Java EE（Java Enterprise Edition）Java 企业级版本，现已经更名为：Jakarta

* Java EE 是sun 制定的一套开发规范 Java 开发规范（Specification）

* Java EE 由一系列的 JSR 组成
* JSR 是 Java Specification Requests 的缩写意思是：Java 规范提案



#### Java EE容器与组件

容器：Applet Container、Web Container、Application client Container、EJB Container

组件：Applet、JSP、Servlet、JavaBean、EJB JavaBean



### 1.3、Spring和JavaEE

1. Spring 是轻量级的框架，EJB 是重量级的框架
2. Spring 使用声明式事务代替 EJB，和 Java EE 属于竞争关系
3. Spring 是第三方框架，Java 是规范，Spring 开发必须满足 Java EE 的规范



### 1.4、Spring特点

1. IoC（Inversion of Control）：使用 IoC 机制解耦（避免硬编码造成程序耦合）

2. AOP：Aspect Orentied Programming 面向切面编程
3. 声明式事务管理
4. 对 JDBC 进行轻量级封装，更加灵活的操作数据库

5. Spring 提供 MVC 模式：Spring MVC
6. 提供文件上传，定时器常用工具类
7. 支持集成其他的框架



### 1.5、Spring 4 框架的架构

Test 模块：

Core Container 模块：Beans、Core、Context、SpEL

AOP 模块：AOP、Aspects、Instrumentation（引介）、Messaging

Data Access 模块： JDBC ORM OXM JMS Transaction

Web： WebSocket、Servlet、Web Portlet





### 1.6、Spring 5 特点

1. 支持 Java EE 8
2. 支持 JSR 规范：Servlet API - JSR340、WebSocket API - JSR356、Concurrency Utilities、JSON Binding、

   1.支持JAVAEE8
    2.支持JSR 

### 1.7、Spring 核心功能

IoC 容器、Bean 生命周期管理、SpELl、AOP 容器、注解体系、数据验证



### 1.8、Spring框架功能总览

核心功能：Spring 容器与 Bean 的生命周期管理

#### 1.8.2、Bean

The Spring Container：生产 Bean ，管理 Bean



#### 1.8.2、AOP

将辅助代码在不修改原理代码的基础上，织入到原始对象的代码中，对源代码进行增强



#### 1.8.3、数据整合

1. 事务管理：编程式事务、无侵入性声明式事务（推荐）



#### 1.8.4、Web层技术

Spring MVC、视图技术、



#### 1.8.5、外部系统集成







## 2、Spring使用

### 2.1、Spring 介绍

Spring 的提出者：Rod Johnson

Spring 诞生的 2 本书

* Expert One-On-One J2EE Development and Design
* Expert One-On-One J2EE Development without EJB

Spring：是轻量级，面向切面（AOP）和控制反转（IoC）的容器



### 2.2、使用Spring的好处

#### 方便解耦，简化开发

* Spring 就是一个大工厂，可以将所有对象创建和依赖关系维护，交给 Spring 管理

#### 支持 AOP 编程

* Spring 提供面向切面编程，可以方便的实现对程序进行权限拦截、运行监控等功能

#### 支持声明式事务管理

* 只需要通过配置就可以完成对事务的管理，而无需手动编程

#### 方便程序测试

* Spring 对 Junit4 支持，可以通过注解方便的测试 Spring 程序

#### 集成各种框架

* Spring 不排斥各种优秀的开源框架，其内部提供了对各种优秀框架（如：Struts、Hibernate、MyBatis、Quartz 等）的直接支持

#### 降低 Java EE API 的使用难度

* Spring 对 Java EE 开发中非常难用的一些 API（JDBC、JavaMail、远程调用等）都提供了封装，使这些 API 应用难度大大降低 







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



3.2、Maven下载





3.3、Maven配置

Maven_HOME

%MAVEN_HOME%\bin;



jar：普通的 Java 工程

war：Web 工程

pom：父工程（让别的包去引用，不干活）

















