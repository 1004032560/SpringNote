### 1、SpringMVC请求分发的三种方式

#### 1.1、类似于 Servlet 方式

~~~java
@Controller
@RequestMapping("/servlet")
public class ServletControlloer {

	@RequestMapping(method = RequestMethod.GET)
	public String doGet(HttpServletRequest request,HttpServletResponse response) {
		String name = request.getParameter("name");
		System.out.println("doGet()...");
		System.out.println(name);
		request.setAttribute("name","Hello "+name);
		//视图物理位置：/hello.jsp
		return "hello";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String doPost(String name, HttpServletRequest request,HttpServletResponse response) {
		//String name = request.getParameter("name");
		System.out.println("doPost()...");
		System.out.println(name);
		request.setAttribute("name","Hello "+name);
		return "hello";
	}
	
}
~~~



<br>

1.2、类似于 struts1 中 `m=add`

~~~java
@Controller
@RequestMapping("/struts1")
public class Struts1Controlloer {

	@RequestMapping(params = "m=add")
	public String add(String name,Model model) {
		System.out.println("add()...");
		model.addAttribute("name","Hello "+name);
		return "hello";
	}
	
	@RequestMapping(params = "m=update")
	public String update(String name,Model model) {
		System.out.println("update()...");
		model.addAttribute("name","Hello "+name);
		return "hello";
	}
	
}
~~~

<br>

1.3、类似于 struts2 中 `/user/add`

~~~java
@Controller//控制层，纳入spring容器管理
@RequestMapping("/user")
public class Struts2Controlloer {

	@RequestMapping("/add")
	public String add(String name,Model model) {
		System.out.println("add()...");
		model.addAttribute("name","Hello "+name);
		return "hello";
	}
	
	@RequestMapping("/update")
	public String update(String name,Model model) {
		System.out.println("update()...");
		model.addAttribute("name","Hello "+name);
		return "hello";
	}
	
}
~~~

浏览器地址栏：`http://localhost:8080/0609-01-springMVC/user/add.do?name=ZS `

将 `/user/add.do` 拼接起来

<br>

<br>

### 2、SpringMVC表单参数获取的三种方式

#### 2.1、方法参数直接写请求参数名

~~~java
@RequestMapping("/params")
public String hello(String name,String password, Model model) {
    System.out.println(name);
    System.out.println(password);
    model.addAttribute("name","name :"+name);
    return "hello";
}
~~~

<br>

#### 2.2、建立实体类，用实体类接受参数

~~~java
@RequestMapping("/params2")
public String hello2(User user, Model model) {
    System.out.println(user.getName());
    System.out.println(user.getPassworrd());
    model.addAttribute("name","name :"+user.getName());
    return "hello";
}
~~~

<br>

#### 2.3、restful通过@PathVariable()的注解

在 url 路径写请求参数的值

~~~java
@RequestMapping("/params3/{id}")
public String hello3(@PathVariable("id") int id, Model model) {
    System.out.println(id);
    model.addAttribute("name","id :"+id);
    return "hello";
}
~~~

<br>

<br>

### 3、SpringMVC请求转发和重定向

默认是请求转发（不写代表请求转发即 forward）

`return "index.jsp";` //请求转发

<br>

#### 3.1、请求转发

请求转发：`forward:url`

`return "forward:index.jsp";` //请求转发

`return "forward:user.do?method=reg5";` //请求转发

~~~java
@RequestMapping("/forward")
public String hello1(String name,Model model) {
    System.out.println(name);
    model.addAttribute("name","Hello "+name);
    return "forward:/hello.jsp";
}
~~~



<br>

#### 3.2、重定向

重定向：`redirect:url`

`return "redirect:user.do?method=reg5";` //重定向

`return "redirect:http://www.baidu.com";` //重定向

~~~java
@RequestMapping("/redirect")
public String hello2(String name,Model model) {
    System.out.println(name);
    model.addAttribute("name","Hello "+name);
    return "redirect:/forward.do?name=looper";
}
~~~



<br>

<br>

### 4、SpringMVC返回数据给页面

#### 4.1、Model

方法参数中使用 Model 类型的参数，方法体中使用 `model.addAttribute("name", name)` 这样就把值放入 request 作用域里

~~~java
@RequestMapping("/hello")
public String hello(String name,Model model) {
    System.out.println(name);
    model.addAttribute("name","Hello "+name);
    return "hello";
}
~~~

<br>

#### 4.2、ModelMap

是专门做解偶用的,只要把数据放到 ModelMap 中，他自动就会把数据同时放到 request 作用域中，在 jsp 页面就可以用 ${name} 直接显示出来

方法参数中使用 ModelMap 类型的参数，方法体中使用 `model.addAttribute("name", name)` 这样就把值放入request作用域里

~~~java
@RequestMapping("/hello2")
public String hello2(String name,ModelMap model) {
    System.out.println(name);
    model.put("name", name);
    model.addAttribute("name","Hello "+name);
    //视图物理位置：/hello.jsp
    return "hello";
}
~~~

<br>

#### 4.3、ModelAndView

从字面上来看，就是模型和视图。我们在 Controller 中，可以返回一个页面，比如 return "hello" 就是返回一个 hello.jsp 页面。其实我们也可以返回 ModelAndView 这个对象。ModelAndView 这个对象中可以保存你要转发的页面以及你要返回的数据

~~~java
@RequestMapping("/hello3")
public ModelAndView hello3(String name) {
    System.out.println(name);
    ModelAndView mv = new ModelAndView("hello");
    mv.addObject("name",name);
    //mv.setViewName("hello");
    return mv;
}
~~~

<br>

#### 4.4、Session

~~~java
@RequestMapping("/hello4")
public String hello4(String name,HttpSession session) {
    System.out.println(name);
    session.setAttribute("name", name);
    return "hello";
}
~~~

<br>

<br>

### 5、SpringMVC访问静态资源

#### 5.1、方式一

在 web.xml 配置 default（Tomcat 的 web 容器处理静态资源）在 DispatcherServlet 之前配置

~~~xml
<servlet-mapping>
	<servlet-name>default</servlet-name>
	<url-pattern>*.svg</url-pattern>
</servlet-mapping>

<servlet-mapping>
	<servlet-name>default</servlet-name>
	<url-pattern>*.jpg</url-pattern>
</servlet-mapping>

<servlet-mapping>
	<servlet-name>default</servlet-name>
	<url-pattern>*.js</url-pattern>
</servlet-mapping>

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
	<!-- <url-pattern>*.do</url-pattern> -->
	<url-pattern>/</url-pattern>
</servlet-mapping>
~~~

<br>

#### 5.2、方式二

在 springmvc.xml 中配置，配置 mvc 的一拖二，以及配置由 Tomcat 的 web 容器处理静态资源

~~~xml
<mvc:annotation-driven/>
<!-- 由Tomcat的web容器处理静态资源 -->
<mvc:default-servlet-handler/>
~~~

<br>

<br>

### 6、SpringMVC jackson的使用

1. 在 pom.xml 中引入 jackson-databind 的依赖

~~~xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.10.3</version>
</dependency>
~~~

<br>

2. 在 springmvc.xml 中配置注解驱动开启对

~~~xml
<!-- 配置注解驱动，开启对json的支持 -->
<mvc:annotation-driven/>
~~~

<br>

3. 测试类 JsonController

~~~java
@RequestMapping("/json")
@ResponseBody//将返回值代表的user对象
public User hello() {
    return new User("ZS","123456");
}
~~~

<br>

4. 结果

![looper_2020-06-09_11-43-23](..\image\looper_2020-06-09_11-43-23.png)

<br>

<br>

### 7、SpringMVC容器创建IOC

DispatcherServlet 的父级 FromworkServlet 的父级 HttpServletBean

DispatcherServlet 的爷爷 HttpServletBean 的 init() 方法创建 WebApplicationContext 容器.





### 8、Controller接口

#### SpringMVC的自定义controller的特点

控制器无需依赖 Servlet API 或 Porlet API





自定义 controller 实现 Controller 接口

~~~java
public class SecondControlloer implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		request.setAttribute("name", name);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("hello");
		mv.addObject("name", name);
		return mv;
	}
	
}
~~~





### 9、@RequestMapping

@RequestMapping 可以用于 class 和 method 类级的映射



#### 9.1、value和path属性

value 和 path 属性，互为别名，二者等效，代表请求的 URL，建议用 value

~~~java
//@RequestMapping(path = "/hello")
@RequestMapping(value = "/hello")
public String hello(String name,Model model) {
    System.out.println(name);
    model.addAttribute("name","Hello "+name);
    return "hello";
}
~~~

<br>

#### 9.2、method属性

~~~java
@Controller
@RequestMapping("/servlet")
public class ServletControlloer {

	@RequestMapping(method = RequestMethod.GET)
	public String doGet(HttpServletRequest request,HttpServletResponse response) {
		String name = request.getParameter("name");
		System.out.println("doGet()...");
		request.setAttribute("name","Hello "+name);
		return "hello";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String doPost(String name, HttpServletRequest request,HttpServletResponse response) {
		System.out.println("doPost()...");
		request.setAttribute("name","Hello "+name);
		return "hello";
	}
	
}
~~~

<br>

#### 9.3、@RequestParam

##### 9.3.1、参数映射

当请求参数的名称与方法参数的名称不一致时，就可以通过 @RequestParam 注解映射上去

`@RequestParam("请求参数的名称") String name` 将请求参数名映射到 name 参数上

~~~java
@RequestMapping(value = "/hello")
public String hello(@RequestParam("n")String name,Model model) {
    System.out.println(name);
    model.addAttribute("name","Hello "+name);
    return "hello";
}
~~~

<br>

##### 9.3.2、默认值

~~~java
@RequestMapping(path = "/hello")
public String hello(@RequestParam(value = "n",defaultValue = "zs")String name,Model model) {
    System.out.println(name);
    model.addAttribute("name","Hello "+name);
    return "hello";
}
~~~

<br>

##### 9.3.3、required是否必须有该参数

required 的默认值是 true

* required = true，必须要有参数，否则会报错

```java
@RequestMapping(path = "/hello")
public String hello(@RequestParam(name = "n")String name,Model model) {
	System.out.println(name);
	model.addAttribute("name","Hello "+name);
	//视图物理位置：/hello.jsp
	return "hello";
}
```
* required = false，请求可以没有参数，不会报错，但是参数结果默认为 null

```java
@RequestMapping(path = "/hello")
public String hello(@RequestParam(name = "n",required = false)String name,Model model) {
	System.out.println(name);
	model.addAttribute("name","Hello "+name);
	//视图物理位置：/hello.jsp
	return "hello";
}
```
<br>

##### 9.3.4、name和value属性互为别名（等价）

~~~java
@RequestMapping(path = "/hello")
public String hello(@RequestParam(value = "n")String name,Model model) {
	System.out.println(name);
	model.addAttribute("name","Hello "+name);
	//视图物理位置：/hello.jsp
	return "hello";
}
~~~



### 10、@PathVariable

#### 10.1、参数名称一致

restful 优雅格式，从路径中取得大括号里的参数的值，把该值映射到方法的参数中，两者的名称是一致的，如果不一致则会报错

~~~java
@RequestMapping("/params3/{id}")
public String hello3(@PathVariable int id, Model model) {
    System.out.println(id);
    model.addAttribute("name","id :"+id);
    return "hello";
}
~~~

<br>

#### 10.2、参数名称不一致

url 大括号里参数名和方法参数名不一致需要在 @PathVariable 中配置与大括号相同的参数名，映射到方法参数名上

~~~java
@RequestMapping("/params3/{id}")
public String hello3(@PathVariable("id") int id2, Model model) {
    System.out.println(id);
    model.addAttribute("name","id :"+id);
    return "hello";
}
~~~

<br>

#### 10.3、多个参数

同一个方法可以有多个 @PathVariable 映射不同的参数



<br>

10.4、

~~~java
@Controller
@RequestMapping("/user/{company}")
public class ReqParamsController {

	@RequestMapping("/params3/{id}")
	public String hello3(@PathVariable int id,@PathVariable("company") String company, Model model) {
		System.out.println(id);
		System.out.println(company);
		model.addAttribute("name","id :"+id);
		return "hello";
	}
	
}
~~~





### 11、@GetMapping和@PostMapping

#### 11.1、@GetMapping

~~~java
//@RequestMapping(method = RequestMethod.GET)
@GetMapping
public String doGet(HttpServletRequest request,HttpServletResponse response) {
    System.out.println("doGet()...");
    return "hello";
}
~~~



#### 11.2、@PostMapping

~~~java
//@RequestMapping(method = RequestMethod.POST)
@PostMapping
public String doPost(HttpServletRequest request,HttpServletResponse response) {
    System.out.println("doPost()...");
    return "hello";
}
~~~



### 12、@RequestMapping(params = {})



~~~java
@RequestMapping(path = "/hello2", params = "username")
public String hello2(String name,Model model) {
    System.out.println(name);
    model.addAttribute("name","Hello "+name);
    return "hello";
}
~~~



### 13、@RequestMapping(headers = {})

~~~java
@RequestMapping(path = "/hello3", headers = {"Host=localhost:8081"})
public String hello3(String name,Model model) {
    System.out.println(name);
    model.addAttribute("name","Hello "+name);
    return "hello";
}
~~~



### 14、控制器方法入参的类型





### 15、控制器方法的返回值类型













