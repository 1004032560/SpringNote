### 1、什么是mybatis 

MyBatis 是一款优秀的持久层框架，它支持自定义 SQL、存储过程以及高级映射。

MyBatis 免除了几乎所有的 JDBC 代码以及设置参数和获取结果集的工作。

MyBatis 可以通过简单的 XML 或注解来配置和映射原始类型、接口和 Java POJO（Plain Old Java Objects，普通老式 Java 对象）为数据库中的记录。

 

### 2、mybatis优点

1. 基于SQL语法，简单易学

2. 能了解底层组装过程

3. SQL语句封装在配置文件中，便于统一管理与维护，降低了程序的耦合度

4. 程序调试方便



### 3、mybatis快速入门

[mybatis 官网](https://mybatis.org/mybatis-3/zh/getting-started.html)

#### 3.1、创建一个 Maven 的 jar 工程

<br>

#### 3.2、在 pom.xml 添加 mybatis、mysql、junit 的 jar 依赖

~~~xml
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.5.3</version>
</dependency>
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.46</version>
</dependency>
~~~

<br>

#### 3.3、在 `main/src/resource` 创建配置文件 `mybatis.xml`

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<environments default="development">
		<environment id="development">
		<transactionManager type="JDBC"/>
		<dataSource type="POOLED">
				<property name="driver" value="com.mysql.jdbc.Driver"/>
				<property name="url" value="jdbc:mysql:///test02"/>
				<property name="username" value="root"/>
				<property name="password" value="123looper."/>
			</dataSource>
		</environment>
	</environments>
	<mappers>
		<mapper resource="com/tjetc/domain/studentMapper.xml"/>
	</mappers>
</configuration>
~~~

<br>

#### 3.4、创建一个实体类，实体类中的属性与数据库表中的字段应该相对应

~~~java
public class Student {
	private int id;
	private String name;
	private int age;
}
~~~

<br>

#### 3.5、在该实体类同文件下创建 `studentMapper.xml` 配置文件

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="test">
    <!-- 添加一条记录操作 -->
	<insert id="add" parameterType="com.tjetc.domain.Student">
		insert into student(name,age) values(#{name},#{age})
	</insert>
</mapper>
~~~













