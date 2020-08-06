## 1、SpringDataJpa

Spring Data JPA 是在 JPA 规范下提供了 Repository 层的实现，但是使用哪一种 ORM 需要自己来决定（默认使用 Hibernate JPA 的实现），声明持久层的接口，其他的都交给 Spring Data JPA 来帮你完成。

<br>

Spring Data JPA 框架，主要针对的就是 Spring 唯一没有简化到的业务逻辑代码，至此，开发者连仅剩的实现持久层业务逻辑的工作都省了，唯一要做的，就只是声明持久层的接口，其他都交给 Spring Data JPA 来帮你完成！

Spring Data JPA 是在规范下提供了层的实现，但是使用哪一种需要你来决定（默认使用的实现）。虽然框架都实现了规范，但是在不同的框架之间切换仍然需要编写不同的代码，而通过使用能够方便大家在不同的框架之间进行切换而不要更改代码。并且对层封装的很好，也省去了不少的麻烦。

![looper_2020-08-05_11-00-20.png](E:/1.soft/personalNotes/Spring/15-SpringCloud/image/looper_2020-08-05_11-00-20.png)

<br>

## 2、入门程序

#### 2.1、配置 pml.xml

创建 SpringBoot 工程，选择 Spring Web、MySql、Spring Data JPA 三者。

~~~xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
	<groupId>mysql</groupId>
	<artifactId>mysql-connector-java</artifactId>
	<scope>runtime</scope>
</dependency>
~~~

<br>

#### 2.2、配置 application.yml

~~~yml
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql:///test05?serverTimezone=GMT%2B8
    username: root
    password: 123looper.
  jpa:
    show-sql: true  #是否显示SQL语句
    hibernate:
      ddl-auto: update
~~~

说明：ddl-auto

* update：如果数据库有表，就不建表；如果实体类的属性比表里列多，就加列；如果少，就不变
* create：不管有没有表，都会重新建表
* create-drop：程序运行时建表，结束时删除表
* validate：验证该表是否存在，只做判断，不做任何操作
* none：什么也不做

<br>

#### 2.3、实体类

~~~java
@Entity//代表该类是一个实体类，SpringJPA开始接管他
@Table(name = "person")//代表实体类对应的数据库的表名，当表名和实体类名称一致可以省略该注解
public class Person {

    @Id//该列为主键
    @GeneratedValue(strategy = GenerationType.IDENTITY)//主键的自动生成策略：mysql或者SQL server采用自动递增
    private int id;
    @Column//(name="name"{列名}, nullable=true{可以为空}, length=30{字段长度})该成员变量对应的数据库中该表的列
    private String name;
    private int age;
    
}
~~~

<br>

~~~
@Entity
    作用：指定当前类是实体类。
@Table
    作用：指定实体类和表之间的对应关系。
    属性：
        name：指定数据库表的名称
@Id
    作用：指定当前字段是主键。
@GeneratedValue
    作用：指定主键的生成方式。。
    属性：
        strategy ：指定主键生成策略。
        	JPA提供的四种标准用法为TABLE,SEQUENCE,IDENTITY,AUTO。
			IDENTITY: 主键由数据库自动生成（主要是自动增长型）
			SEQUENCE: 根据底层数据库的序列来生成主键，条件是数据库支持序列。
			AUTO: 主键由程序控制
			TABLE: 使用一个特定的数据库表格来保存主键


@Column
    作用：指定实体类属性和数据库表之间的对应关系
    属性：
        name：指定数据库表的列名称。
        unique：是否唯一  
        nullable：是否可以为空  
        inserttable：是否可以插入  
        updateable：是否可以更新  
        columnDefinition: 定义建表时创建此列的DDL
~~~

<br>

#### 2.4、创建 Repository 接口

~~~java
public interface PersonRepository extends JpaRepository<UserInfo,Integer>{
    //List<Person> findAllByNameLike(Pageable pageable, String name);
    Page<Person> findAllByNameLike(Pageable pageable, String name);
}
~~~

<br>

#### 2.5、测试：

~~~java
@SpringBootTest
class ApplicationTests {

    //注入接口
    @Autowired
    private PersonRepository personRepository;

    @Test
    void testAdd() {
        //创建person对象，不带Id
        Person person = new Person("张三", 20);
        //使用JPA插入数据库
        personRepository.save(person);
    }

    @Test
    void testUpdate() {
        //创建person对象，带Id
        Person person = new Person(1,"李四", 22);
        //使用JPA修改数据库
        personRepository.save(person);
    }

    @Test
    void testGet() {
        //使用JPA通过Id查询数据库
        Optional<Person> optional = personRepository.findById(1);
        if (optional==null){
            Person person = optional.get();
            System.out.println(person);
        }
    }

    @Test
    void testList() {
        //查询所有的信息
        List<Person> list = personRepository.findAll();
        for (Person person : list) {
            System.out.println(person);
        }
    }

    @Test
    void testList2() {
        /*Pageable pageable = PageRequest.of(0, 2);
        //实现模糊查询
        List<Person> list = personRepository.findAllByNameLike(pageable,"%张三%");
        for (Person person : list) {
            System.out.println(person);
        }*/
    }

    @Test
    void testList3() {
        Pageable pageable = PageRequest.of(0, 2);
        //使用分页查询
        Page<Person> page = personRepository.findAllByNameLike(pageable,"%张三%");
        for (Person person : page.getContent()) {
            System.out.println(person);
        }
    }

}
~~~



## 3、主键生成策略

通过 annotation（注解）来映射 hibernate 实体的，基于 annotation 的 hibernate 主键标识为@Id，其生成规则由 @GeneratedValue 设定的。

这里的 @id 和 @GeneratedValue 都是 JPA 的标准用法。

JPA 提供的四种标准用法为：TABLE，SEQUENCE，IDENTITY，AUTO。

IDENTITY：主键由数据库自动生成（主要是自动增长型）

SEQUENCE：根据底层数据库的序列来生成主键，条件是数据库支持序列。

AUTO：主键由程序控制

TABLE：使用一个特定的数据库表格来保存主键

<br>

### 3.1、AUTO（什么都不写）

会自动生成 hibernate_sequence 表，字段为 next_val 记录下一次 id 的值，每次取完会自增一

~~~java
@Entity
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String name;
    private int age;
}
~~~

<br>

~~~
Hibernate: select next_val as id_val from hibernate_sequence for update
Hibernate: update hibernate_sequence set next_val= ? where next_val=?
Hibernate: insert into person (age, name, id) values (?, ?, ?)
~~~

<br>

### 3.2、SEQUENCE

在 MySQL 不支持 SEQUENCE 序列，但是会自动生成 seq_payment 表，字段为 next_val ，该字段默认每次自增 50，需要设置 allocationSize = 1，每次就会按照 1 递增。

（MySQL 不支持 SEQUENCE 序列）

~~~java
@Entity
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "payablemoney_seq")
    @SequenceGenerator(allocationSize = 1, name = "payablemoney_seq", sequenceName = "seq_payment")
    private int id;
    private String name;
    private int age;
}
~~~

<br>

### 3.3、TABLE

使用一个特定的数据库表格来保存主键

指定表，名字的列，值的列，名字列的指，下一次 Id 定义 allocationSize = 1

~~~java
@Entity
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE, generator="pk_gen")
    @TableGenerator(name = "pk_gen",
            table="tb_generator",
            pkColumnName="gen_name",
            valueColumnName="gen_value",
            pkColumnValue="PAYABLEMOENY_PK",
            allocationSize=1
    )
    private int id;
    private String name;
    private int age;
}
~~~

<br>

### 3.4、IDENTITY

MySQL 建议使用 IDENTITY，Id 每次自增 1