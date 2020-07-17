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



## 2、SpringBoot整合MyBatis

### 