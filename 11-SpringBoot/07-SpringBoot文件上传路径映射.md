## SpringBoot文件上传路径映射

#### 1、创建配置类

在 config 包下创建配置类实现 WebMvcCOnfigurer 类，重写 addResourceHandlers 方法

~~~java
@Configuration//配置类
public class MyInterceptConfig implements WebMvcConfigurer {

	/**
	 * 添加资源映射的配置
	 * url的路径
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/upload/**").addResourceLocations("file:D:/images/");
	}

}
~~~

<br>

#### 2、在Controller中创建真实路径下的文件夹

