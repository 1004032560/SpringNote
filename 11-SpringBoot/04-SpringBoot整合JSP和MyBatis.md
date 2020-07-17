## 1、SpringBoot整合JSP

#### 1.1、在 pom.xml 中引入 jsp 相关依赖

~~~xml
<dependency>
	<groupId>javax.servlet</groupId>
	<artifactId>jstl</artifactId>
</dependency>
<dependency>
	<groupId>org.apache.tomcat.embed</groupId>
	<artifactId>tomcat-embed-jasper</artifactId>
	<scope>provided</scope>
</dependency>
~~~

<br>

#### 1.2、在src/main下创建webapp文件夹

<br>

#### 1.3、在webapp下创建add.jsp文件

~~~jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${pageContext.request.contextPath}/"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
   <form action="student/add" method="post">
      姓名:<input type="text" name="name"/><br/>
      年龄:<input type="text" name="age"/><br/>
      <input type="submit"/>
   </form>
</body>
</html>
~~~

<br>

#### 1.4、在application.yaml配置视图的前缀和后缀

~~~yml
spring:
  mvc:
    view:
      prefix: /
      suffix: .jsp
~~~

<br>

#### 1.5、创建一个StudentController

~~~java
@Controller
@RequestMapping("/student")
public class StudentController {
   
	@RequestMapping("/add")
	public String add(Student student,Model model) {
		System.out.println(student);
		model.addAttribute("s", student);
		return "list";
	}
}
~~~

<br>

#### 1.6、创建一个list.jsp

~~~jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${pageContext.request.contextPath}/"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  ${s.name}<br/>
  ${s.age}<br/>
</body>
</html>
~~~

<br>

<br>

## 2、SpringBoot整合MyBatis

#### 2.1、引入mybatis和mysql的依赖

~~~xml
<dependency>
	<groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starter</artifactId>
    <version>1.3.2</version>
</dependency>
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.46</version>
</dependency>
<dependency>
    <groupId>com.github.pagehelper</groupId>
    <artifactId>pagehelper-spring-boot-starter</artifactId>
    <version>1.2.3</version>
</dependency>
~~~

<br>

#### 2.2、在application.yml配置数据源

~~~yml
spring:
  datasource: 
    driver-class-name: com.mysql.jdbc.Driver
    url: jdbc:mysql:///test03
    username: root
    password: 123looper.
~~~

<br>

#### 2.3、在主配置类上添加注解@MapperScan

~~~java
@SpringBootApplication
@MapperScan("com.tjetc.mapper")
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
~~~

<br>

#### 2.4、自动生成Mapper接口和POJO类

<br>

#### 2.5、controller、service层都和之前的SSM项目写法差不多

<br>

#### 2.6、按照之前的方式启动，地址栏中输入地址即可



