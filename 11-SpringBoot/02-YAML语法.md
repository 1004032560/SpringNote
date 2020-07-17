## 1、YAML基本语法

* 使用缩进表示层级关系

* 缩进时不允许使用Tab键，只允许使用空格。

* 缩进的空格数目不重要，只要相同层级的元素左侧对齐即可

* 大小写敏感

### 1.1、基本语法

k:(空格)v：表示一对键值对（空格必须有）；以空格的缩进来控制层级关系；只要是左对齐的一列数据，都是同一个层级的

例如：

~~~yml
server:
  port: 8081
  servlet:
    context-path: /test
~~~

属性和值也是大小写敏感； 

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

<br>

### 1.2、YAML 支持的三种数据结构

* 对象：键值对的集合
* 数组：一组按次序排列的值
* 字面量：单个的、不可再分的值

<br>

## 2、对象（Map）

* 对象的一组键值对，使用冒号分隔。如：`username:  admin`

* 冒号后面跟空格来分开键值；

* `{k: v}` 是行内写法

对象、Map（属性和值）（键值对）：

`k: v`：在下一行来写对象的属性和值的关系；注意缩进

对象还是 `k: v` 的方式

~~~yml
friends:
  lastName: zhangsan
  age: 20
~~~

行内写法：

`friends: {lastName: zhangsan,age: 18}`

<br>

## 3、数组 

用 `- ` 值表示数组中的一个元素

注意事项：

1. 要在数组名称后面打一空格

2. `- ` 数组元素之间一定有空格，这样取值能正确取出来

~~~yml
pets:
  ‐ cat
  ‐ dog
  ‐ pig
~~~

行内写法：

`pets: [cat,dog,pig]`

<br>

## 4、字面量：普通的值（数字，字符串，布尔）

`k: v`：字面直接来写；

字符串默认不用加上单引号或者双引号；

`""`：双引号；会转义字符串里面的特殊字符；特殊字符会作为本身想表示的意思

`name: "zhangsan \n lisi"`：输出 zhangsan 换行 lisi

`''`：单引号；不会转义特殊字符，特殊字符最终只是一个普通的字符串数据

`name: 'zhangsan \n lisi'`：输出 zhangsan \n lisi

<br>

## 5、案例

~~~yml
user: 
  username: lisi
  password: 123456
  age: 20
  pets: 
    - dog
    - cat
    - pig
  book: 
    name: "book1 \n book2"
  
user2: {username: lisi,password: 123456,age: 20,pets: [dog,cat,pig],book: {name: "book1 \n book2"}}
~~~

<br>

## 6、yaml 配置文件值获取

1. 用 @ConfigurationProperties(prefix = "person") 注解获取

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

