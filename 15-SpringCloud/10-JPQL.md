## 1、JPQL

JPQL（JavaPersistence Query Language）是一种面向对象的查询语言，它在框架中最终会翻译成为sql进行查询。



~~~java
@Entity
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private int age;
}
~~~

<br>

### 1.1、数字占位符

~~~java
public interface PersonDao extends JpaRepository<Person,Integer> {

    //数字占位符，数字表示参数的位置保持一致即可，与参数名无字关
    @Query("from Person p where p.name=?2 and p.age=?1")
    Person findByNameAndAge(int age, String name);

}
~~~

<br>

### 1.2、名字占位符

~~~java
public interface PersonDao extends JpaRepository<Person,Integer> {

    //名字占位符，: 后边得到名字和参数名保持一致即可，与参数顺序无关
    @Query("from Person p where p.name=:name and p.age=:age")
    //有@Param注解时，SQL占位符与注解的参数保持一致即可
    Person findByNameAndAge(int age, String name);

}
~~~

<br>

### 1.3、模糊查询

~~~java
public interface PersonDao extends JpaRepository<Person,Integer> {

    @Query("from Person p where p.name like %:name%")
    List<Person> findByNameLike(@Param("name") String name);
    
}
~~~

<br>

### 1.4、日期类型

~~~java
public interface PersonDao extends JpaRepository<Person,Integer> {

    @Query("from Person p where p.birthday between :start and :end")
    List<Person> findByBirthdayBetween(@Param("start")Date start,@Param("end")Date end);
    
}
~~~

<br>

~~~java
@Test
void testFindByBirthdayBetween() {
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date start = new Date();
    Date end = new Date();
    try {
        start = simpleDateFormat.parse("2020-07-01");
        end = simpleDateFormat.parse("2020-09-01");
    } catch (ParseException e) {
        e.printStackTrace();
    }
    List<Person> list = personDao.findByBirthdayBetween(start,end);
    for (Person person : list) {
        System.out.println(person);
    }
}
~~~

<br>

### 1.5、总结

1. 参数位置：`?1`、`?2`

2. 参数名字：`:name` 是参数前面的注解中 `@Param("name")` 的 name

3. 时间的间隔：`between :start and :end`

4. 参数集合：`in :nameList` 

   方法参数：`@Param("nameList") Collection nameList`

5. spel：`:#{#name}`

6. 原生 SQL：

7. 条件查询 + 分页：

<br>

<br>

## 2、多表关系

### 2.1、一对一

一个对一个（身份证和人之间的关系）

<br>

#### Person 实体类

~~~java
@Entity
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;

    @OneToOne(mappedBy = "person")//不维护外键
    private IdCard idCard;
}
~~~

<br>

#### IDCard 实体类

~~~java
@Entity
@Table(name = "idcard")
public class IdCard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String code;

    @OneToOne
    @JoinColumn(name = "pid")
    private Person person;
}
~~~

<br>

#### 测试添加：

1. 创建关联关系：由外键维护方设置对方才能设置成功
2. 保存：先保存非外键维护方，再保存外键维护方

~~~java
@Test
void testAdd() {
    //创建对象
    Person person = new Person("zs");
    IdCard idCard = new IdCard("123456789");
    //创建关联关系
    idCard.setPerson(person);
    //保存数据库
    personDao.save(person);
    idCardDao.save(idCard);
}
~~~

<br>

#### 由非外键维护方查询对方

~~~java
@Test
void testGet() {
    Person person = personDao.findById(1).get();
    System.out.println(person);
    IdCard idCard = person.getIdCard();
    System.out.println(idCard);
}
~~~

<br>

#### 由外键维护方查询对方

~~~java
@Test
void testGetPerson() {
    IdCard idCard = idCardDao.findById(1).get();
    System.out.println(idCard);
    Person person = idCard.getPerson();
    System.out.println(person);
}
~~~

<br>

### 2.2、一对多

一个对多个（班级和学生之间的关系）

#### Student实体类

~~~java
@Entity
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  int id;
    private String name;
    @ManyToOne
    @JoinColumn(name = "cid")
    private MyClass myClass;
}
~~~

<br>

#### MyClass实体类

~~~java
@Entity
@Table(name = "myclass")
public class MyClass {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    @OneToMany(mappedBy = "myClass")//不维护外键
    private Set<Student> students=new HashSet<>();
}
~~~

<br>

#### 测试添加：

~~~java
@Test
void testAdd() {
    //创建对象
    MyClass myClass = new MyClass("一班");
    Student student1 = new Student("zs1");
    Student student2 = new Student("zs2");
    Student student3 = new Student("zs3");
    //设置关联关系
    student1.setMyClass(myClass);
    student2.setMyClass(myClass);
    student3.setMyClass(myClass);
    //保存（先保存一方）
    myClassDao.save(myClass);
    studentDao.save(student1);
    studentDao.save(student2);
    studentDao.save(student3);
}
~~~

<br>

#### 由一方查询多方

```java
@OneToMany(mappedBy = "myClass",fetch = FetchType.EAGER)//不维护外键
```

需要在一方注解中添加

~~~java
@Test
void testMyClassToListStudent() {
    //查询Id=1的mycalss对象
    MyClass myClass = myClassDao.findById(1).get();
    System.out.println(myClass);
    //由myclass查询学生
    Set<Student> students = myClass.getStudents();
    System.out.println(students);
}
~~~

<br>

#### 由多方询一方

~~~java
@Test
void testStudentToMyClass() {
    Student student = studentDao.findById(1).get();
    System.out.println(student);
    MyClass myClass = student.getMyClass();
    System.out.println(myClass);
}
~~~

<br>

### 2.3、多对多

多个对多个（课程和学生之间的关系）

#### Student实体类

~~~java
@Entity
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;

    @ManyToMany
    @JoinTable(name = "sc", joinColumns = {@JoinColumn(name = "sid")},
            inverseJoinColumns = {@JoinColumn(name = "cid")})
    private Set<Course> courses = new HashSet<>();
}
~~~

<br>

#### MyClass实体类

~~~java
@Entity
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;

    @ManyToMany(mappedBy = "courses")
    private Set<Student> students = new HashSet<>();
}
~~~

<br>

#### 测试添加：

~~~java
@Test
void testAdd() {
    //创建对象
    Student student1 = new Student("zs1");
    Student student2 = new Student("zs2");

    Course course1 = new Course("Java");
    Course course2 = new Course("Python");
    Course course3 = new Course("C");

    //设置关联关系
    student1.getCourses().add(course1);
    student1.getCourses().add(course2);
    student2.getCourses().add(course2);
    student2.getCourses().add(course3);

    //保存
    courseDao.save(course1);
    courseDao.save(course2);
    courseDao.save(course3);
    studentDao.save(student1);
    studentDao.save(student2);
}
~~~

<br>

#### 由非外键维护方查询对方

```java
@ManyToMany(mappedBy = "courses", fetch = FetchType.EAGER)
```

需要在一方注解中添加

~~~java
@Test
void testCourseToStudent() {
    //查询所有课程
    List<Course> courses = courseDao.findAll();
    //遍历课程
    for (Course course : courses) {
        System.out.println(course);
        System.out.println(course.getStudents());
    }
}
~~~

<br>

#### 由外键维护方查询对方

```java
@ManyToMany(fetch = FetchType.EAGER)
```

需要在一方注解中添加

~~~java
@Test
void testStudentToCourse() {
    //查询所有学生
    List<Student> students = studentDao.findAll();
    //遍历学生
    for (Student student : students) {
        System.out.println(student);
        System.out.println(student.getCourses());
    }
}
~~~

<br>

<br>

## 3、抓取策略

注解的属性 fetch = FetchType.EAGER 和 fetch = FetchType.LAZY

默认 LAZY （）

<br>

### 4、对象三态

1. 瞬时态：使用 new 创建的对象，就是瞬时态
2. 持久化态：调用 save()、update() 等操作之后，持久化到数据库；会被会话管理。
3. 游离态（脱管态）：当 Session 关闭后
4. 游离态（托管态）：当 Session 

<br>

## 5、Cascade级联操作

* ALL：所有的级联操作（增删改查CRUD）

* PERSIST：持久化保存
* DETECH：将另外一方设置为游离态