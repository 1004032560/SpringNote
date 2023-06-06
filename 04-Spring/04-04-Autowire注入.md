## 1、Spring自动扫描bean



### 1.1、对自动扫描进行配置

* 在 applicationContext.xml 配置文件中的 beans 标签下配置 1 + 2

1：`xmlns:context="http://www.springframework.org/schema/context"`

2：`xsi:schemaLocation="
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd "`

* 在 applicationContext.xml 配置文件中配置扫描包

`<context:component-scan base-package="com.tjetc"></context:component-scan>`



### 1.2、自动扫描带有注解的 bean

Spring 自动扫描 bean，把类上带有@component、@Controller、@Service、@Repository注解的 bean 纳入 Spring 容器管理，相当于该类在 applicationContext.xml 中配置了 `<bean id="" class=""></bean>`

@Component：不好分层的时候，使用该注解

@Controller：控制 servlet 层写该注解

@Service：业务 service 层写该注解

@Repository：数据访问 dao 层写该注解



### 1.3、操作过程

添加 context 命名空间

~~~xml
<beans 
	xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:p="http://www.springframework.org/schema/p"
	xmlns:c="http://www.springframework.org/schema/c"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd
    ">
</beans>
~~~

配置扫描的基本包

~~~xml
<!-- 自动扫描com.tjetc包下的添加了@component、@Controller、@Service、@Repository -->
<!-- 在实现类中添加以上注解之后，就相当于该类在applicationContext.xml中配置了<bean id="" class=""></bean> -->
<context:component-scan base-package="com.tjetc"></context:component-scan>
~~~

例如：

~~~java
package com.tjetc.service.impl;

import org.springframework.stereotype.Service;

import com.tjetc.dao.UserDao;
import com.tjetc.dao.impl.UserDaoImpl;
import com.tjetc.service.UserService;

//@Service("userService")

@Service
//<bean id="userServiceImpl" class="com.tjetc.service.impl.UserServiceImpl">

public class UserServiceImpl implements UserService {

	private UserDao userDao = new UserDaoImpl();
	@Override
	public void login() {
		userDao.login();
	}
    
}
~~~

如果，注解中添加 `@Service("userService")` 一个值，则表示 id 的值为 `userService`；

如果，注解中没有添加 `@Service` 值，则表示 id 的值为 `userServiceImpl`，类名首字母小写。



## 2、AutoWire注入

### 2.1、AutoWire自动注入，默认按类型注入

同一个接口有多个实现类，就相当于同一个类型在 Spring 容器中有多个相同类型的对象，Spring 不知道使用哪一个，解决方法有如下：

1. 把成员变量的名字改为 Spring 容器中 bean 的名字
2. 把 Spring 容器中 bean 的名字改为成员变量的名字
3. 注释掉不用的注解，别让 Spring 去管理 没有的 bean
4. 在每个实现类的注解中写不同的名字，在引用的地方在 @ AutoWired 后边添加 @Qualified("bean 的名字") 注解**（推荐使用）**



### 2.2、Spring中支持五种自动装配模式

Spring 支持 5 种自动装配模式，如下：

#### 2.2.1、no

默认情况下，不自动装配，通过 "ref"attribute 手动设定。

#### 2.2.2、byName

根据 Property 的 Name 自动装配，如果一个 bean 的 name，和另一个 bean 中的 Property 的 name 相同，则自动装配这个 bean 到 Property 中。

#### 2.2.3、byType

根据 Property 的数据类型（Type）自动装配，如果一个 bean 的数据类型，兼容另一个 bean 中 Property 的数据类型，则自动装配。

#### 2.2.4、constructor

根据构造函数参数的数据类型，进行 byType 模式的自动装配，走的是构造方法

#### 2.2.5、autodetect

如果发现默认的构造函数，用 constructor 模式，否则，用 byType 模式。



### 2.3、Autowired模式的缺陷

* 对于 Java 基本类型和 String 等简单类型，无法使用 Autowire 方式注入

* 业务变化，注入的配置项必须改变时，没有 xml 配置修改容易。例如

~~~java
@Component("userDaoMysql")
public class UserDaoMySqlImpl implements UserDao{}
~~~

* 同一接口的多个实现类同时使用时，容易引发冲突





## 3、依赖注入总结：

### 3.1、IOC和DI的关系

IOC = 容器用反射创建对象 + 依赖（Dependency） + 注入（Inject）



### 3.2、注入循环引用问题

如何解决 Bean A 依赖 Bean B，同时 Bean B 要依赖注入 Bean A 的问题？ 

当循环引用注入无法避免时，使用 set 注入模式，不要使用构造函数注入





### 3.3、注入方式总结





实体都是有属性信息的，因此每个实体对象都有自己的特性，不能使用 singleton 配置。

EJB 中实体对象的管理，使用 EntityBean。每个实体 bean 与数据库中的一条表记录形成映射关系。EntityBean 是轻易不释放的，生命期相当长。

EJB 是重量级容器，有应用服务器支持，因此可以管理实体 bean。

而 Spring 是轻量级容器，无法管理大量有状态的实体对象。

如果在 Spring 中，把实体配置成 bean，且 scope="prototype"，是可以的，但是价值并不高。
















