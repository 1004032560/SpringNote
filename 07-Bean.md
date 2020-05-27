## 1、Bean的Scope属性



### 1.1、单例（singletone）：

当定义一个 bean 定义并且它的作用域是一个 singleton 时，Spring IoC 容器创建由该 bean 定义的对象的一个实例。 这个单实例存储在这个单例 bean 的缓存中，该 bean 的所有后续请求和引用都返回从缓存中获得对象。与 golf 的单例模式不一样的。

结论：Spring 容器中默认的作用域范围（Scope）是 singletone

注意：scope=singleton 情况下，bean 的构造方法什么时候执行的？

答：实例化容器的时候执行。



### 1.2、多例（prototype）：

当 scope="prototype" 时，每次调用 getBean("bean的名称")，都会生成一个新的对象。

注意：scope=prototype 情况下，bean 的构造方法什么时候执行的？

答：实例化容器的时候不执行，每次调用 getBean("bean的名称") 的时候执行。



## 2、Bean的生命周期回调处理

Bean 的生命周期回调处理，也就是 Bean 对象的初始化和销毁的方法

使用 JSR-250 @PostConstruct 和 @PreDestroy 是 bean 对象生命周期 callback 的最好方式。

使用 Spring 的 InitializingBean 和 DisposableBean 接口也可以。

使用接口的弊端是 callback 管理与 Spring 的代码产生了耦合，带来了不必要的麻烦。 



2.1、在 applicationContext.xml 配置 init-method 和 destroy-method 配置初始化和销毁方法

2.2、JSR250 注解 @PostConstruct 和 @PreDestroy

2.3、使用接口 InitializingBean 和 DisposableBean



## 3、aware接口

1. 设置成员变量

2. 实现接口

3. 重写 setXxx() 方法，对成员变量赋值

Spring 提供了很多 aware 接口，用于向 bean 对象提供 IOC 容器下的基础环境依赖。即在 bean 对象内获取各种环境信息数据。

实体类 B

~~~java
package com.tjetc.domain;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class B implements ApplicationContextAware{
	private ApplicationContext context;
	@Override
	public void setApplicationContext(ApplicationContext context)
			throws BeansException {
		System.out.println("setApplicationContext(),context="+context);
		this.context=context;
	}
}
~~~

applicationContext.xml 配置文件

~~~xml
<bean id="b" class="com.tjetc.domain.B"></bean>
~~~

JUnit 单元测试类

~~~java
@Test
public void testInit2(){
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    B b = context.getBean(B.class);
    System.out.println(b);
}
~~~









