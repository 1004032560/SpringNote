### 1、@RequestBody与消息转换器

@RequestBody 注解，指明方法参数与 http 的请求体数据绑定。

@RequestBody 用来接收前端传递给后端的 json 字符串，数据不是源于 http 的参数，而是源于 http 的请求体。

转换 http 请求体到方法参数，需要使用 HttpMessageConverter。消息转换器还负责把方法参数转换为 http 回应体（response body）

RequestMappingHandlerAdapter 支持 @RequestBody 注解，使用如下默认消息转换器：

* ByteArrayHttpMessageConverter：转换字节数组

* StringHttpMessageConverter：转换字符串

* FormHttpMessageConverter：转换表单数据到MultiValueMap<String, String>.

* SourceHttpMessageConverter：与XML数据源之间数据转换

@ResponseBody 用在方法上，将方法的返回值放到响应体在浏览器显示。

从4.0版本开始，也可以放在类上，类的所有方法都使用该注解



2、解决响应字符乱码问题

~~~xml
<!-- 配置注解驱动 -->
<mvc:annotation-driven>
	<mvc:message-converters register-defaults="true">
    	<bean class="org.springframework.http.converter.StringHttpMessageConverter">
        	<constructor-arg value="UTF-8"></constructor-arg>
    	</bean>
	</mvc:message-converters>
</mvc:annotation-driven>
<!-- 由Tomcat的web容器处理静态资源 -->
<mvc:default-servlet-handler/>
~~~





### 2、@ResponseBody





### 3、@RestController注解

如果你的控制器，只服务于JSON、XML、多媒体数据等，是REST风格，则通常使用@RestController注解。

@RestController相当于控制器中所有@RequestMapping方法，都使用了@ResponseBody注解。@RestController是一种简化写法。

@RestController = @ResponseBody + @Controller

在微服务开发中，所有的对外服务，一般都使用@RestController



@RestController = @RequestBody + @Controller

~~~java
@RestController
@RequestMapping("/test01")
public class Test01Controlloer {

	@RequestMapping("/resp")
	public String resp() {
		return "hello 张三";
	}
	
}
~~~

demo01.jsp

~~~jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<base href="${pageContext.request.contextPath }/">
	<script type="text/javascript" src="js/jquery-1.11.3.js"></script>
	<script type="text/javascript">
		function test() {
			$.ajax({
				url : "test01/resp",
				data : {},
				type : "get",
				contentType : "text",
				success : function(data) {
					alert(data);
				}
			});
		}
	</script>
</head>
<body>
	<button onclick="test()">测试</button>
</body>
</html>
~~~





### 4、HttpEntity

HttpEntity表示http的request和resposne实体，它由消息头和消息体组成。

从HttpEntity中可以获取http请求头和回应头，也可以获取http请求体和回应体信息。

HttpEntity的使用，与@RequestBody 、@ResponseBody类似。





### 5、@ModelAttribute

@ModelAttribute 向 model 添加属性和值

@ModelAttribute 注解，可以用于方法或方法参数

@ModelAttribute 注解的方法会在





#### 5.1、@ModelAttribute注解写在方法上

添加一个或者多个 model 属性

一个控制器允许存在有多个 @ModelAttribute 注解方法

如果 @ModelAttribute 中没有指定 model 



#### 5.2、@ModelAttribute注解写在方法参数上





### 6、@sessionAttribute和@sessionAttributes













