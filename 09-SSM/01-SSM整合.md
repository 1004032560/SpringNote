## 1、SSM

### 1.1、什么是SSM

SSM：Spring + Spring MVC + MyBatis 三大框架

<br>

### 1.2、框架的角色划分和作用

#### 1.2.1、Spring

* 能整合各种框架

* Spring 框架充当父容器
* ContextLoaderListener 启动实例化 Spring 容器，管理 Bean（Service、Mapper、数据源、SqlSession、MapperScanConfiguror、Transaction）管理理业务层和数据访问层

<br>

#### 1.2.2、SpringMVC

* Spring MVC 是子容器
* 实例化 Spring MVC 容器（是 Spring 容器的子容器，子容器的 Bean 可以访问父容器的 Bean）管理 Bean（Controller、视图解析器、CommonsMultipartResolver）
* 配置扫描基本包：`com.looper.controller` 管理控制层和视图层

<br>

#### 1.2.3、MyBatis

* Mapper、POJO、配置文件、映射文件

<br>

### 1.3、父子容器的关系

1. 父容器是 Spring 容器
2. 子容器是 Spring MVC 容器
3. 子容器的 Bean 可以访问父容器的 Bean，反之不行

<br>

### 1.4、整合SSM步骤

1. 创建 Maven 工程，选择 war 包

2. 创建 web.xml（在项目文件下选择 Java EE Tools --> Generate Deployment）

3. 在 pom.xml 添加 jar 包依赖
4. 创建 db.properties 配置数据库信息
5. 创建 log4j.properties 配置打印日志信息

6. 创建 applicationContext.xml 配置父容器
7. 创建 springmvc.xml 配置子容器
8. 创建 mybatis.xml 配置 MyBatis

完成以上步骤，环境基本就配置成功了，然后就进行测试。

<br>

### 1.5、