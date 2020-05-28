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



4、





## 5、使用钩子函数关闭 IOC 容器

### 5.1、正常退出

~~~java
@Test
public void testHook() {

    //添加一个钩子函数
    Runtime.getRuntime().addShutdownHook(new Thread() {
        @Override
        public void run() {
            System.out.println("通过钩子函数清除垃圾");
        }
    });

    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    //让容器关闭的时候，去执行钩子函数关闭资源
    context.registerShutdownHook();
    context.close();
    System.out.println("正常关闭");
}
~~~

#### 结果：

正常关闭

通过钩子函数清除垃圾



### 5.2、非正常退出

~~~java
@Test
public void testHook() {

    //添加一个钩子函数
    Runtime.getRuntime().addShutdownHook(new Thread() {
        @Override
        public void run() {
            System.out.println("通过钩子函数清除垃圾");
        }
    });

    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    //让容器关闭的时候，去执行钩子函数关闭资源
    context.registerShutdownHook();
    context.close();
    //非正常关闭
    System.exit(1);
    System.out.println("正常关闭");
}
~~~

#### 结果：

通过钩子函数清除垃圾



## 6、BeanPostProcessor接口

Bean 的后置处理器





## 7、FactoryBean接口

FactoryBean 对复杂 Bean 的包装，在初始化方法中对包装对象进行操作，通过 getObject() 将对象包装返回



~~~java
package com.tjetc.domain;

public class G {
    
	private String url;
	private String username;
	private String password;
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
~~~



~~~xml
<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
    <property name="driverClassName" value="com.mysql.jdbc.Driver"></property>
    <property name="url" value="jdbc:mysql:///test02"></property>
    <property name="username" value="root"></property>
    <property name="password" value="123looper."></property>
</bean>
~~~



~~~java
@Component
public class MyFactory implements FactoryBean<G>,InitializingBean {

	@Autowired
	private DriverManagerDataSource dataSource;
	
	private G g;
	
	@Override
	public G getObject() throws Exception {
		return g;
	}

	@Override
	public Class<?> getObjectType() {
		return G.class;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		Connection connection = dataSource.getConnection();
		System.out.println(connection);
		g = new G();
		g.setUrl(dataSource.getUrl());
		g.setUsername(dataSource.getUsername());
		g.setPassword(dataSource.getPassword());
	}

}
~~~



~~~java
@Test
public void test3() {
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    G g1 = (G)context.getBean("myFactory");
    G g2 = (G)context.getBean("myFactory");
    System.out.println(g1);
    System.out.println(g2);
    System.out.println(g1.getUrl());
    System.out.println(g1.getUsername());
    System.out.println(g1.getPassword());
}
~~~





## 8、JSR注解

### 8.1、@Inject

@Inject 等价于 @AutoWire

~~~java
@Repository
public class UserDao {

	public void login() {
		System.out.println("UserDao.login()");
	}

}
~~~



~~~java
@Service//@Named//@ManagedBean需要引入Java-ee 7.0的依赖
public class UserService {
	@Inject//@AutoWire//@Resource
	private UserDao userDao;
	
	public void login() {
		userDao.login();
	}
}
~~~



~~~java
@Test
public void test() {
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    UserService userService = context.getBean(UserService.class);
    userService.login();
}
~~~



### 8.2、@Named或者@ManagedBean

@Named 或者 @ManagedBean 可以代替 @Component

@ManagedBean 需要引入 Java-ee 7.0 的依赖

~~~xml
<dependency>
	<groupId>javax</groupId>
	<artifactId>javaee-api</artifactId>
	<version>7.0</version>
</dependency>
~~~



### 8.3、@Resource

@Resource（默认按名称）注解可以代替 @AutoWire（默认按类型），@Inject



### 8.4、@Required

@Required 只能用于 set 方法上，强制要求使用配置文件配置

使用不灵活，不推荐使用



### 8.5、@Configuration和@Bean

~~~java
@Configuration//配置类,等同于applicationContext.xml
public class MyConfig {
	
	@Bean//在配置文件中配置<bean id="方法名" class="返回值的全限定名">节点
	public StudentService studentService() {
		return new StudentService();
	}
}
~~~



~~~java
public class StudentService {

}
~~~



~~~java
@Test
public void test2() {
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    StudentService studentService = context.getBean(StudentService.class);
    System.out.println(studentService);
}
~~~



### 8.6、@Primary

多个同类型的对象，优先采用带有 @Primary 的注解的类



