## 1、MyBatis整合EhCache

### 1.1、EhCache

* 是 一个纯 Java 的进程缓存框架

* 是一种广泛使用的开源的 Java 分布式缓存，具有快速、精干等特点

* 是 Hibernate 中默认的 CacheProvider

<br>

### 1.2、MyBatis整合EhCache的原理

通过实现 EhCache 接口可以实现 mybatis 缓存数据通过其它缓存数据库





## 2、MyBatis动态Sql



MyBatis 的动态 SQL 是基于 OGNL（Object Graph Navigate Language）对象图导航语言

它可以帮助我们方便的在 SQL 语句中实现某些逻辑

MyBatis 中用于实现动态 SQL 的元素主要有：

### 2.2、choose

[案例源码](0619-mybatis-02)

![looper_2020-06-19_11-42-29.png](image/20200619/looper_2020-06-19_11-42-29.png)



![looper_2020-06-19_11-41-39.png](image/20200619/looper_2020-06-19_11-41-39.png)

<br>

### 2.3、where

[案例源码](0619-mybatis-02)

![looper_2020-06-19_11-48-01.png](image/20200619/looper_2020-06-19_11-48-01.png)



![looper_2020-06-19_11-46-46.png](image/20200619/looper_2020-06-19_11-46-46.png)







<br>

### 2.4、trim

[案例源码](0619-mybatis-02)

![looper_2020-06-19_13-35-46.png](image/20200619/looper_2020-06-19_13-35-46.png)

![looper_2020-06-19_13-45-18.png](image/20200619/looper_2020-06-19_13-45-18.png)



<br>

### 2.5、set

[案例源码](0619-mybatis-02)

![looper_2020-06-19_12-04-26.png](image/20200619/looper_2020-06-19_12-04-26.png)



![looper_2020-06-19_12-05-24.png](image/20200619/looper_2020-06-19_12-05-24.png)

<br>

### 2.6、foreach



#### 2.6.1、collection="list"

[案例源码](0619-mybatis-02)

![looper_2020-06-19_14-02-58.png](image/20200619/looper_2020-06-19_14-02-58.png)



![looper_2020-06-19_14-04-00.png](image/20200619/looper_2020-06-19_14-04-00.png)



#### 2.6.2、collection="array"

[案例源码](0619-mybatis-02)

![looper_2020-06-19_14-13-27.png](image/20200619/looper_2020-06-19_14-13-27.png)



![looper_2020-06-19_14-14-58.png](image/20200619/looper_2020-06-19_14-14-58.png)



#### 2.6.3、collection="map"

[案例源码](0619-mybatis-02)

方式一：

![looper_2020-06-19_14-39-27.png](image/20200619/looper_2020-06-19_14-39-27.png)



![looper_2020-06-19_14-40-40.png](image/20200619/looper_2020-06-19_14-40-40.png)



方式二：



![looper_2020-06-19_14-50-31.png](image/20200619/looper_2020-06-19_14-50-31.png)



![looper_2020-06-19_14-49-45.png](image/20200619/looper_2020-06-19_14-49-45.png)







## 3、Sql片段



![looper_2020-06-19_14-56-47.png](image/20200619/looper_2020-06-19_14-56-47.png)



![looper_2020-06-19_14-57-56.png](image/20200619/looper_2020-06-19_14-57-56.png)





## 4、MyBatis多表关系

### 4.1、一对一



#### 4.1.1、添加

![looper_2020-06-19_16-13-09.png](image/20200619/looper_2020-06-19_16-13-09.png)



![looper_2020-06-19_16-13-39.png](image/20200619/looper_2020-06-19_16-13-39.png)



![looper_2020-06-19_16-09-40.png](image/20200619/looper_2020-06-19_16-09-40.png)



![looper_2020-06-19_16-10-12.png](image/20200619/looper_2020-06-19_16-10-12.png)



![looper_2020-06-19_16-08-10.png](image/20200619/looper_2020-06-19_16-08-10.png)



![looper_2020-06-19_16-10-49.png](image/20200619/looper_2020-06-19_16-10-49.png)



![looper_2020-06-19_16-12-21.png](image/20200619/looper_2020-06-19_16-12-21.png)



![looper_2020-06-19_16-15-09.png](image/20200619/looper_2020-06-19_16-15-09.png)



![looper_2020-06-19_16-14-29.png](image/20200619/looper_2020-06-19_16-14-29.png)



#### 4.1.2、查询























