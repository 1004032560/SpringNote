## 1、Spring IOC 的特点

1. Spring 和 Java EE 一样都是 容器+组件 的管理模式
2. Spring 是轻量级的容器+组件的管理模式，Java EE 是重量级的容器+组件的模式

<br>

<br>

## 2、Spring容器与Bean生命周期的管理

控制反转：IoC（Inversion of Control）创建对象的权利，由应用程序创建改为由容器创建，控制权进行了转移

依赖注入：DI（Dependency Injection）把容器创建好的依赖对象注入进来

![looper_2020-05-29_10-24-39](image\looper_2020-05-29_10-24-39.png)

<br>

<br>

## 3、依赖注入的目标

1. 提高组件的可重用的概率
2. 为系统搭建一个灵活、可扩展的平台

<br>

<br>

## 4、IOC容器与ApplicationContext

1. ApplicationContext 代表了 IOC 容器，它同时负责配置、实例和装配 bean
2. IOC 容器操作基于两个包：`org.springframework.beans` 和 `org.springframework.context`

<br>

<br>

## 5、IOC容器创建的三种方法

1. 使用 `ClassPathXmlApplicationContext` 创建 IOC 容器

~~~java
//创建IoC容器
ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
~~~

<br>

2. 使用 `FileSystemXmlApplicationContext` 创建 IOC 容器

~~~java
//创建IoC容器
FileSystemXmlApplicationContext context = new FileSystemXmlApplicationContext("file:///E:/1.soft/Code/Spring/0525-spring/src/main/resources/applicationContext.xml");
~~~

<br>

3. 使用 `XmlWebApplicationContext` 创建 IOC 容器

<br>

<br>

## 6、从IOC容器中读取bean对象的三种方法

1. 容器对象.getBean("配置文件中配置的bean的id")；需要强制转换

~~~java
public static void main(String[] args) {

    //创建IoC容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("config/applicationContext.xml");
    
    //从容器中得到helloService
    HelloService helloService = (HelloService)context.getBean("helloService");

    String hello = helloService.sayHello("Zhang San");
    System.out.println(hello);

}
~~~

<br>

2. 容器对象.getBean("配置文件中配置的bean的id", bean.class)；可以精确定位，不需要强制转换

**推荐使用，该方式，进行精确定位**

~~~java
public static void main(String[] args) {

    //创建IoC容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("config/applicationContext.xml");
    
    //从容器中得到helloService
    HelloService helloService = context.getBean("helloService",HelloService.class);

    String hello = helloService.sayHello("Zhang San");
    System.out.println(hello);

}
~~~

<br>

3. 容器对象.getBean(bean.class)；不需要强制转换

~~~java
public static void main(String[] args) {

    //创建IoC容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("config/applicationContext.xml");
    
    //从容器中得到helloService
    HelloService helloService = context.getBean(HelloService.class);

    String hello = helloService.sayHello("Zhang San");
    System.out.println(hello);

}
~~~

<br>

<br>

## 7、Spring bean的定义

~~~xml
<bean id="helloService" class="com.tjetc.service.HelloService"></bean>
~~~

![looper_2020-05-29_21-01-04](image\looper_2020-05-29_21-01-04.png)

id：唯一标识

name：可以为一个 bean 指定多个名称，每个名称之间用逗号隔开

class：类的全限定名

scope：设置 bean 实例的作用域

ref：注入引用类型

list：对应 List 集合

set：对应 Set 集合

map：对应 Map 集合

entry：`<map>` 的子元素

<br>

## 8、Spring实例化bean的三种方式

### 8.1、使用默认的构造函数创建对象

~~~java
public class HelloService {

	public HelloService() {
		System.out.println("HelloService()构造");
	}
	
	public String sayHello(String name) {
		return "Hello " + name;
	}

}
~~~

`applicationContext.xml` 配置文件中配置

~~~xml
<bean id="helloService" class="com.looper.service.HelloService"></bean>
~~~

测试：

~~~java
public static void main(String[] args) {
    // 创建Ioc容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    HelloService helloService = context.getBean("helloService",HelloService.class);
    String hello = helloService.sayHello("张三");
    System.out.println(hello);
}
~~~

<br>

### 8.2、使用静态工厂方法创建 bean 对象

写一个工厂类，在工厂类中写一个静态方法，返回创建的对象

~~~java
public class HelloServiceFactory {
	public static HelloService createHelloService() {
		return new HelloService();
	}
}
~~~

`applicationContext.xml` 配置文件中配置工厂 bean

~~~xml
<bean id="helloService" class="com.looper.factory.HelloServiceFactory" factory-method="createHelloService"></bean>
~~~

测试：

~~~java
public static void main(String[] args) {
    // 创建Ioc容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    HelloService helloService = context.getBean("helloService",HelloService.class);
    String hello = helloService.sayHello("looper");
    System.out.println(hello);
}
~~~

<br>

### 8.3、创建工厂类，在工厂类中写一个方法，返回创建的对象

~~~java
public class HelloServiceFactory {

	public HelloService createHelloService() {
		System.out.println("createHelloService()创建HelloService");
		return new HelloService();
	}
	
}
~~~

`applicationContext.xml` 配置文件中配置

~~~xml
 <bean id="helloServiceFactory" class="com.looper.factory.HelloServiceFactory"></bean>
 <bean id="helloService3" factory-bean="helloServiceFactory" factory-method="createHelloService"></bean>
~~~

测试：

~~~java
public static void main(String[] args) {
    // 创建Ioc容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    HelloService helloService = context.getBean("helloService",HelloService.class);
    String hello = helloService.sayHello("looper");
    System.out.println(hello);
}
~~~

<br>