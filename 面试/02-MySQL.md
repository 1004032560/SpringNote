### 1、基本的增删改查语句

~~~mysql
select 查询的字段 from 表名 where 条件

delete from 表名 where 条件

insert into 表名(字段1,字段2...) values(数据1,数据2...)

update 表名 set 字段1=新数据2, 字段2=新数据2 where 条件
~~~



### 2、创建表时对字段添加约束

非空约束：not null

默认约束：default

唯一约束：unique key

主键约束：primary key

外键约束：foreign key

自动增长：auto_increment



### 3、数据库事务的四大特性

* 原子性（Atomic）：把事务看做一个原子（不可分割）

   一个事务中的所有操作，要么全部完成，要么全部不完成，不会结束在中间某个环节。事务在执行过程中发生错误，会被回滚到事务开始前的状态，就像这个事务从来没有执行过一样。 

* 一致性（Consistency）：事务前后，数据总额是一致的（转账）

  事务的一致性指的是在一个事务执行之前和执行之后数据库都必须处于一致性状态。如果事务成功地完成，那么系统中所有变化将正确地应用，系统处于有效状态。如果在事务中出现错误，那么系统中的所有变化将自动地回滚，系统返回到原始状态。

* 隔离性（Isolation）：在并发环境中，所有的操作执行完成之前，其他的会话看不能看到过程

  指的是在并发环境中，当不同的事务同时操纵相同的数据时，每个事务都有各自的完整数据空间。由并发事务所做的修改必须与任何其他并发事务所做的修改隔离。事务查看数据更新时，数据所处的状态要么是另一事务修改它之前的状态，要么是另一事务修改它之后的状态，事务不会查看到中间状态的数据。

* 持久性（Durability）：一旦事务提交，对数据就是永久性的改变

  指的是只要事务成功结束，它对数据库所做的更新就必须永久保存下来。即使发生系统崩溃，重新启动数据库系统后，数据库还能恢复到事务成功结束时的状态。



### 4、数据库隔离级别

* 脏读：读取到还未提交的数据。
* 不可重复读：当一个事务先后读取同一条数据，但是两次读取到的数据不一致，这种现象就称为不可重复读。
* 幻读：当一个事务先后执行同一个相同的查询操作时，第二次查询到的数据与第一次查询到的数据不一致，这种现象就称为幻读。



### 5、索引的优缺点，什么时候使用索引，什么时候不能使用索引

索引的优点是：为了提高查询效率，

索引的缺点是：更新数据时效率低，因为同时还要更新索引

什么时候使用索引：如果需要对该表的数据进行频繁的查询，则可以建立索引；反之则不需要



二级索引底层数据保存的是一级索引。



#### 5.1、索引最左前缀原理

三个字段的联合索引会按照第一个字段，逐个去比对；如果第一个字段能够排除顺序，则按照第一个索引；第一个字段都相同的话，就会比较第二个字段，依次比较。（主键索引）



### 6、InnoDB和MyISAM的区别

1. InnoDB 采用的是聚集索引，MyISAM 采用的是非聚集索引

2. InnoDB 数据和索引是在一起的，MyISAM 数据和索引是分开的

3. InnoDB 支持外键，事务，查询表行数时需要全表扫描；MyISAM 不支持外键，不支持事务，查询表行数时不需要扫描全表

4. InnoDB 支持表锁，行锁；MyISAM 只支持表锁

5. InnoDB 是必须有主键的，主键建议用自增的 id 而不用 uuid，用uuid会使得索引变慢 ；

   InnoDB 表必须有主键（用户没有指定的话会自己找或生产一个主键），而 Myisam 可以没有



### 7、InnoDB和MyISAM存储文件

InnoDB：frm 是表定义文件，ibd 是数据文件

MyISAM：frm 是表定义文件，myd 是数据文件，myi 是索引文件



### 8、InnoDB为什么推荐使用自增ID作为主键

自增 ID 可以保证每次插入时 B+ 树索引是从右边扩展的，可以避免B+树和频繁合并和分裂（对比使用UUID）。如果使用字符串主键和随机主键，会使得数据随机插入，效率比较差。

1. UUID 需要将每个字符转换成 ASC II 码进行逐一比较，不如整型直接比较的效率。

2. 存储空间上来说，整型的存储空间要比 UUID 节省的多（上线之后，使用高性能的SSD）



### 9、二叉树、红黑树、B树、B+树





### 10、MySQL优化

#### 10.1、为什么要优化

* 系统的吞吐量瓶颈往往出现在数据库的访问速度上
* 数据库中的数据越来越多时，处理的时间也会相应变慢
* 数据库数据存放在磁盘中，读写速度无法与内存中相比



#### 10.2、如何优化

1. 设计数据库时：表功能、字段类型的选择、存储引擎的选择
2. MySQL 自身提供的功能，索引等
3. 横向扩展：MySQL 集群，负载均衡、读写分离（空间换时间）
4. SQL 语句优化



#### 10.3、为什么SQL中推荐使用 NOT NULL

对于查询中包含 NULL 的列，对MySQL来说更难优化，因为 NULL 的列使得索引、索引的统计和值的比较都更加复杂。为 NULL 的列会使用更多的存储空间，在 MySQL 中需要特殊处理。

当可为 NULL 的列被索引时，每个索引记录需要额外的字节，在 MyISAM 中可能会导致固定索引（例如只有一个整数列的索引）变成可变大小的索引。

通常把 NULL 改为 NOT NULL 带来的性能提升比较小，所以在调优时，没有必要首先在有 schema 中查找并修改掉这种情况，除非确定这会导致问题。

但是计划在列上建立索引，就应该尽量避免设计成可以 NULL 的列。



#### 10.4、满足三范式

* 第一范式：字段原子性，不可再分割

* 第二范式：消除对主键的部分依赖
* 第三范式：消除对主键的传递依赖



#### 10.5、索引最左前缀问题

如果对三个字段建立联合索引，如果第二个字段没有使用索引，第三个字段也使用不到索引了