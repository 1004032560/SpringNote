## Redis基本数据类型

> Redis的作用可以用做缓存、数据库、消息中间件MQ。
>
> Redis 是一个开源（BSD许可）的，内存中的数据结构存储系统，它可以用作数据库、缓存和消息中间件。 它支持多种类型的数据结构，如 [字符串（strings）](http://redis.cn/topics/data-types-intro.html#strings)， [散列（hashes）](http://redis.cn/topics/data-types-intro.html#hashes)， [列表（lists）](http://redis.cn/topics/data-types-intro.html#lists)， [集合（sets）](http://redis.cn/topics/data-types-intro.html#sets)， [有序集合（sorted sets）](http://redis.cn/topics/data-types-intro.html#sorted-sets) 与范围查询， [bitmaps](http://redis.cn/topics/data-types-intro.html#bitmaps)， [hyperloglogs](http://redis.cn/topics/data-types-intro.html#hyperloglogs) 和 [地理空间（geospatial）](http://redis.cn/commands/geoadd.html) 索引半径查询。 Redis 内置了 [复制（replication）](http://redis.cn/topics/replication.html)，[LUA脚本（Lua scripting）](http://redis.cn/commands/eval.html)， [LRU驱动事件（LRU eviction）](http://redis.cn/topics/lru-cache.html)，[事务（transactions）](http://redis.cn/topics/transactions.html) 和不同级别的 [磁盘持久化（persistence）](http://redis.cn/topics/persistence.html)， 并通过 [Redis哨兵（Sentinel）](http://redis.cn/topics/sentinel.html)和自动 [分区（Cluster）](http://redis.cn/topics/cluster-tutorial.html)提供高可用性（high availability）。

<br>

### Redis-Key

keys *：查看所有的 key

exists key：判断当前的 key 是否存在

move key 1：将当前库中的 key 移到 1 库中

del key：删除 key

expire key 50：设置 key 的过期时间 50 s

ttl key：查看当前 key 的剩余时间

persist key：当前 key 一直存活

type key：当前 key 为什么类型

rename key newKey：给当前 key 重命名为 newKey

append key looper：追加一个值 looper 到 key 的后边

<br>

### String数据类型

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
13. 获取字符串范围的值 [0,3]：getrange key start end（getrange name 0 3）
14. 替换字符串从 offset 开始替换为 xx，其他的不变：setrange key offset value（getrange name 2 xx）
15. setex (set with expire) 设置过期时间；setex key time value
16. setnx (set if not exist) 判断 key 是否存在；不存在则创建，否则不创建
17. msetnx 设置多个，全部成功，或者全部失败，redis 事务的原子性

~~~bash


###################################################
# mset 设置多个值，使用redis的
###################################################
127.0.0.1:6379> mset user:1:name zhangsan user:1:age 20
OK
127.0.0.1:6379> mget user:1:name user:1:age
1) "zhangsan"
2) "20"

###################################################
# getset 先获取再更新
###################################################
127.0.0.1:6379> getset name looper  #如果值不存在，则返回 null
(nil)
127.0.0.1:6379> get name
"looper"
127.0.0.1:6379> getset name 2233  #如果值存在，则返回 原来的值，再用新值覆盖
"looper"
127.0.0.1:6379> get name
"2233"

###################################################

~~~





<br>

### Hash数据类型

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

### List数据类型

`LIST` 中所有的命令都是 `L` 开头的

Redis 中的 list 是采用来链表来存储的，所以对于 Redis 的 list 数据类型的操作，是操作 list 的两端数据来操作的。



向列表的两端添加元素

* 向左边添加：lpush key value [value....]（lpush list 1 2 3）（结果：3 2 1）
* 向右边添加：rpush key value [value....]（rpush list 4 5 6）（结果：4 5 6）

~~~bash
###################################################
127.0.0.1:6379> lpush list 1 2 3 4 #将一个或者多个值插入到头部(左)
(integer) 4
127.0.0.1:6379> lrange list 0 -1 #获取具体区间的值
1) "4"
2) "3"
3) "2"
4) "1"
###################################################
127.0.0.1:6379> rpush list looper looper2 #将一个或者多个值插入到尾部(右)
(integer) 6
127.0.0.1:6379> lrange list 0 -1 #获取具体区间的值
1) "4"
2) "3"
3) "2"
4) "1"
5) "looper"
6) "looper2"
###################################################
~~~



从列表两端弹出：

* 左弹出：lpop key（lpop lits）从列表左边移除元素，返回被移除的值
* 右弹出：rpop key（rpop lits）从列表右边移除元素，返回被移除的值

~~~bash
###################################################
127.0.0.1:6379> lrange list 0 -1
(empty list or set)
127.0.0.1:6379> lpush list 1 2 3 4
(integer) 4
127.0.0.1:6379> lrange list 0 -1
1) "4"
2) "3"
3) "2"
4) "1"
127.0.0.1:6379> lpop list #从列表左边移除元素，返回被移除的值
"4"
127.0.0.1:6379> rpop list #从列表右边移除元素，返回被移除的值
"1"
127.0.0.1:6379> lrange list 0 -1
1) "3"
2) "2"
###################################################
~~~



1. 获取列表中的元素个数：llen key（llen list）
2. 从列表中删除指定的值：lrem key count value（）删除
3. 获取指定索引的元素的值：lindex key index（lindex list 2）
4. 设置指定索引的元素的值：lset key index value（lset list 2 5）
5. 截取片段：ltrim key
6. 向列表中插入元素：
7. 将元素从一个列表转移到另外一个列表中：rpoplpush key 



~~~bash
###################################################
127.0.0.1:6379> lrange list 0 -1
1) "4"
2) "3"
3) "2"
4) "1"
127.0.0.1:6379> llen list #获取list的长度
(integer) 4
127.0.0.1:6379> lindex list 1 #获取指定索引的值
"3"
127.0.0.1:6379> lset list 1 looper #设置指定索引处的值
OK
127.0.0.1:6379> lrange list 0 -1
1) "4"
2) "looper"
3) "2"
4) "1"
127.0.0.1:6379> lrem list 1 2 #移除指定数量的指定的值
(integer) 1
127.0.0.1:6379> lrange list 0 -1
1) "4"
2) "looper"
3) "1"
127.0.0.1:6379> ltrim list 0 1 #截取指定范围的值
OK
127.0.0.1:6379> lrange list 0 -1
1) "4"
2) "looper"
###################################################
~~~

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

