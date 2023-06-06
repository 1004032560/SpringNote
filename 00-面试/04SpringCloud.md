### 1、微服务

微服务架构是一种将每个单一应用程序作为一个小型服务，每个服务有单一职责，在自己的进程中运行，与轻量级机制（通常是 HTTP 资源的 API）进行通讯。



### 2、微服务特点：

* 单一职责：每个服务负责的功能是单一的
* 单一服务：拆分的粒度很小，每个单一应用只做一个服务
* 面向服务：每个服务之间通过 API 接口调用，不用关心其他服务是怎么实现的
* 自治：服务之间星湖独立互不干扰



### 3、远程调用的方法

1. RPC：远程过程调用，基于原生的 TCP 通信，速度快，效率高。（序列化）
2. HTTP：HTTP 是一种网络通信协议，基于 TCP，规定了数据传输的格式。

特点：RPC 方式更加透明，对用户更方便；HTTP 方式更加灵活，没有 API 和语言，跨平台，跨语言的规定。

微服务中更加强调自治，独立，灵活。而RPC的限制比较多，因此微服务框架中，一般都会采用 HTTP 的 REST 风格的服务。



### 4、SpringCloud

SpringCloud 是一种微服务架构的实现方式，是 Spring 家族的一员，技术强，使用方便。



### 5、SpringCloud中的组件

配置管理，服务发现，智能路由，负载均衡，熔断器，控制总线，集群状态等功能

Eureka注册中心、Zuul网关、Ribbon负载均衡、Feign服务调用、Hystix熔断器



### 6、Eureka注册中心的执行流程

1. Eureka：就是注册中心，对外暴露自己的地址
2. 提供者：启动后向注册中心注册自己的信息
3. 消费者：向注册中心订阅服务，注册中心会将对应服务的提供者的地址列表发送给消费者，并定期更新
4. 心跳（续约）：提供者会定时通过 HTTP 方式向 Eureka 刷新自己的状态





### 7、注册中心的配置

~~~yml
spring:
  application:
    name: Eureka-Server
eureka:
  client:
    service-url:
      defaultZone: http://127.0.0.1:8761/eureka
    register-with-eureka: false
  instace:
    lease-renewal-interval-seconds: 30 #服务提供者每隔多长时间向Eureka注册中心发送一次心跳
    lease-expriation-duration-in-seconds: 90 #服务器没有接收到服务提供者的心跳的超时时间
server:
  port: 8761
~~~

@EnableEurekaServer 开启 Server 服务

@EnableDiscoveryClient 开启提供者和消费者服务



### 8、多个EurekaServer进行数据同步

不同的 Eureka Server 通过 Replicate（复制）进行数据同步

服务器启动后 Eureka 注册，Eureka Server 会将注册信息向其他的 Eureka Server 进行同步



### 9、Ribbon负载均衡

Ribbon 是 Netflix 发布负载均衡器，它有助于控制 HTTP 和 TCP客户端的行为。

使用负载均衡器时，默认会采用轮询方式，逐一访问每一台机器。



### 10、配置负载均衡

配置两个yml

~~~yml
spring:
  application:
    name: User-Service
eureka:
  client:
    service-url:
      defaultZone: http://127.0.0.1:8761/eureka,http://127.0.0.1:8762/eureka
server:
  port: 8082
~~~

和

~~~yml
spring:
  application:
    name: User-Service
eureka:
  client:
    service-url:
      defaultZone: http://127.0.0.1:8761/eureka,http://127.0.0.1:8762/eureka
server:
  port: 8081
~~~

使用 Ribbon 优化 RestTemplate

~~~java
@Bean
@LoadBalanced
public RestTemplate restTemplate() {
	return new RestTemplate() ;
}
~~~



### 12、Hystix熔断器

Hystix 是 Netflix 开发的开源的一个延迟和容错库，用于隔离访问远程服务、第三方库、防止出现级联失败



### 13、Hystix原理

熔断器，发生故障，掉线等会启动熔断，对失败的操作进行回滚



### 14、Hystix配置

~~~xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
</dependency>
~~~

主配置类：@EnableClientBreaker

Controller 控制层（一个方法）：@HystrixCommand(fallbackMethod = "fallbackWait")

Controller 控制层（多个方法）：@DefaultProperties(defaultFallback = "fallback4Wait")



### 15、Hystix的状态

Closed：熔断器关闭状态（所有请求都返回成功）

Open：熔断器打开状态（出现故障，熔断器打开）

HalfOpen：熔断器半开状态（熔断器进入半开状态之后，允许部分请求通过；如果都成功了，则认为恢复了，关闭熔断器；反之则打开熔断器）



### 16、Feign

Feign 可以把 Rest 的请求进行隐藏，伪装成类似 SpringMVC 的 Controller 一样。  



### 17、配置Feign

1. 写 Feign 接口，添加注解@FeignClient("服务提供者")
2. 主配置类：@EnableFeignClients

在该类中去除了 RestTemplate。Feign 中已经自动集成了 Ribbon 负载均衡，因此我们不需要自己定义 RestTemplate 了。

3. 服务消费者对 Feign 进行调用



### 18、Feign传参

优雅格式：@PathVariable("参数名")

POST请求：@RequestBody

GET请求：@RequestParam("参数名")





### 19、Zuul

Zuul 是 Netflix 开源的一个 API GateWay 服务器，本质是 Web Servlet 应用

Zuul 在云平台上提供动态路由，监控，弹性，安全等边缘服务框架

无论是来自于客户端（PC或移动端）的请求，还是服务内部调用。一切对服务的请求都会经过 Zuul 这个网关，然后再由网关来实现 鉴权、动态路由等等操作。Zuul就是我们服务的统一入口。



### 20、配置路由

~~~yml
zuul:
  routes:
    user-service:  #路由id，自定义名称
      path: /user-service/**  #映射路径
      url: http://127.0.0.1:8081   #映射路径实际对应的url
~~~

配置注解：@EnableZuulProxy



### 21、JPA

JPA是Java Persistence API的简称，中文名Java持久层API，是JDK 5.0注解或XML描述对象－关系表的映射关系，并将运行期的实体对象持久化到数据库中。



### 22、JPA主键策略

JPA提供的四种标准用法为TABLE,SEQUENCE,IDENTITY,AUTO。

IDENTITY：主键由数据库自动生成（主要是自动增长型）

SEQUENCE：根据底层数据库的序列来生成主键，条件是数据库支持序列。

AUTO：主键由程序控制

TABLE：使用一个特定的数据库表格来保存主键



### 23、RabbitMQ

RabbitMQ 是以一个开源的消息代理和消息队列服务器，用来通过普通协议在完全不同的应用之间共享数据。

RabbitMQ 是使用 Erlang 语言编写的，并且 RabbitMQ 是基于 AMQP 协议的。



### 24、RabbitMQ

1. 开源、性能优秀、稳定性高
2. 提供可靠的消息投递模式、返回模式
3. 与 SpringAMQP 完美整合、API 丰富



### 25、RabbitMQ运行机制

#### 组成部分：

* Broker：消息队列服务进程，此进程包括两个部分：Exchange 和 Queue
* Exchange：消息队列交换机，按一定的规则将消息路由转发到某个队列，对消息进行过滤
* Queue：消息队列，存储消息的队列，消息到达队列并转发给指定的消费方
* Provider：消息生产者，将生产的消息发送到 MQ
* Consumer：消息消费者，接收 MQ 转发的消息

#### 消息发布接收流程：

1. 生产者和 Broker 建立 TCP 连接
2. 生产者和 Broker 建立通道（Channel）
3. 生产者通过通道消息发送 Broker，由 Exchange 将消息进行转发
4. Exchange 将消息转发到指定的队列（Queue）
5. 消费者监听消息队列，一有消息就接收消息



### 26、RabbitMQ消息模型

基本消息模型：一（服务器）发送，一（客户端）接收

Work消息模型：多个客户端之间竞争

订阅消息模型：广播、定向、通配符匹配。