### 1、数据校验

在企业级项目中，数据校验是一个非常重要的工作。

那么，在一个典型的MVC架构中，在哪里进行数据校验呢？

最稳妥的方案当然是在每一层都进行数据校验，但是这样做工作量太大了。通过大量的项目实践，推荐的方案如下：

基于浏览器的视图层，用户输入数据时必须要进行数据校验

控制器要做数据校验

实体对象传给bean对象，进行业务操作前要进行数据校验 

基于实体对象的数据校验，是JSR中的重要规范，参见

JSR330: Dependency Injection for Java 1.0

* JSR303 Bean Validation1.0与JSR349: Bean Validation 1.1

* 数据校验的实现者，主要是hibernate，因此数据校验示例中必须要导入hibernate-validator.jar

* Spring不做数据校验的实现，它提供的是支持 JSR330 和 JSR349 的整合方案。

* JavaEE容器，如Tomcat8，整合hibernate-validator.jar后可以实现数据校验工作。

* Spring提供的数据校验工作，实际是把原来由JavaEE容器实现的功能，由Spring的容器代替了。Spring整合数据校验工作后，代码更加的简单了。



#### 1.1、Spring数据校验，需要实现Validator接口

创建自定义 Spring 验证器需要实现 `org.springframework.validation.Validator` 接口，该接口有两个接口方法：

`boolean supports(Class<?> klass)`

`void validate(Object object,Errors errors)`

当 supports 方法返回 true 时，验证器可以处理指定的 Class。

validate 方法的功能是验证目标对象 object，并将验证错误消息存入 Errors 对象。

往 Errors 对象存入错误消息的方法是 reject 或 rejectValue，这两个方法的部分重载方法如下：

`void reject(String errorCode)`

`void reject(String errorCode,String defaultMessage)`

`void rejectValue(String filed,String errorCode)`

`void rejectValue(String filed,String errorCode,String defaultMessage)`

在一般情况下只需要给 reject 或 rejectValue 方法一个错误代码，Spring MVC 框架就会在消息属性文件中查找错误代码，获取相应错误消息。

具体示例如下：

if(goods.getGprice() > 100 || goods.getGprice() < 0){

  errors.rejectValue("gprice","gprice.invalid"); // gprice.invalid为错误代码

}

#### 1.2、案例

**work0615-01**

<br>

<br>

### 2、JSR注解验证框架之Hibernate-Validator

#### 2.1、标注类型

JSR 303 不需要编写验证器，但需要利用它的标注类型在领域模型的属性上嵌入约束。

 <br>

#### 2.2、验证的注解

1. 空检查

@Null：验证对象是否为 null。

@NotNull：验证对象是否不为 null，无法检查长度为 0 的字符串。

@NotBlank：检查约束字符串是不是 null，以及被 trim 后的长度是否大于 0，只针对字符串，且会去掉前后空格。

@NotEmpty：检查约束元素是否为 null 或者是 empty。

 <br>

2. boolean 检查

@AssertTrue：验证 boolean 属性是否为 true。

@AssertFalse：验证 boolean 属性是否为 false。

 <br>

3. 长度检查

@Size（min=，max=）：验证对象（Array、Collection、Map、String）长度是否在给定的范围之内。

@Length（min=，max=）：验证字符串长度是否在给定的范围之内。

 <br>

4. 日期检查

@Past：验证 Date 和 Callendar 对象是否在当前时间之前。

@Future：验证 Date 和 Calendar 对象是否在当前时间之后。

@Pattern：验证 String 对象是否符合正则表达式的规则。

 <br>

5. 数值检查

@Min  验证 Number 和 String 对象是否大于指定的值

@Max  验证 Number 和 String 对象是否小于指定的值

@DecimalMax  被标注的值必须不大于约束中指定的最大值，这个约束的参数是一个通过 BigDecimal 定义的最大值的字符串表示，小数存在精度

@DecimalMin   被标注的值必须不小于约束中指定的最小值，这个约束的参数是一个通过 BigDecimal 定义的最小值的字符串表示，小数存在精度

@Digits 验证 Number 和 String 的构成是否合法

@Digits（integer=，fraction=）  验证字符串是否符合指定格式的数字，integer 指定整数精度，fraction 指定小数精度

@Range（min=，max=）   检查数字是否介于 min 和 max 之间

@Valid 对关联对象进行校验，如果关联对象是个集合或者数组，那么对其中的元素进行校验，如果是一个 map，则对其中的值部分进行校验

@CreditCardNumber 信用卡验证

@Email 验证是否为邮件地址，如果为 null，不进行验证，通过验证

#### 2.3、案例

**work0615-02**



### 3、使用BeanWrapper进行实体的属性设置与读取

当给实体对象通过get()和set()进行属性操作时，DataBinder会通过调用BeanWrapper来实现相关操作









### 4、PropertyEditor









