## 1. 视图与控制层技术介绍

由于在 JavaEE6 之前，使用 Servlet、Filter、Listener 等，都必须要在 web.xml 中配置，非常的繁

琐。我们编写的 Servlet 需要继承 HttpServlet，在里面只能写 doGet()、doPost() 等方法，无法采

用面向对象编程，非常的死板。还有参数传递、解析等问题，都可以优化。因此，针对 JavaEE 传

统实现的 MVC 框架纷纷诞生，如 Struts2、WebWorks 等，当前最流行的就是 SpringMVC，它们

最大的特点是控制器面向对象开发。 

针对 JSP 响应速度慢，数据修改不灵活的问题，也可以采用模板技术进行优化。如 volocity 和 FreeMarker 等。 

现在视图层的主要趋势是使用 H5 + Ajax + Vue 等前端框架，这样前端页面响应速度快。变化灵活。SpringMVC支持与AJAX交互，支持视图层使用模板，支持报表技术 JasperReport，支持输出 PDF 或 Excel，支持 XSLT，支持 WebSocket 等，非常灵活。

<br>

​    1.控制层技术：SpringMVC，Struts2，WebWorks，Servlet

​    2.视图层技术：JSP，volocity，Freemarker，Vue，H5



## 2. SpringMVC概述

1. 不要重复发明轮子，是Rod Johson奉行的至理名言，也是整个Spring Framework的基石。但是SpringMVC是个唯一的例外，原因据说是市场上的所有MVC框架都太烂了，没有整合的必要性，因此只能新造一个轮子。

2. SpringMVC框架围绕DispatcherServlet设计而成。DispatcherServlet的主要作用是分发请求到不同的Controller、根据Controller返回的结果转向不同的视图。Controller的处理，基于@Controller和@RequestMapping等注解。使用@PathVariable注解，@Controller 还允许你创建RESTful风格的web站点。

3. SpringMVC框架设计的核心理念，是著名的OCP原则：Open for extension, closed for modification。SpringMVC框架的很多核心类的重要方法，都被标记了final，即不允许你通过重写的方式改变其行为，这也是满足OCP原则的体现。

4. SpringMVC 的视图解决方案，非常的灵活。视图名字和 Controller 返回的 Model 数据，被组成ModelAndView对象。一个ModelAndView 实例包含一个视图名字和一个类型为Map的model对象。视图名字的解析，由可配置的视图解析器处理。Map类型的model是高度抽象的，适用于各种表现层技术。这些视图技术有JSP, Velocity ，Freemarker，JSON，XML等。Map可以根据不同的视图，选择合适的格式，如JSP页面转为request属性格式，对于Velocity转为模板格式。 





## 3. SpringMVC的特性支持







## 4. SpringMVC案例







## 5. MVC架构

![looper_2020-06-08_12-04-41](..\image\looper_2020-06-08_12-04-41.png)



## 6. HelloSpringMVC入门案例

创建 Maven Web 工程



在 pom.xml 中引入spring-mvc 的 jar 包依赖

~~~xml
  	<dependency>
  		<groupId>org.springframework</groupId>
  		<artifactId>spring-webmvc</artifactId>
  		<version>5.0.15.RELEASE</version>
  	</dependency>
~~~





在 web.xml 中配置前端控制器

~~~xml
<servlet>
	<servlet-name>springMvc</servlet-name>
	<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
	<!-- springMVC默认的配置文件在WEB-INF下的名称为servlet的名字-servlet.xml-->
	<!-- 如果修改默认的位置和名字需要去配置servlet的init-param在这里进行修改 -->
	<init-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>classpath:springmvc.xml</param-value>
	</init-param>
	<!-- 配置在Tomcat启动的时候启动前端控制器 -->
	<load-on-startup>1</load-on-startup>
</servlet>
<servlet-mapping>
	<servlet-name>springMvc</servlet-name>
	<url-pattern>*.do</url-pattern>
</servlet-mapping>
~~~







































