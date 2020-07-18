## 模板引擎thymeleaf

### 特点：

1. Thymeleaf 既可以运行动态页面，也可以运行动态页面
2. Thymeleaf 开箱即用

3. 

<br>

### 搭建thymeleaf





### 变量表达式`${}`

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



### 选择表达式`*{}`

~~~html
<table>
    <tr th:each="s:${list}" th:object=${s}>
        <td th:text="${s.id}"></td>
        <td th:text="*{name}"></td>
        <td th:text="${s.age}"></td>
    </tr>
</table>
~~~



### URL表达式`@{}`



### 几种常用的使用方法

#### 赋值，

~~~html
<span th:text="'welcome you : '+${name}+'!'"></span>
<br><br><br>
<span th:text="|welcome you : ${name}!|"></span>
~~~



