## 1. 视图与控制层技术介绍

由于在JavaEE6之前，使用Servlet、Filter、Listener等，都必须要在web.xml中配置，非常的繁

琐。我们编写的Servlet需要继承HttpServlet，在里面只能写 doGet()、doPost() 等方法，无法采

用面向对象编程，非常的死板。还有参数传递、解析等问题，都可以优化。因此，针对JavaEE传

统实现的MVC框架纷纷诞生，如 Struts2、WebWorks 等，当前最流行的就是 SpringMVC，它们

最大的特点是控制器面向对象开发。 

针对JSP响应速度慢，数据修改不灵活的问题，也可以采用模板技术进行优化。如volocity和

FreeMarker等。 

现在视图层的主要趋势是使用 H5 + Ajax + Vue 等前端框架，这样前端页面响应速度快。变化灵活。SpringMVC支持与AJAX交互，支持视图层使用模板，支持报表技术 JasperReport，支持输出 PDF 或 Excel，支持 XSLT，支持 WebSocket 等，非常灵活。 





## 2. SpringMVC概述







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







































