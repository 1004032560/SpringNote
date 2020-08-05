## 1、Feign

Feign 可以把 Rest 的请求进行隐藏，伪装成类似 SpringMVC 的 Controller 一样。你不用再自己拼接 url，拼接参数等等操作，一切都交给 Feign 去做。

#### 1.1、添加依赖

~~~xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
~~~

<br>

#### 1.2、编写接口

~~~java
@FeignClient("user-service")
public interface UserInfoFeignClient {
    @GetMapping("findById/{id}")
    Map<String, String> findById(@PathVariable("id") int id) ;
}
~~~

<br>

#### 1.3、主类配置

添加注解：@EnableFeignClients

在该类中去除了 RestTemplate。Feign 中已经自动集成了 Ribbon 负载均衡，因此我们不需要自己定义 RestTemplate 了。

~~~java
@EnableFeignClients
@SpringCloudApplication
public class ShopUserConsumerApplication {

    public static void main(String[] args) {
        SpringApplication.run(ShopUserConsumerApplication.class, args);
    }

}
~~~

<br>

#### 1.4、客户端调用

客户端通过调用接口中的方法，然后去走该接口的方法的请求路径，从而实现调用服务端相应的操作。

~~~java
@Controller
public class UserController {

    @Autowired
    private UserInfoFeignClient userInfoFeignClient;

    @GetMapping("findById/{id}")
    @ResponseBody
    public Map<String, String> findById(@PathVariable("id") int id) {
        return userInfoFeignClient.findById(id);
    }

}
~~~

<br>

## 2、负载均衡

Feign 中本身已经集成了 Ribbon 依赖和自动配置

因此不需要额外引入依赖，也不需要再注册 `RestTemplate` 对象

<br>

## 3、Feign传参的几种方式

Feign 接口中的方法与服务提供者 controller 中的方法签名是一致的，Feign 的 @RequestMapping() 的 value 等于服务提供者的**类上的 @RequestMapping() 的值**与**方法上 @RequestMapping() 的值拼接**

#### 3.1、使用 `restful` 方式传参使用@PathVariable

~~~java
@FeignClient("worker-service")
public interface WorkerFeignClient {
    @RequestMapping("/worker/get/{id}")
    Worker get(@PathVariable("id")  int id);
}
~~~

<br>

#### 3.2、使用 `?` 的形式传参

~~~java
@FeignClient("worker-service")
public interface WorkerFeignClient {
    @RequestMapping("/worker/list")
    PageInfo<Worker> list(@RequestParam("curPage") String curPage,@RequestParam("name") String name);
}
~~~

<br>

#### 3.2、使用 `post` 的方式传递对象参数@RequestBody

~~~java
@FeignClient("worker-service")
public interface WorkerFeignClient {
    @RequestMapping("/worker/add")
    void add(@RequestBody Worker worker);
}
~~~