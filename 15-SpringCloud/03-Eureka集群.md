#### 1、配置Eureka集群

1. 新建SpringBoot工程

2. 选择Spring Web、Eureka Server场景启动器

3. 配置

   ~~~yml
   #application-server1.yml
   spring:
     application:
       name: Eureka-Server
   eureka:
     client:
       server-url:
         defaultZone: http://127.0.0.1:8762/eureka
   server:
     port: 8761
   
   #application-server1.yml
   spring:
     application:
       name: Eureka-Server
   eureka:
     client:
       server-url:
         defaultZone: http://127.0.0.1:8761/eureka
   server:
     port: 8762
   ~~~

4. 主配置类添加@EnableEurekaServer

5. Edit Configurations 中配置多个启动

   --spring.profiles.active=server1

<br>

#### 2、配置自身注册

~~~yml
eureka:
  client:
    eureka-server:
      defaultZone: http://127.0.0.1:8762/eureka
    #关闭自身注册
    register-with-eureka: false
~~~

<br>

#### 3、配置心跳时长

~~~yml
eureka:
  instance:
    #服务提供者每隔多长时间向Eureka注册中心发送一次心跳
    lease-renewal-interval-in-seconds: 30
    #服务器没有接收到服务提供者的心跳的超时时间
    lease-expiration-duration-in-seconds: 90
~~~

