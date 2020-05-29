## 1、Spring资源管理

### 1.1、spring资源管理的特点

Spring 的资源管理在 JDK 的基础

1. 隐藏底层的实现
2.  新增资源存在判断、资源操作权限相关的功能，相对于 `java.net.URL` 资源不存在则设置为 null 更友好
3. 支持通配符获取资源

<br>

### 1.2、spring管理的资源

UrlResource、ClassPathResource、FileSystemResource、

ServletContextResource、InputStreamResource、ByteArrayResource

<br>

### 1.3、资源协议与路径

对于 `ClassPathXmlApplicationContext` 容器对象：

![looper_2020-05-29_20-05-50](image\looper_2020-05-29_20-05-50.png)

四种方式：`classpath:`、`file:///`、`http(s):` 以及无协议

classpath：从当前 JVM 的 classpath 根路径开始获取资源（ClassPathResource）

file：从当前操作系统（文件路径）的路径获取资源（UrlResource）

http(s)：从互联网获取资源（UrlResource）

无协议：根据应用上下文获取资源

`classpath:`、`file:///`、`http(s):` 这三个协议都很明确的指明了获取资源的路径，但是没有声明协议（无协议）的情况就比较特殊，需要根据上下文来判定适用的路径。

~~~java
public class SpringTest {

	public static void main(String[] args) {
		
		//创建IoC容器
		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		//使用classpath:类路径协议
		Resource resource1 = context.getResource("classpath:applicationContext.xml");
		System.out.println("resource1 = "+resource1);
		
		//使用无协议
		//对于ClassPathXmlApplicationContext对象不写协议会，从类路径下的根下去找资源
		Resource resource2 = context.getResource("applicationContext.xml");
		System.out.println("resource2 = "+resource2);
		
		//使用 file:/// 文件系统协议
		Resource resource3 = context.getResource("file:///E:/1.soft/Code/Spring/0525-spring/src/main/resources/applicationContext.xml");		
		System.out.println("resource3 = "+resource3);
		
		//使用 http(s)协议
		Resource resource4 = context.getResource("https://spring.io/projects/spring-framework");
		System.out.println("resource4 = "+resource4);
	}

}
~~~

结果：

`resource1 = class path resource [applicationContext.xml]`
`resource2 = class path resource [applicationContext.xml]`
`resource3 = URL [file:/E:/1.soft/Code/Spring/0525-spring/src/main/resources/applicationContext.xml]`
`resource4 = URL [https://spring.io/projects/spring-framework]`

<br>

### 1.4、Spring使用什么接口访问底层资源

使用 Resource 接口，访问底层资源

![looper_2020-05-29_20-10-14](image\looper_2020-05-29_20-10-14.png)

![looper_2020-05-29_20-11-58](image\looper_2020-05-29_20-11-58.png)

<br>

### 1.5、Spring使用什么接口加载资源

使用 ResourceLoader 接口，加载资源，通过 getResource 方法获取资源

IOC 容器实现了 ResourceLoader 接口，因此可以随时加载资源

![looper_2020-05-29_20-12-40](image\looper_2020-05-29_20-12-40.png)

<br>

### 1.6、通过配置获取资源

![looper_2020-05-29_20-15-43](image\looper_2020-05-29_20-15-43.png)

#### 案例：

1. 写一个类 HelloService，添加 Resource 类型的属性 template 设置 setter 和 getter 方法

~~~java
package com.looper.service;

import org.springframework.core.io.Resource;

public class HelloService {
	
    private Resource template;

	public Resource getTemplate() {
		return template;
	}

	public void setTemplate(Resource template) {
		this.template = template;
	}
	
}
~~~

2. 在 `apllicationContext.xml` 中配置 bean 交给 Spring 容器管理

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

	<bean id="helloService" class="com.looper.service.HelloService">
        <!-- 通过配置文件的形式，来将四种资源获取方式配置在属性中 -->
		<!-- <property name="template" value="classpath:applicationContext.xml"></property> -->
		<!-- <property name="template" value="file:///E:/1.soft/Code/Spring/0525-spring/src/main/resources/applicationContext.xml"></property> -->
		<property name="template" value="https://spring.io/projects/spring-framework"></property>
		<!-- <property name="template" value="applicationContext.xml"></property> -->
	</bean>

</beans>
~~~

测试类 Test 的主方法：

~~~java
public static void main(String[] args) {
    // 创建Ioc容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    //从容器得到helloService
    HelloService helloService = (HelloService) context.getBean("helloService");
    //得到helloService的template属性
    Resource template = helloService.getTemplate();
    //打印template属性
    System.out.println(template);
}

~~~

结果：

`URL [https://spring.io/projects/spring-framework]`

<br>

### 1.7、应用上下文与资源

#### 1.7.1、从classpath中加载资源

类路径的根或者根下的目录均可以加载资源

~~~java
package com.tjetc.service;

public class HelloService {
	public String sayHello(String name) {
		return "Hello " + name;
	}
}
~~~

`applicationContext.xml` 中的配置

~~~xml
<bean id="helloService" class="com.tjetc.service.HelloService"></bean>
~~~

测试代码

~~~java
public static void main(String[] args) {
    // 创建Ioc容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("conf/applicationContext.xml");
    HelloService helloService = (HelloService) context.getBean("helloService");
    String hello = helloService.sayHello("Spring");
    System.out.println(hello);
}
~~~

结果：

`Hello Spring`

<br>

#### 1.7.2、从当前程序运行的工作目录，用相对路径加载资源

ClassPathXmlApplicationContext：当前运行的工作目录是类路径的根路径

~~~java
public class SpringTest2 {

	public static void main(String[] args) {
		
		//创建IoC容器
		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("config/applicationContext.xml");
        
		//从容器中得到helloService
		HelloService helloService = (HelloService)context.getBean("helloService");
        
		String hello = helloService.sayHello("Spring");
		System.out.println(hello);
		
	}
}
~~~

FileSystemXmlApplicationContext：当前运行的工作目录是工程的根路径

1. 将配置文件移动到工程的根路径下，new 该对象的时候不用加 classpath
2. 配置文件在类路径的根路径下，new 该对象的时候需要加 classpath（使用前缀加载资源）

~~~java
public class SpringTest3 {

	public static void main(String[] args) {
		
		//创建IoC容器,使用前缀 classpath 获取资源
		FileSystemXmlApplicationContext context = new FileSystemXmlApplicationContext("classpath:config/applicationContext.xml");
		//从容器中得到helloService
		HelloService helloService = (HelloService)context.getBean("helloService");
		
		String hello = helloService.sayHello("Spring");
		System.out.println(hello);
	}

}
~~~

<br>

#### 1.7.3、使用指定前缀，从classpath中加载资源

~~~java
public static void main(String[] args) {
    // 创建Ioc容器
    FileSystemXmlApplicationContext context = new FileSystemXmlApplicationContext("classpath:conf/applicationContext.xml");
    HelloService helloService = (HelloService) context.getBean("helloService");
    String hello = helloService.sayHello("Spring");
    System.out.println(hello);
}
~~~

<br>

#### 1.7.4、使用通配符 `*` 加载资源

~~~java
public class SpringTest3 {

	public static void main(String[] args) {
		
		//创建IoC容器,使用通配符 * 获取资源
		FileSystemXmlApplicationContext context = new FileSystemXmlApplicationContext("classpath:config/*.xml");
		//从容器中得到helloService
		HelloService helloService = (HelloService)context.getBean("helloService");
		
		String hello = helloService.sayHello("Spring");
		System.out.println(hello);
		
	}
}
~~~



