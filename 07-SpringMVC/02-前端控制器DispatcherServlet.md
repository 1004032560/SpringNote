## 1、SpringMVC框架

### 1.1、什么是Spring MVC框架

Spring MVC 属于 SpringFrameWork 的后续产品，已经融合在 Spring Web Flow 里面。

Spring 框架提供了构建 Web 应用程序的全功能 MVC 模块

<br>

### 1.2、SpringMVC的API的URL

`http://docs.spring.io/spring/docs/current/javadoc-api/`

<br>

#### 1.3、Spring的官方说明文档URL

`http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/ `

<br>

<br>

## 2、Spring Web MVC架构

### 2.1、高层架构图





### 2.2、Spring MVC原理图





### 3.3、Spring MVC流程

1. 用户发送请求到前端控制器 DispatcherServlet
2. DispatcherServlet收到请求调用 HandlerMapping 处理器映射器
3. 



### 3.4、Spring组件说明





### 3.5、Spring组件功能介绍

#### 3.5.1、前端控制器

前端控制器





## 2、DispatcherServlet与IOC容器的关系

1. Tomcat 在启动的时候，会立即加载 DispatcherServlet 对象实例

2. DispatcherServlet 根据配置的 SpringMVC 的 XML 会实例化 Spring 容器的：Servlet WebApplicationContext
   * controller
   * resolver
   * handlerMapping

3. web.xml 还需要配置 ContextLoaderListener 在 Tomcat 启动的时候实例化 Spring 容器：Root WebApplicationContext
   * service
   * dao

4. 父子容器的关系：子容器的 bean 可以访问父容器的 bean，但是父容器的 bean 不能访问子容器的 bean

![looper_2020-06-08_22-20-52](..\image\looper_2020-06-08_22-20-52.png)







1.创建maven的web工程
2.加断点FrameworkServlet [line: 877] - service(HttpServletRequest, HttpServletResponse) doGet processRequest doService DispatcherServlet.doService->doDispatch      
3.在HelloController的model.add()前加断点
3.在DispatcherServlet mv = ha.handle(processedRequest, response, mappedHandler.getHandler());加断点
4.debug运行HelloServlet,
     1.先到FrameworkServlet断点,
     2.按F6,到DispatcherServlet mv = ha.handle()
   3.按F6,到HelloController,看到model的值
   4.按F8,执行完毕 















