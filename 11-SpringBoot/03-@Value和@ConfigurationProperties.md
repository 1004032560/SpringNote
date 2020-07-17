## 1、yaml 配置文件值获取

### 1.1、用@ConfigurationProperties注解获取

application.yml 配置文件

~~~yml
person:
  lastName: lisi
  age: 20
  boss: false
  birth: 2020/03/20
  maps: {k1: v1,k2: v2}
  lists:
    - lisi
    - zhaoliu
  dog:
    name: 小狗
    age: 5
~~~

Person 实体类

~~~java
/**
* 将配置文件中配置的每一个属性的值，映射到这个组件中
* @ConfigurationProperties：告诉SpringBoot将本类中的所有属性和配置文件中相关的配置进行绑定；
* prefix = "person"：配置文件中哪个下面的所有属性进行一一映射
*
* 只有这个组件是容器中的组件，才能容器提供的@ConfigurationProperties功能；
*
*/

@Component
@ConfigurationProperties(prefix="person")
public class Person {

	private String lastName;
	private Integer age;
	private Boolean boss;
	private Map<String, Object> maps;
	private List<String> lists;
	private Dog dog;
~~~

<br>

### 1.2、用@Value取值

@Value 会从以下几处拿值：

1. 字面量，如："true"

2. ${key}，从配置文件或环境变量中获取值

3. #{SpEL}，spring的el表达式获取值.

 在对应的成员变量上标注 @Value，测试能否得到值

配置文件：application.yml

~~~yml
person:
  lastName: lisi
  age: 20
  boss: false
  birth: 2020/03/20
  maps: {k1: v1,k2: v2}
  lists:
    - lisi
    - zhaoliu
  dog:
    name: 小狗
    age: 5
~~~

Person 的实体类

~~~java
@Component
public class Person {
	
	@Value("${person.lastName}")
	private String lastName;
	@Value("#{11+8}")
	private Integer age;
	@Value("true")
	private Boolean boss;
	//@Value("${person.maps}")
	private Map<String, Object> maps;
	private List<String> lists;
	private Dog dog;
~~~

<br>

## 2、@ConfigurationProperties和@Value区别

1. 功能

   @ConfigurationProperties 批量注入

   @Value 单个注入

2. 松散绑定

   @ConfigurationProperties 支持

   @Value 不支持

3. JSR303 数据校验

   @ConfigurationProperties 支持

   @Value 不支持

4. SpEL

   @ConfigurationProperties 不支持

   @Value 支持

5. 复杂数据封装

   @ConfigurationProperties 支持

   @Value 不支持

注意：数据校验的时候需要导入 hibernate-validator.jar 包

~~~xml
<dependency>
    <groupId>org.hibernate</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>5.3.6.Final</version>
</dependency>
~~~

<br>

## 3、松散绑定属性名匹配规则(Relaxed binding)

– person.firstName：使用标准方式

– person.first-name：大写用-

– person.first_name：大写用_

– PERSON_FIRST_NAME：推荐系统属性使用这种写法

yaml 支持松散绑定，properties 不支持松散绑定

<br>

## 4、@PropertySource

@PropertySource 加载指定的配置文件

由于 @PropertySource 加载的默认配置文件是 application.properties，如果需要加载指定的配置文件则需要添加该注解。

`@PropertySource("classpath:person.properties")`