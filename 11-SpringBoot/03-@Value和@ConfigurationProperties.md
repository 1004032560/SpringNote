## 1、用@Value取值

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





松散绑定属性名匹配规则(Relaxed binding):

– person.firstName：使用标准方式

– person.first-name：大写用-

– person.first_name：大写用_

– PERSON_FIRST_NAME：

• 推荐系统属性使用这种写法

yaml支持松散绑定,properties不支持松散绑定.