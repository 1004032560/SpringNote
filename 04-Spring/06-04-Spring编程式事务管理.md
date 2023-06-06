## 1、Spring编程式事务

Spring Framework 提供了两种编程式事务管理方法：

1. 使用 TransactionTemplate
2. 直接使用 PlatformTransactionManager

Spring 编程式事务应用并不广泛，与声明性事务相比，优势仅仅是使用了一致的事务管理抽象





## 2、Spring编程式事务案例







## 3、声明式事务和编程式事务选择







## 4、事务传播特性

#### 4.1、PROPAGATION_REQUIRED

required，必须（默认值）

支持当前事务，如果 A 有事务，则 B 就会使用该事物

如果 A 没有事务，则 B 就会使创建一个新事务



#### 4.2、PROPAGATION_SUPPORTS

supports，支持

如果 A 有事务，B 将使用该事务

如果 A 没有事务，B 将以非事务执行（Spring 不控制事务，JDBC 自己控制事务）



#### 4.3、PROPAGATION_MANDATORY

mandatory，强制

如果 A 有事务，B 将使用该事务

如果 A 没有事务，B 将会抛出异常



#### 4.4、PROPAGATION_REQUIRES_NEW

requires_new，必须新的

如果 A 有事务将 A 的事务挂起，B 将会创建一个新的事务

如果 A 没有事务，B 将会创建一个新的事务



#### 4.5、PROPAGATION_NOT_SUPPORTS

not_supported，不支持

如果 A 有事务，将 A 的事务挂起，B 将会以非事务执行

如果 A 没有事务，B 将会以非事务执行



#### 4.6、PROPAGATION_NEVER

never，从不

如果 A 有事务，B 将会抛异常

如果 A 没有事务，B 将会以非事务执行



#### 4.7、PROPAGATION_NESTED

nested，嵌套

A 和 B 底层采用保存点机制，形成嵌套事务。

如果 A 有事务，B 将会在嵌套事务内执行

如果 A 没有事务，B 将会创建一个新的事务





## 5、事务简介

用来确保数据的完整性和一致性

事务就是一系列的动作，被当作一个单独的工作单元，这些动作要么全部完成，要么全部不完成





## 6、事务的关键属性（ACID）

原子性（Atomicity）：事务是一个原子操作，有一系列动作组成。事务的原子性确保动作要么全部完成，要么全部不起作用

一致性（Consistency）：

隔离性（）：

持久性（）：一旦事务完成，无论系统发生什么错误，他的结果都不应该受到影响

![looper_2020-06-05_15-51-54](C:\Users\Administrator\Desktop\looper_2020-06-05_15-51-54.png)







## 7、事务隔离级别

Read Uncommited：读未提交的数据

Repeatable Read，如 MySql



脏读：一个事务读取到另一个事务未提交的数据

不可重复读：多次读取同一数据，每次得到的数据结果不同

可重复读：多次读取同一数据，每次得到的数据结果相同

幻读：一个事务读取到另一事务已提交的 insert 数据

Serializable：串行化



## 8、数据库连接管理

在 dao 层继承 JDBCDaoSupport，

通过 setDataSource 将数据源注入进来，

然后就可以调用this.getConnection() 就可以得到连接；

使用原生的 JDBC API 进行数据操作

使用完毕后，不需要关闭连接，Spring（JDBCDaoSupport）会自动释放连接，

会将连接送回到连接池中



### JDBCDaoSupport主要方法

1. setDataSource()：注入数据源

2. getConnection()：得到连接

3. releaseConnection()：释放连接（final 修饰的，不需要程序员掉，自动释放）



## 事务方法控制



不需要使用数据库操作（连接）的时候，在不需要数据库操作的方法上不写 @Transaction 注解



在 XML 配置中 `<tx:method name="*" propagation="NOT_SUPPORTED" read-only="true">`



