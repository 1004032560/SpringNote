## 2、注解的方式声明切面

### 2.1、注解声明切面的案例

1. 添加 AOP 命名空间（一拖二）

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans default-lazy-init="true"
	xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/aop
        https://www.springframework.org/schema/aop/spring-aop.xsd
    ">
~~~

<br>

2. 启动 @Aspect 注解的支持

~~~xml
<aop:aspectj-autoproxy/>
<!-- 启动注解扫描机制 -->
<context:component-scan base-package="com.tjetc"/>
~~~

<br>

3. 添加 aspectjweaver 的 Maven 依赖

~~~xml
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>1.9.5</version>
</dependency>
~~~

<br>

4. 创建一个切面类

~~~java
@Component
@Aspect//切面类=切点+增强
public class TransactionPrint {
    //切点
	@Pointcut("execution(* com.tjetc.service..*.*(..))") //定位到连接点的条件
	private void anyMethod(){} //方法签名,返回值void
	
	//下面内容是增强部分
	@Before("anyMethod()")
	public void before() {
		System.out.println("前置增强");
	}
	@AfterReturning("anyMethod()")
	public void afterReturning() {
		System.out.println("后置增强");
	}
	@After("anyMethod()")
	public void after() {
		System.out.println("后置增强");
	}
	@AfterThrowing("anyMethod()")
	public void afterThrowing() {
		System.out.println("例外增强");
	}
	
	@Around("anyMethod()")
	public Object around(ProceedingJoinPoint pjp) throws Throwable{
		System.out.println("环绕通知开始");
		Object proceed = pjp.proceed();
		System.out.println("环绕通知结束");
		return proceed;
	}
}
~~~

<br>

5. 业务类（被代理的目标类）

~~~java
@Service
public class PersonService {
	public void add() {
		System.out.println("PersonService.add()");
	}

	public void update() {
		System.out.println("PersonService.update()");
	}

	public void del() {
		System.out.println("PersonService.del()");
	}
}
~~~

<br>

6. 测试类

~~~java
public static void main(String[] args) {
    // 实例化容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    //从容器得到bean
    PersonService personService = context.getBean(PersonService.class);
    //personService是什么对象?
    System.out.println(personService.getClass());
    //调用personService的方法
    personService.add();
}
~~~

结果：

~~~
class com.tjetc.service.PersonService$$EnhancerBySpringCGLIB$$b44a503f
环绕通知开始
前置增强
PersonService.add()
环绕通知结束
最终增强
后置增强
~~~

**注意：环绕增强单独使用,其他 4 个可以一起使用**

<br>

### 2.2、联合使用pointcut表达式

在一个切面类中可以声明多个切点表达式，把几个切点签名联合起来使用 `&&` 或者 `||`

1. 在切面类写切点表达式，使用切入点签名连接

~~~java
@Pointcut("execution(* com.tjetc.service..*.*(..))")
private void anyMethod1(){}
@Pointcut("execution(* com.tjetc.dao..*.*(..))")
private void anyMethod2(){}
@Pointcut("anyMethod1() || anyMethod2()") //定位到连接点的条件
private void anyMethod(){} //方法签名,返回值void
~~~

2. 使用切入点表达式连接

~~~java
@Pointcut("execution(* com.tjetc.service..*.*(..)) || execution(* com.tjetc.dao..*.*(..))")
public void anyMethod(){}
~~~

<br>

### 2.3、声明Advice

#### 2.3.1、使用切入点方法签名

本类的方法直接写方法名

~~~java
@Before("anyMethod()")
public void before() {
    System.out.println("前置增强");
}
~~~

非本类的方法写 `类的全路径名.方法名()` （确保方法签名是 public 能访问的，否则报错）

~~~java
@Component
@Aspect
public class Transcation2 {
	
	@Before("com.tjetc.aspect.TransactionPrint.anyMethod()")
	public void before() {
		System.out.println("前置增强2");
	}

}
~~~

<br>

#### 2.3.2、使用切入点表达式

本类或者非本类都可以使用（不推荐使用）

~~~java
@Before("execution(* com.tjetc.service..*.*(..)) || execution(* com.tjetc.dao..*.*(..))")
public void before() {
    System.out.println("前置增强");
}
~~~

<br>

### 2.4、给Advice通知传递参数

#### 2.4.1、在通知方法里添加 `JoinPoint` 类型的参数

`JoinPoint` 中的方法：

*`getArgs()`*：返回代理对象的方法参数

*`getTarget()`*：返回目标对象

*`getSignature()`*：返回被通知方法的信息

*`toString()`*：打印被通知方法的有用信息

~~~java
@Before("execution(* com.tjetc.service..*.*(..))  || execution(* com.tjetc.dao..*.*(..))")
public void before(JoinPoint jp) {
    System.out.println("前置增强2");
    System.out.println(jp.getTarget());
    System.out.println(jp.getKind());
    System.out.println(jp.getSignature());
    if (jp.getArgs()!=null && jp.getArgs().length==2) {
        System.out.println(jp.getArgs()[0]);
        System.out.println(jp.getArgs()[1]);
    }
    System.out.println(jp);
}
~~~

<br>

#### 2.4.2、环绕通知 `ProceedingJointPoint` 的方法：

`java.lang.Object proceed() throws java.lang.Throwable`：通过反射执行目标对象的连接点处的方法

`java.lang.Object proceed(java.lang.Object[] args) throws java.lang.Throwable`：通过反射执行目标对象连接点处的方法，不过使用新的参数替换原来的参数。

~~~java
@Around("com.tjetc.aspect.TransactionPrint.anyMethod()")
public Object around(ProceedingJoinPoint pjp) throws Throwable{
    Object proceed = null;
    try {
        System.out.println("环绕通知开始");
        System.out.println(pjp.getTarget().getClass());
        System.out.println(pjp.getSignature());
        System.out.println(pjp.getArgs());
        Object[] args = pjp.getArgs();
        args[0]="Hello "+args[0];
        args[1]="Hello "+args[1];
        proceed = pjp.proceed(args);
        System.out.println("环绕通知结束");
    } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
        System.out.println("环绕通知例外");
    }finally{
        System.out.println("环绕通知最终");
    }
    return proceed;
}
~~~

<br>

### 2.5、日志管理案例

1. 日志切面类

~~~java
@Component
@Aspect
public class LogProxy {
    //为了方便，不推荐使用切入点表达式
	@Around("execution(* com.tjetc.service..*.*(..))")
	public Object around(ProceedingJoinPoint pjp) throws Throwable {
    	Object proceed = null;
    	try {
        	//记录日志:什么方法在什么时间开始执行
        	System.out.println(pjp.getSignature()+",开始于"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ssSSS").format(new Date()));
        	proceed = pjp.proceed();
    	} catch (Exception e) {
        	// TODO Auto-generated catch block
        	e.printStackTrace();
        	System.out.println(pjp.getSignature()+",例外异常:"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ssSSS").format(new Date()));
    	}finally{
            System.out.println(pjp.getSignature()+",关闭资源:"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ssSSS").format(new Date()));
    	}
    	//记录日志:什么方法在什么时间结束执行
    	System.out.println(pjp.getSignature()+",结束"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ssSSS").format(new Date()));
    	return proceed;
	}
}
~~~

<br>

2. 目标类

~~~java
@Service
public class PersonService {
	public void add() {
		System.out.println("PersonService.add()");
		System.out.println(1/0);
	}

	public void update() {
		System.out.println("PersonService.update()");
	}

	public void del() {
		System.out.println("PersonService.del()");
	}
	
	public void login(String name,String password) {
		System.out.println("PersonService.login(),name="+name+",password="+password);
	}
}
~~~

<br>

3. 测试类

~~~java
public static void main(String[] args) {
    // 实例化容器
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    //从容器得到bean
    PersonService personService = context.getBean(PersonService.class);
    //调用personService的方法
    personService.login("zs","123");
    personService.add();
    personService.update();
    personService.del();
}
~~~

<br>

结果：控制台打印出来的日志信息

~~~
void com.tjetc.service.PersonService.login(String,String),开始于2020-06-02 16:19:25226
PersonService.login(),name=zs,password=123
void com.tjetc.service.PersonService.login(String,String),关闭资源:2020-06-02 16:19:25263
void com.tjetc.service.PersonService.login(String,String),结束2020-06-02 16:19:25263
void com.tjetc.service.PersonService.add(),开始于2020-06-02 16:19:25263
PersonService.add()
java.lang.ArithmeticException: / by zero
	at com.tjetc.service.PersonService.add(PersonService.java:9)

void com.tjetc.service.PersonService.add(),例外异常:2020-06-02 16:19:25274
void com.tjetc.service.PersonService.add(),关闭资源:2020-06-02 16:19:25275
void com.tjetc.service.PersonService.add(),结束2020-06-02 16:19:25275
void com.tjetc.service.PersonService.update(),开始于2020-06-02 16:19:25275
PersonService.update()
void com.tjetc.service.PersonService.update(),关闭资源:2020-06-02 16:19:25276
void com.tjetc.service.PersonService.update(),结束2020-06-02 16:19:25276
void com.tjetc.service.PersonService.del(),开始于2020-06-02 16:19:25276
PersonService.del()
void com.tjetc.service.PersonService.del(),关闭资源:2020-06-02 16:19:25277
void com.tjetc.service.PersonService.del(),结束2020-06-02 16:19:25277
~~~

<br>

### 2.6、@AfterReturning

当异常发生的时候，获取异常

1. 在 @AfterThrowing 注解中添加属性 throwing = "方法参数的名称"
2. 在方法里写一个参数名称，名称是 throwing 属性的值，就收异常对象

~~~java
package com.tjetc.aspect;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class PersonAspect {

	@Pointcut("execution(* com.tjetc.service..*.*(..))")
	private void anyMethod(){}
	
	@AfterReturning(value = "anyMethod()",returning = "result")
	public void afterReturning(Object result) {
		System.out.println("后置增强，返回值"+result);
	}
	
}
~~~

<br>

### 2.7、@AfterThrowing

当异常发生的时候，获取异常

1. 在 @AfterThrowing 注解中添加属性 throwing = "方法参数的名称"
2. 在方法里写一个参数名称，名称是 throwing 属性的值，就收异常对象

~~~java
@Component
@Aspect
public class PersonAspect {

	@Pointcut("execution(* com.tjetc.service..*.*(..))")
	private void anyMethod(){}
 
	@AfterThrowing(value="anyMethod()",throwing = "exception")
	public void afterThrowing(Exception exception) {
		System.out.println("例外增强, exception = " + exception.getMessage());
	}
}
~~~

<br>

### 2.8、增强中获取参数

#### 2.8.1、使用 JoinPoint 的 getArgs 方法

~~~java
@Before("anyMethod()")
public void before(JoinPoint jp) {
    Object[] args = jp.getArgs();
    for (Object object : args) {
        System.out.println("参数="+object);
    }
    System.out.println("前置增强");
}
~~~



#### 2.8.2、使用 args

1. 在 value = " 切点 && args( 参数名 )" , argName = "参数名"

2. 方法中写参数

~~~java
@Before(value = "anyMethod() && args(name)",argNames = "name")
public void before(String name) {
    System.out.println("参数="+name);
    System.out.println("前置增强");
}
~~~



<br>





### 2.9、@Aspect注解多个切面的执行顺序

不写 @Order 注解，则随机（经过测试，按照切面类的首字母排序执行）

添加 @Order 注解，则按照注解的顺序执行，@Order 注解中 value 的值越小越先执行





