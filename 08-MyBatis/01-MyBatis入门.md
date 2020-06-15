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

~~~xml
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="test">
	<insert id="add" parameterType="com.tjetc.domain.Student">
		insert into student(name,age) values(#{name},#{age})
	</insert>
	<update id="update" parameterType="com.tjetc.domain.Student">
		update student set name=#{name},age=#{age} where id=#{id}
	</update>
	<delete id="del" parameterType="int">
		delete from student where id=#{id}
	</delete>
	<select id="list" resultType="com.tjetc.domain.Student">
		select * from student
	</select>
	<select id="get" parameterType="int" resultType="com.tjetc.domain.Student">
		select * from student where id=#{id}
	</select>
</mapper>
~~~













