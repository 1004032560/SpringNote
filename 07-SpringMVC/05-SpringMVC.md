### 1、JsonView

使用 @JsonView 在 @ResponseBody 返回的 json 数据中，标识显示哪些数据，对于敏感数据应该忽略，如密码







### 2、 @ControllerAdvice

1. @ControllerAdvice 简单理解为全局控制器，它比 @Component 注解的控制器有更多功能。 

2. @ControllerAdvice 声明一个 class 为组件后，它表示当前控制器中用 @ExceptionHandler、@InitBinder、@ModelAttribute 注解的方法，在所有组件中共享。 



### 3、异步处理











### 4、视图解析

SpringMVC 管理视图主要使用 ViewResolver 和 View 这两个接口

1. ViewResolver 接口主要作用是：在视图的名字和视图的对象之间的映射，根据视图的名字（逻辑名和物理名）找到视图的对象，

   resolveViewName( String ViewName, Locale locale ) 的方法，返回一个 View 对象



2. View 接口主要作用是：把 model 数据提交给视图，进行数据渲

   render( Map model, HttpServletRequest request, HttpServletResponse response ) 的方法，返回值为 void



#### 4.1、JSP视图

InternalResourceView 为 JSP 视图

InternalResourceViewResolver 为 JSP 视图解析器

* 解析出来的都是 InternalResourceView 对象
* 会将 model 的数据存储到 request 属性中
* 利用 RequestDispatch 请求转发器，进行服务器端的请求转发，可以带数据



#### 4.2、常见的视图解析器



#### 4.3、视图解析器链

视图解析器链：指配置多个多个解析器，形成一条链

order属性：设置解析顺序，order 数值越高，解析越晚

InternalResourceViewResolver



### 5、重定向试图

#### 5.1、使用redirect方式的好处

防止



#### 5.2、SpringMVC重定向视图类的使用

RedirectView





#### 5.3、把数据传到重定向的目标

1. model 无法跨越 redirect 的 url 传输数据



RedirectAttributes 接口对象 ra

ra.addAttribute("msg","redirectMSG"); 会把数据当做 url 进行传递

会在 url 之后添加  『?参数名=参数值』 进行数据传输

所有在 JSP 中不能用 `${ }` 进行取值；在 JSP 中应该用