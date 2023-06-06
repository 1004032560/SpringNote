## 1、Spring事件

ApplicationContext 基于 Observer 模式提供了针对 Bean 的事件传播功能，通过 ApplicationCOntext 的 publishEvent 方法，可以将事件通知系统内的所有的 ApplicationListener

标准自定义事件结构如下：

<br>

### 1.1、Spring Framework 提供的标准事件

ContextRefreshedEvent

ContextStartedEvent

ContextStopedEvent

<br>

### 1.2、目标：测试 Spring 事件

#### 1.2.1、自定义事件

不发送邮件了，会触发 BlackListEvent 事件类，监听器就能监听到消息，在控制台打印出拉黑相关的信息，谁在什么时间给哪个地址发送了邮件

步骤：

1. 自定义事件 BlackListEvent 类，继承 ApplicationEvent 类

~~~java
package com.tjetc.event;

import org.springframework.context.ApplicationEvent;

/*
 * 自定义事件类,继承Spring中的ApplicationEvent
 */
public class BlackListEvent extends ApplicationEvent {

    //添加两个属性，邮件地址和内容
	private String address;
	private String context;
	
    //生成getter方法，没有生成setter方法是通过构造方法注入
	public String getAddress() {
		return address;
	}
	public String getContext() {
		return context;
	}

    //创建有参构造方法
	public BlackListEvent(Object source, String address, String context) {
		super(source);
		this.address = address;
		this.context = context;
	}
    //继承接口之后需要创建构造方法
	public BlackListEvent(Object source) {
		super(source);
	}
}
~~~

<br>

2. 事件（邮件）的业务处理 EmailService 类，实现 ApplicationEventPublisherAware 接口

~~~java
package com.tjetc.service;

import java.util.List;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.ApplicationEventPublisherAware;

import com.tjetc.event.BlackListEvent;

public class EmailService implements ApplicationEventPublisherAware {

	private List<String> blackList;
	private ApplicationEventPublisher applicationEventPublisher;
	
	public void setBlackList(List<String> blackList) {
		this.blackList = blackList;
    }

	@Override
	public void setApplicationEventPublisher(ApplicationEventPublisher applicationEventPublisher) {
		this.applicationEventPublisher = applicationEventPublisher;
	}
	
	/*
	 * 邮件业务方法
	 */
	public void sendEmail(String addres, String context) {
		if (blackList.contains(addres)) {//判断地址是否在黑名单中，在则不发邮件，发布自定义事件
			applicationEventPublisher.publishEvent(new BlackListEvent(this,addres,context));
		}
		//地址不在黑名单中，则发送邮件
		System.out.println("发送邮件：地址："+addres+"，内容："+context);
	}

}
~~~

<br>

3. 监听事件（接收邮件）BlackListNotifier 类，实现 ApplicationListener 接口，泛型参数为 BlackListEvent 监听这个事件类，当这个事件类被触发的时候，监听类也就会触发

~~~java
package com.tjetc.listener;

import org.springframework.context.ApplicationListener;

import com.tjetc.event.BlackListEvent;

/*
 * 接收邮件
 */
public class BlackListNotifier implements ApplicationListener<BlackListEvent> {

	@Override
	public void onApplicationEvent(BlackListEvent event) {
		System.out.println("拉黑消息:"+event.getSource().toString()+event.getTimestamp()+",address:"+event.getAddress());
	}

}
~~~

<br>

4. 在 applicationContext.xml 中配置

~~~xml
<bean id="blackListNotifier" class="com.tjetc.listener.BlackListNotifier"></bean>
<bean id="emailService" class="com.tjetc.service.EmailService">
	<property name="blackList">
		<list>
			<value>tom1@qq.com</value>
			<value>tom2@qq.com</value>
		</list>
	</property>
</bean>
~~~

<br>

5. 创建 JUnit 进行测试

~~~java
@Test
public void testEvent1() {
	ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	EmailService emailService = context.getBean(EmailService.class);
	emailService.sendEmail("aa@sina.com", "下午三点,全体开会");
	emailService.sendEmail("tom2@qq.com", "下午三点,全体开会");
}
~~~

<br>

6. 结果

~~~
发送邮件：地址：aa@sina.com，内容：下午三点,全体开会
拉黑消息:com.tjetc.service.EmailService@f0f2775,Sat May 30 11:44:34 CST 2020,adress:tom2@qq.com
发送邮件：地址：tom2@qq.com，内容：下午三点,全体开会
~~~

<br>

#### 1.2.2、接收多消息事件

多消息在单消息的基础上，主要修改第三步，接收多消息案例：

3. 监听事件（接收邮件）MessageNotifier 类，实现 ApplicationListener 接口，泛型参数为 ApplicationEvent 监听所有的信息，当这个事件类被触发的时候，监听类也就会触发

~~~java
package com.tjetc.listener;

import java.util.Date;

import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.context.event.ContextRefreshedEvent;

import com.tjetc.event.BlackListEvent;
//接收消息
public class MessageNotifier implements ApplicationListener<ApplicationEvent> {

  @Override
  public void onApplicationEvent(ApplicationEvent event) {
    // 判断，需要类型转换
    if (event instanceof BlackListEvent) {
      BlackListEvent blackListEvent=(BlackListEvent) event;
      System.out.println("拉黑消息:"+blackListEvent.getSource().toString()+","+new Date(blackListEvent.getTimestamp())+",adress:"+blackListEvent.getAddress());
    }
    else if (event instanceof ContextRefreshedEvent) {
      System.out.println("服务器刷新:"+event.getSource().toString()+","+new Date(event.getTimestamp()));
    }
    else if (event instanceof ContextClosedEvent) {
      System.out.println("服务器关闭:"+event.getSource().toString()+","+new Date(event.getTimestamp()));
    }
  }

}
~~~

<br>

4. 在 applicationContext.xml 中配置

~~~xml
<bean id="messageNotifier" class="com.tjetc.listener.MessageNotifier"></bean>
  	<bean id="emailService" class="com.tjetc.service.EmailService">
    	<property name="blackList">
     		<list>
        		<value>tom1@qq.com</value>
        		<value>tom2@qq.com</value>
      		</list>
    	</property>
</bean>
~~~

<br>

5. 创建 JUnit 进行测试

~~~java
@Test
public void testEvent2() {
     ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
     EmailService emailService = context.getBean(EmailService.class);
     emailService.sendEmail("aa@sina.com", "下午三点,全体开会");
     emailService.sendEmail("tom2@qq.com", "下午三点,全体开会");
     context.close();
}
~~~

<br>

6. 结果

~~~
信息: Loading XML bean definitions from class path resource [applicationContext.xml]
服务器刷新:org.springframework.context.support.ClassPathXmlApplicationContext@470e2030: startup date [Sat May 30 12:05:23 CST 2020]; root of context hierarchy,Sat May 30 12:05:23 CST 2020
发送邮件：地址：aa@sina.com，内容：下午三点,全体开会
拉黑消息:com.tjetc.service.EmailService@429bd883,Sat May 30 12:05:23 CST 2020,adress:tom2@qq.com
发送邮件：地址：tom2@qq.com，内容：下午三点,全体开会
五月 30, 2020 12:05:23 下午 org.springframework.context.support.AbstractApplicationContext doClose
信息: Closing org.springframework.context.support.ClassPathXmlApplicationContext@470e2030: startup date [Sat May 30 12:05:23 CST 2020]; root of context hierarchy
服务器关闭:org.springframework.context.support.ClassPathXmlApplicationContext@470e2030: startup date [Sat May 30 12:05:23 CST 2020]; root of context hierarchy,Sat May 30 12:05:23 CST 2020
~~~

<br>

<br>

## 2、BeanFactory接口

BeanFactory 的实现类，需要管理一群 bean definition ( bean 的定义 )，每个 bean definition 有一个唯一的识别 ID 。

BeanFactory 是 Spring 组件的注册中心和配置中心。

配置 Spring bean 对象时，最好使用 DI（Dependency Injection 依赖注入）方式，而不是从 BeanFactory 从查找配置。

BeanFactory 的实现类，应该尽可能的实现 bean 生命期接口，如下列表

<br>

<br>

## 3、HierarchicalBeanFactory接口

IOC 容器 ApplicationContext 的父接口。

IOC 容器是树状结构，这个结构源于 HierarchicalBeanFactory 的树结构。

使用 getBean() 查找 bean 对象时，如果在当前实例中未找到，则马上到父工厂中去查找

<br>

<br>

## 4、ListableBeanFactory接口

getBean() 的方式查找 bean 对象。还可以使用迭代方式，找到 Bean 工厂中的所有 Bean 实例

<br>

<br>

## 5、使用BeanDefinition接口描述Bean

<br>

<br>

## 6、ApplicationContext与BeanFactory的功能对比







