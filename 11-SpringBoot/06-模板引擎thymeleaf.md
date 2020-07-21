## 模板引擎thymeleaf

Thymeleaf 是一个跟 Velocity、FreeMarker 类似的模板引擎，它可以完全替代 JSP。

### 1.1、特点：

1. Thymeleaf 既可以运行动态页面，也可以运行动态页面
2. Thymeleaf 开箱即用；它提供标准和 Spring 标准两种方言，可以直接套用模板实现 JSTL、OGNL 表达式效果，避免每天套模板、改 JSTL、改标签的困扰。同时开发人员也可以扩展和创建自定义的方言。
3. Thymeleaf 提供spring标准方言和一个与 SpringMVC 完美集成的可选模块，可以快速的实现表单绑定、属性编辑器等功能。
4. 标准表达式语法

<br>

### 1.2、搭建thymeleaf

1. 在 pom.xml 中引入 thymeleaf 的 jar

~~~xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
~~~

2. 在 `src/main/resource` 下的 templates 建立模板文件
3. 在模板文件添加内容（静态+动态）html
4. 在 controller 中写动态数据
5. 在浏览器中测试 `localhost:8080/hello`

<br>

### 1.3、变量表达式`${}`

变量表达式即 OGNL 表达式或 Spring EL 表达式（在 Spring 术语中也叫 model attributes）。如下所示： ${session.user.name}

它们将以 HTML 标签的一个属性来表示：

~~~html
<table>
  <tr th:each="s,st:${list}">
    <td th:text="${s}"></td>
    <td th:text="${st.index}"></td>
    <td th:text="${st.count}"></td>
    <td th:text="${st.first}"></td>
    <td th:text="${st.last}"></td>
    <td th:text="${st.even}"></td>
    <td th:text="${st.odd}"></td>
    <td th:text="${st.size}"></td>
    <td th:text="${st.current}"></td>
  </tr>
</table>
~~~



### 1.4、选择表达式`*{}`

选择表达式很像变量表达式，不过它们用一个预先选择的对象来代替上下文变量容器（map）来执行，如下： `*{customer.name}`

使用：是在 `*{}` 选择表达式的父标签添加 `th:object="${变量}"`

被指定的 object 由 th:object 属性定义：

~~~html
<table>
    <tr th:each="s:${list}" th:object=${s}>
        <td th:text="${s.id}"></td>
        <td th:text="*{name}"></td>
        <td th:text="${s.age}"></td>
    </tr>
</table>
~~~

<br>

### 1.5、URL表达式`@{}`

URL 表达式指的是把一个有用的上下文或会话信息添加到 URL，这个过程经常被叫做URL 重写。`@{/order/list}`
URL还可以设置参数：`@{/order/details(id=${orderId})}`
相对路径：`@{../documents/report}`



<br>

## 1.1  面试题:变量表达式和星号表达有什么区别吗？

二者区别:

1. 变量表达式：${变量} 是从整个上下文取值

2. 星号表达式：*{变量} 是从选定对象（就是父标签的 th:object）上取值

解释：

如果不考虑上下文的情况下，两者没有区别；星号语法评估在选定对象上表达，而不是整个上下文。
 什么是选定对象？就是父标签的值，当然，$ 符号和 * 语法可以混合使用。



<br>

### 1.7、几种常用的使用方法

#### 赋值，

~~~html
<span th:text="'welcome you : '+${name}+'!'"></span>
<br><br><br>
<span th:text="|welcome you : ${name}!|"></span>
~~~



