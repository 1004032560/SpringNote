## 1、Feign





## 2、负载均衡





## 3、Feign传参的几种方式

Feign 接口中的方法与服务提供者 controller 中的方法签名是一致的，Feign 的 @RequestMapping() 的 value 等于服务提供者的**类上的 @RequestMapping() 的值**与**方法上 @RequestMapping() 的值拼接**

3.1、使用 `restful` 方式传参使用 @PathVariable

3.2、使用 `?` 的形式传参

3.2、使用 `post` 的形式传参