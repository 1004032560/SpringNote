线程安全





死锁

高并发的情况下导致死锁，两个及以上的线程之间互相争夺锁资源，从而导致进入永久阻塞的状态。



如何解决死锁

死锁产生的是个条件：1、互斥；2、占有且等待；3、不可抢占；4、循环等待

四个条件必须同时满足才会产生死锁，避免死锁的办法就是破坏其中一个条件即可。

1、通过一次性锁定一个线程需要的所有资源，就可以破坏，占有且等待的条件

2、对需要互相获取的两个锁资源，按照顺序获取锁资源 ，破坏了循环等待的情况



线程的几种状态

1、新建：通过 new Thread 的方式去创建一个线程对象。

2、就绪：创建的线程对象调用了 start() 方法，使得该线程处于 可运行线程池 中等待，等待获取CPU的使用权**。**

3、运行：该线程获取到 CPU 的使用权之后，调用 run() 方法执行代码。

4、阻塞：应为某种原因使得线程进入阻塞状态。

* 等待阻塞：调用 wait() 方法，该线程释放所有的锁资源，JVM将其加入到 等待线程池 中。进入这个状态后，不能自动唤醒必须依靠其他线程调用 notify() 或者 notifyAll() 方法去唤醒。
* 同步阻塞：运行的线程在获取对象的同步锁时，锁资源被其他线程占用，则JVM会将其放入 锁池 中。
* 异步阻塞：运行中的线程执行 sleep() 或者 join() 方法，或者发出 I/O 请求时，JVM 会把该线程置为阻塞状态。当sleep()状态超时、join() 等待线程终止或者超时、或者I/O处理完毕时，线程重新转入就绪状态。

5、结束：线程执行完了 run()，或者异常结束，则线程的生命周期结束



Executor

ThreadPoolExecutor

七大参数：corePoolSize：核心线程数；maximumPoolSize：最大线程数；keepAliveTime：非核心线程闲置超时时间；timeUnit：时间单位；BlockingQueue：workQueue阻塞队列；threadFactory：线程工厂；RejectExecutionHandle handle：拒绝粗略



BlockingQueue 阻塞队列



RejectExecutionHandel 线程数量大于最大线程数就会采用拒绝处理策略

1、默认是 ThreadPoolExecutor.AbortPolicy，抛出异常 RejectExectionException。

2、ThreadPoolExecutor.DiscardPolicy 抛弃新来的任务，但不抛出异常。

3、ThreadPoolExecutor.DiscardOldestPolicy 抛弃队列最早的任务，然后尝试执行程序，如果再次失败，则继续执行此过程。

4、ThreadPoolExecutor.CallerRunsPolicy 由调用线程处理该任务。





