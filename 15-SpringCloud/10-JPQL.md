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