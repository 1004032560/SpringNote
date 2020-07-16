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

### 3.3、使部署变得简单

### 3.4、使监控变得简单

SpringBoot 提供了 actuator 包，可以使用它来对应用进行监控。

pom.xml 添加 actuator 启动器

~~~xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
~~~

