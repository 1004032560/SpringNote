## 1、Spring编程式事务

Spring Framework 提供了两种编程式事务管理方法：

1. 使用 TransactionTemplate
2. 直接使用 PlatformTransactionManager

Spring 编程式事务应用并不广泛，与声明性事务相比，优势仅仅是使用了一致的事务管理抽象





## 2、Spring编程式事务案例







## 3、声明式事务和编程式事务选择







## 4、事务传播性

#### 4.1、PROPAGATION_REQUIRED

required，必须（默认值）

如果 A 有事务，则 B 就会使用该事物

如果 A 没有事务，则 B 就会使创建一个新

#### 4.2、PROPAGATION_SUPPORTS

supports，支持

如果 A 有事务，B 将使用该事务

如果 A 没有事务，B 将以非事务执行

#### 4.3、PROPAGATION_MANDATORY



#### 4.4、PROPAGATION_REQUIRES_NEW



#### 

#### 4.6、PROPAGATION_NOT_SUPPORTS



#### 4.7、PROPAGATION_NEVER



4.5、PROPAGATION_REQUIRED

