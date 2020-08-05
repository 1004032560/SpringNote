## 1、ZUUL

Zuul 是 netflix 开源的一个 API Gateway 服务器，本质上是一个 web servlet 应用。

Zuul 在云平台上提供动态路由，监控，弹性，安全等边缘服务的框架。

Zuul 相当于是设备和 Netflix 流应用的 Web 网站后端所有请求的前门。

<br>

## 2、代码实现

#### 2.1、配置依赖

新建 SpringBoot 项目，配置 XML 依赖

~~~xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-zuul</artifactId>
</dependency>
~~~

<br>

#### 2.2、主配置类

主配置类添加：@EnableZuulProxy 注解

~~~java
@SpringBootApplication
@EnableZuulProxy
public class GatewayApplication {

    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }

}
~~~

<br>

#### 2.3、配置路由规则

在 `application.yml` 配置文件中配置路由规则

~~~yml
spring:
  application:
    name: Gateway
server:
  port: 10010
zuul:
  routes:
    user-service:  #路由id，自定义名称
      path: /user-service/**  #映射路径
      url: http://127.0.0.1:8081   #映射路径实际对应的url
~~~

<br>

#### 2.4、启动测试

`http://localhost:10010/user-service/user/findById?id=1`

<br>

## 3、面向服务的路由

















