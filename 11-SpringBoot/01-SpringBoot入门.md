## 1、SpringBoot简介

Spring Boot 是由 Pivotal 团队提供的全新的微服务框架。

其设计目的是用来简化 Spring 应用的初始搭建以及开发过程。

该框架使用了特定的方式来进行配置，从而使开发人员不再需要定义样板化的配置。

通过这种方式，Spring Boot 致力于在蓬勃发展的快速应用开发领域（rapid application development）成为领导者。

Spring Boot 提供了一种新的编程范式，能在最小的阻力下开发 Spring 应用程序。

有了它， 开发人员可以更加敏捷地开发 Spring 应用程序，专注于应用程序的功能，不用在 Spring 的配置上多花功夫，甚至完全不用配置。

实际上，Spring Boot 的一项重要工作就是让 Spring 配置不再成为开发路上的绊脚石。

<br>

## 2、Spring Boot搭建

1. STS（Spring Tools Suite）提供的向导：创建 Spring Starter Project

2. 创建项目名，包名，打包方式（jar、war）

3. 选择版本号，选择 web 中的 Spring Web Starter

4. 下一步直接点 finish 完成

   配置文件 application.properties 默认是空的

5. 测试搭建是否成功，创建类 HelloController

~~~java
@Controller
publicclassHelloController {
	@RequestMapping("/hello")
	@ResponseBody
	public String hello() {
		System.out.println("HelloController.hello()...");
		return"hello SpringBoot!";
	}
}
~~~

6. 运行项目

7. 在浏览器地址栏输入：`http://localhost:8080/hello`

<br>

## 3、SpringBoot优点

### 3.1、使编码变得简单

SpringBoot 采用 Java config 的方式，对 Spring 进行配置，并且提供了大量的注解，极大地提高了工作效率。

### 3.2、使配置变得简单

SpringBoot 提供了许多默认的配置，

### 3.3、使部署变得简单

Spring Boot 内置了三种 Servlet 容器：tomcat、jetty、undertow

所以，只需要一个 Java 环境就可以运行 SpringBoot 的项目。SpringBoot 的项目可以打包成一个 jar 包，然后通过 java-jar xxx.jar 来运行。SpringBoot 的项目的入口是一个 main 方法，运行该方法即可。

也可以将 SpringBoot 应用部署到任何兼容 Servlet 3.0+ 的容器。

### 3.4、使监控变得简单

SpringBoot 提供了 actuator 包，可以使用它来对应用进行监控。

pom.xml 添加 actuator 启动器

~~~xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
~~~

重启应用之后，在浏览器地址栏输入 `http://localhost:8080/actuator/health` 查看启动状态 `{"status":"UP"}`

<br>

## 4、配置文件

Spring Boot 使用一个全局的配置文件，配置文件名是固定的：

* application.properties

* application.yml

配置文件的作用：修改 SpringBoot 自动配置的默认值；SpringBoot 在底层都给我们自动配置好；

配置文件放在 src/main/resources 目录或者类路径 /config 下 yml 是 YAML（Yet Another Markup Language）语言的文件，以数据为中心，比 json、xml 等更适合做配置文件，参考语法规范 `http://www.yaml.org/`；

全局配置文件的可以对一些默认配置值进行修改

YAML（YAML Ain't Markup Language）

YAML A Markup Language：是一个标记语言

YAML isn't Markup Language：不是一个标记语言；

标记语言：

以前的配置文件；大多都使用的是 xxxx.xml 文件；

YAML：以数据为中心，比 json、xml 等更适合做配置文件；

YAML：配置例子

~~~yml
server:
  port: 8082
~~~

