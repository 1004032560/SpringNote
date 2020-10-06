## 1、NoSql定义



## 2、NoSql分类

2.1、键值对存储数据库

2.2、列式数存储数据库

2.3、文档型数据库

2.4、图形数据库



## 3、Redis

#### 3.1、什么是Redis

C语言写的，以键值对的形式进行数据存储

#### 3.2、Redis应用场景

* 缓存（数据查询，短连接，新闻内容，商品内容等）（使用最多）

* 分布式

<br>

## 4、Redis下载安装



## 5、Redis启动



## 6、Redis自带客户端和图形界面

清空缓存：











### Redis的String数据类型

1. 赋值：set key value（set s lisi）
2. 取值：get key（get s）
3. 取值赋值：getset key value（getset s lisii）先返回原值，并用新值替换原值
4. 设置多个键值：mset key value [key value....]（mset k1 v1 k2 v2 k3 v3）
5. 取得多个值：mget key [key]（mget k1 k2 k3）
6. 删除键值：del key（del k1）
7. 数值每次递增1：incr key（incr k3）
8. 数值每次递增指定整数：incrby key increment（incrby k3 20）
9. 数值每次递减1：decr key（decr k3）
10. 数值每次递减指定整数：decrby key decrement（decrby k3 20）
11. 向尾部追加字符串：append key value（append k3 " hello!"）返回的是追加字符串后的总长度
12. 获取字符串长度：strlen key（strlen k3）

<br>

### Redis的hash数据类型

hash叫散列表	

1. 赋值：

   * 返回值是 1 代表插入；返回值是 0 代表更新

   * 一次赋一个值：hset user username zhangsan
   * 一次赋多个值：hmset user username zhangsan age 20 sex man
   * 不存在时赋值：hsetnx user age 20

2. 取值：

   * 一次取一个值：hget user username
   * 一次取多个值：hmget user username age sex
   * 一次取所有值：hgetall user

3. 删除：

   * 一次删除一个：hdel user age
   * 一次删除多个：hdel user age sex

4. 增加数字：hincrby user age 20

5. 判断字段是否存在：（hexists user age）返回 1 表示存在，返回 0 表示不存在

6. 获取字段名：hkeys key（hkeys user）

7. 获取字段值：hvals key（hvals user）

8. 获取字段的数量：hlen key （hlen user）

<br>

### Redis的List数据类型

1. 向列表的两端添加元素
   * 向左边添加：lpush key value [value....]（lpush list 1 2 3）（结果：3 2 1）
   * 向右边添加：rpush key value [value....]（rpush list 4 5 6）（结果：4 5 6）
2. 查看列表：lrange key start stop（lrange list 0 -1 返回第一个索引到最后一个索引的列表的数据）
3. 从列表两端弹出：
   * 左弹出：lpop key（lpop lits）从列表左边移除元素，返回被移除的值
   * 右弹出：rpop key（rpop lits）从列表右边移除元素，返回被移除的值
4. 获取列表中的元素个数：llen key（llen list）
5. 从列表中删除指定的值：lrem key count value（）删除
6. 获取指定索引的元素的值：lindex key index（lindex list 2）
7. 设置指定索引的元素的值：lset key index value（lset list 2 5）
8. 截取片段：ltrim key
9. 向列表中插入元素：
10. 将元素从一个列表转移到另外一个列表中：rpoplpush key 

<br>

### Redis的Set数据类型

1. 增加元素：sadd key value [value...]（sadd set 1 2 2 4 5 4）
2. 删除元素：srem key value [value...]（srem set 1 5）

<br>

### Redis的SortedSet数据类型

1. 增加元素：zadd score 80 zhangsan 65 lisi 85 wangwu
2. 获取元素分数：zscore score lisi
3. 删除元素：zrem score lisi
4. 获取排名在某个范围内的元素：
   * 按照分数从小到大显示姓名：zrange score 0 3
   * 按照分数从大到小显示姓名和分数：zrevrange score 0 3 withscores
5. 获取元素排名
   * 从小到大：zrank key memeber
   * 从大到小：zrevrank key memeber
6. 获得指定分数范围的元素：zrangebyscore key min max
7. 增加某个元素的分数：zincrby key increment member
8. 获取元素数量：zcard key
9. 获得指定范围内的元素个数：zcount key min max
10. 按照排名范围删除元素：zremrangebyrank key start stop
11. 按照分数范围删除元素：zremrangebyscore key min max



zrangebyscore score 90 95

zrangebyscore score 80 95 withscores

zrangebyscore score 80 95 withscores limit 1 2

增加某个元素的分数

<br>

### Keys命令

keys pattern（keys s*）

exists key（exists score）

del key（del score）

rename key newKey（rename s s1）

type key（type s1）

（expire s1 50）设置存活时间

（persist s）设置一直存活

