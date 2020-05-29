## 1、Spring

### 1.1、Spring FrameWork目标

* 使用声明性事务管理，向 EJB（Enterprise Java Beans：企业 Java Beans）发出挑战
* 框架整合（整合其他优秀框架，协同工作，避免重复造轮子）

<br>

### 1.2、Java EE（Jakarta） 

#### 1.2.1、Java EE

Java EE 是：（Java Enterprise Edition）Java 企业级版本（现已经更名为：Jakarta）Java EE 是sun 制定的一套开发规范 Java 开发规范（Specification）由一系列的 JSR 组成

> 2018-03-05日，据国外媒体报道，开源组织 Eclipse 基金会宣布将 JavaEE(Enterprise Edition) 被更名为JakartaEE (雅加达)。这是 Oracle 将 Java 移交给开源组织 Eclipse 后实现对 Java 品牌控制的最新举措。尽管开源组织曾经争取过，但这无法撼动甲骨文的意志。

<br>

#### 1.2.2、JSR

JSR 是 Java Specification Requests 的缩写意思是：Java 规范提案

<br>

#### 1.2.3、Java EE容器与组件

容器：Applet Container、Web Container、Application client Container、EJB Container

组件：Applet、JSP、Servlet、JavaBean、EJB JavaBean

<br>

### 1.3、Spring和Java EE

1. Spring 是轻量级的框架，EJB 是重量级的框架
2. Spring 是轻量级容器+组件模式，EJB 是重量级容器+组件模式
3. Spring 使用声明式事务代替 EJB，和 Java EE 属于竞争关系
4. Spring 是第三方框架，Java 是规范，Spring 开发必须满足 Java EE 的规范

<br>

### 1.3、Spring与Java EE的关系？

1. JavaEE 是平台规范，Spring 框架是技术

2. Spring 代码需要遵从 Java EE 的规范，同时 Spring 希望使用 AOP 技术代替 Java EE 的 EJB，两者既是竞争关系又是合作关系

3. Spring 官方宣称，Spring 和 JavaEE 不存在竞争关系，Spring 是 JavaEE 平台功能的有效补充和完善

<br>

### 1.4、Spring特点

1. IoC：（Inversion of Control）控制反转，使用 IoC 机制解耦（避免硬编码造成程序耦合）

2. AOP：（Aspect Orentied Programming）面向切面编程
3. 声明式事务管理
4. 对 JDBC 进行轻量级封装，更加灵活的操作数据库

5. Spring 提供 MVC 模式：Spring MVC
6. 提供文件上传，定时器常用工具类
7. 支持集成其他的框架

<br>

### 1.5、Spring 4 框架的架构

Test 模块：测试模块

Core Container 模块：Beans、Core、Context、SpEL

AOP 模块：AOP、Aspects、Instrumentation（引介）、Messaging

Data Access 模块： JDBC、ORM、OXM、JMS、Transaction

Web： WebSocket、Servlet、Web Portlet

**Spring 4.3 架构图**

![looper_2020-05-29_10-18-01](image\looper_2020-05-29_10-18-01.png)

<br>

### 1.6、Spring 5 特点

1. 支持 Java EE 8
2. 支持 JSR 规范：Servlet API - JSR340、WebSocket API - JSR356、Concurrency Utilities - JSR236、JSON Binding API - JSR367、Bean Validation - JSR303、JPA - JSR338、JMS - JSR914

<br>


### 1.7、Spring核心功能

**IoC 容器、Bean 生命周期管理、SpELl、AOP 容器、注解体系、数据验证**

<br>

### 1.8、Spring框架功能总览

**核心功能：Spring 容器与 Bean 的生命周期管理**

![looper_2020-05-29_10-24-39](image\looper_2020-05-29_10-24-39.png)

<br>

#### 1.8.2、Bean

The Spring Container：管理（生产、使用、销毁）Bean

![looper_2020-05-29_10-27-40](image\looper_2020-05-29_10-27-40.png)

<br>

#### 1.8.2、AOP（Aspect Oriented Programming）

将辅助代码，在不修改原来代码的基础上，织入到原始对象的代码中，对源代码进行增强

![looper_2020-05-29_10-30-32](image\looper_2020-05-29_10-30-32.png)

<br>

#### 1.8.3、数据整合

1. 事务管理：编程式事务、无侵入性声明式事务（推荐）

2. JDBCTemplate 支持

3. DAO 支持

4. ORM 框架支持：Hibernate、JPA、MyBatis

<br>

#### 1.8.4、Web层技术

Spring MVC、视图技术、其他 WEB 框架的集成

<br>

#### 1.8.5、外部系统集成

WEB Services、EJB、JMS、JMX、JCA CCI、Email、任务调度、动态语言支持、缓存

<br>

### 1.9、Spring 模块和 jar 对应关系

![looper_2020-05-29_10-34-17](E:\1.soft\personalNotes\Spring\image\looper_2020-05-29_10-34-17.png)

<br>

### 1.10、Spring、Spring Framework、SpringMVC、Spring Project之间的关系

Spring 是 Spring Framework、Spring MVC、Spring Project 的通称

Spring Framework 是 Spring Project 中最基础的一个，他是 Spring 平台的基础和核心，其他的 Spring Project 基本都会用到 Spring Framework

Spring MVC 是 Spring Framework 中的 Web 层技术

<br>

<br>

## 2、Spring使用

### 2.1、Spring 介绍

Spring 是一个开源框架，Spring 是于 2003 年兴起的一个轻量级的 Java 开发框架，由 Rod Johnson 在其著作`Expert One-On-One J2EE Development and Design` 中阐述的部分理念和原型衍生而来。它是为了解决企业应用开发的复杂性而创建的。Spring 使用基本的 JavaBean 来完成以前只可能由 EJB 完成的事情。然而，Spring 的用途不仅限于服务器端的开发。从简单性、可测试性和松耦合的角度而言，任何 Java 应用都可以从 Spring 中受益

#### 精简后：

Spring 的提出者：Rod Johnson

Spring 诞生的 2 本书

* Expert One-On-One J2EE Development and Design
* Expert One-On-One J2EE Development without EJB

Spring：是轻量级，面向切面（AOP）和控制反转（IoC）的容器

<br>

### 2.2、Spring官网

[Spring 官网](https://spring.io)

<br>

### 2.3、使用Spring的好处

#### 2.3.1、方便解耦，简化开发

* Spring 就是一个大工厂，可以将所有对象创建和依赖关系维护，交给 Spring 管理

<br>

#### 2.3.2、支持 AOP 编程

* Spring 提供面向切面编程，可以方便的实现对程序进行权限拦截、运行监控等功能

<br>

#### 2.3.3、支持声明式事务管理

* 只需要通过配置就可以完成对事务的管理，而无需手动编程

<br>

#### 2.3.4、方便程序测试

* Spring 对 Junit4 支持，可以通过注解方便的测试 Spring 程序

<br>

#### 2.3.5、集成各种框架

* Spring 不排斥各种优秀的开源框架，其内部提供了对各种优秀框架（如：Struts、Hibernate、MyBatis、Quartz 等）的直接支持

<br>

#### 2.3.6、降低 Java EE API 的使用难度

* Spring 对 Java EE 开发中非常难用的一些 API（JDBC、JavaMail、远程调用等）都提供了封装，使这些 API 应用难度大大降低 

<br>

### 2.4、写一个HelloSpring的小Demo

#### 2.4.1、创建好一个Maven项目

对于创建 Maven 项目，在介绍 Maven 的时候已经说过了，[详情点击此处]( https://github.com/1004032560/SpringNote/blob/master/01-02-Maven.md )

<br>

#### 2.4.2、引入Spring 的 jar 包

了解过 Maven 之后，对于 jar 包的引入，只需要在 pom.xml 中配置相应的信息即可，配置完成之后，Maven 会根据相应的坐标去查找，如果本地仓库中没有，则需要去中央仓库下载（看个人网速，以及一些原因）

~~~xml
<dependencies>
	<dependency>
    	<groupId>org.springframework</groupId>
    	<artifactId>spring-context</artifactId>
    	<version>5.0.15.RELEASE</version>
	</dependency>
</dependencies>
~~~

引入成功之后如下图，Maven 依赖中会出现 Spring 项目需要的 jar 包

![looper_2020-05-29_17-51-50](image\looper_2020-05-29_17-51-50.png)

<br>

#### 2.4.3、创建 Spring 核心配置文件

在 `src/main/resources` 目录下右键 `new` 选择 `other` 搜索 `xml` 选择 `XML File-` 点击 `next`

![looper_2020-05-29_17-57-12](image\looper_2020-05-29_17-57-12.png)

命名为 `applicationContext.xml` 创建配置文件

配置文件名称：可以任意起名，但是默认约定的是：`applicationContext.xml`

![looper_2020-05-29_17-57-32](image\looper_2020-05-29_17-57-32.png)

目录结构如下：

![looper_2020-05-29_17-57-41](image\looper_2020-05-29_17-57-41.png)

<br>

#### 2.4.4、编写 Spring 核心配置文件

在 `applicationContext.xml` 中编写配置文件

内容参考 Spring 文档

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd">
</beans>
~~~

在程序中读取 Spring 配置文件，通过 Spring 框架获得 Bean，完成相应操作

<br>

#### 2.4.5、编写HelloSpring

`service` 层下的 `HelloService` 类

~~~java
package com.looper.service;

public class HelloService {
    public String sayHello(String name) {
		return "Hello "+name;
	}
}
~~~

在 `applicationContext.xml` 中配置 Bean，将该 `HelloService` 类，创建对象的权利，交给 Spring 容器去创建对象，需要的时候从容器中调用 bean 对象

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">
	<!--
  		id:bean的名称,一般约定:类名首字母小写
  		class:类的全限定名(包名+类名)
	-->
    
	<bean id="helloService" class="com.looper.service.HelloService"></bean>

</beans>
~~~

`Test` 测试类

~~~java
public class SpringTest{
    
    public static void main(String[] args) {
    	//实例化Spring容器对象
    	ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    	//从容器对象拿bean
    	HelloService helloService = (HelloService) context.getBean("helloService");
    	//调用对象的方法
    	String result = helloService.sayHello("Spring");
    	//打印结果
    	System.out.println(result);
	}

}
~~~

结果：

**Hello Spring**