### 1、Spring国际化

Spring架构支持国际化。

DispatcherServlet 调用 LocaleResolver 自动解析消息，使用本地的 local 信息。



#### 1.1、LocaleResolver解析器

LocaleResolver接口的继承体系：

* AcceptHeaderLocaleResolver：其实没有任何具体的实现，是通过浏览器头部的语言信息来进行多语言选择
* FixedLocaleResolver：设置固定的语言信息，这样整个体系的语言是一成不变的，用处不大
* CookieLocaleResolver：将语言信息设置到 Cookie 中，这样整个体系都可以获得语言信息
* SessionLocaleResolver：与 CookieLocaleResolver 类似，将语言信息放到 Session中，这样整个体系可以从 Session 中获得语言信息

<br>

#### 1.2、Locale拦截器

LocaleChangeInterceptor：



使用 Locale 拦截器，通过参数变化，可以改变 Locale 的设置



### 2、multipart文件上传

SpringMVC 使用 MultipartResolver 支持文件上传

这个方案需要 `commons-fileupload.jar` 的支持

enctype 属性可以设置或者返回表单内容的 MIME 类型

表单上产文件时，必须要配置 `<form enctype="multipart/form-data">`

表单的 enctype 的默认值为 `application/x-www-form-urlencoded` 表示上传的为文本

#### 文件上传案例：

~~~java
@Controller
@RequestMapping("/user")
public class UserControlloer {

	@RequestMapping("/add")
	public String add(User user, MultipartFile photo, HttpServletRequest request) {

		System.out.println(user);
		if (photo != null && photo.getSize() > 0) {
			String realPath = request.getServletContext().getRealPath("/upload/");
			File dir = new File(realPath);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			File destFile = new File(dir, photo.getOriginalFilename());
			try {
				photo.transferTo(destFile);
				System.out.println("上传成功");
				user.setPhotopath("upload/" + photo.getOriginalFilename());
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return "hello";
	}

}
~~~





### 3、SpringMVC异常处理

#### 3.1、HandlerExceptionResolver

SpringMVC异常处理，底层使用 HandlerExceptionResolver 接口处理异常

该接口有一个 resolveException 方法

~~~java
public interface HandlerExceptionResolver {

	@Nullable
	ModelAndView resolveException(
			HttpServletRequest request, HttpServletResponse response, @Nullable Object handler, Exception ex);

}
~~~



HandlerExceptionResolver 类的体系结构：



#### 3.2、SimpleMappingExceptionResolver







#### 3.3、@ControllerAdvice+@ExceptionHandler



~~~java
@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(Exception.class)
	public ModelAndView otherException(Exception e) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", e.getMessage());
		mv.setViewName("error/error");
		return mv;
	}
	
	@ExceptionHandler(NullPointerException.class)
	public ModelAndView nullPointerException(Exception e) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("msg", "空指针  "+e.getMessage());
		mv.setViewName("error/error");
		return mv;
	}

}
~~~



#### 3.4、@Responsebody的异常

在异常状态中携带异常信息码





#### 3.5、默认异常

















