1、



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

