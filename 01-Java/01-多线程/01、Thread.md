



~~~java
ThreadPoolExecutor

// 核心线程数：常用的最主要的线程
int corePoolSize;
// 最大线程总数 = 核心线程数 + 非核心线程数（比如双十一需要扩充的线程数）
int maximumPoolSize;
// 时间：非核心线程存活的时间
long keepAliveTime;
// 时间单位：非核心线程存活的单位（双十一一天）
TimeUnit unit;
// 队列：100个任务，只有10个线程在工作，其他90个任务就在队列中等待
BlockingQueue<Runnable> workQueue;
// 线程工厂：用于创建线程
ThreadFactory threadFactory;
// 拒绝策略：队列中只存放100个任务，则来二百个任务，其他一百个会被拒绝掉
RejectedExecutionHandler handler;
~~~



newFixedThreadPool（慢）

~~~java
public static ExecutorService newFixedThreadPool(int nThreads) {
    return new ThreadPoolExecutor(
        nThreads, nThreads,
        0L, TimeUnit.MILLISECONDS,
        new LinkedBlockingQueue<Runnable>());
}
~~~

无界序列，会造成内存过大



newCachedThreadPool（快）

~~~java
public static ExecutorService newCachedThreadPool() {
    return new ThreadPoolExecutor(
        0, Integer.MAX_VALUE,
        60L, TimeUnit.SECONDS,
        new SynchronousQueue<Runnable>());
}
~~~

核心线程数为 0，线程复用



newSingThreadExecutor（最慢）

```java
public static ExecutorService newSingleThreadExecutor() {
    return new FinalizableDelegatedExecutorService
        (new ThreadPoolExecutor(
            1, 1,、0L, TimeUnit.MILLISECONDS,
            new LinkedBlockingQueue<Runnable>()));
}
```







阿里巴巴不推荐以上创建线程池的三种方式

自定义线程 ThreadPoolExecutor

提交任务：核心线程、队列、非核心线程

执行任务：核心线程、非核心线程、队列







节省成本

提高速度

统一管理



常用的 workQueue 类型

BlockingQueue 阻塞队列



SynchronousQueue 同步移交队列

适用于非常大的或者无界的线程池，可以避免任务排队



LinkedBlockingQueue 基于链表的阻塞队列



ArrayBlockingQueue 基于数组的阻塞队列



DelayQueue 延迟队列



PriorityBlockingQueue 优先级阻塞队列



常用的拒绝策略

AbortPolicy 丢弃并抛异常：阻塞队列满，则丢弃任务，抛出异常



DiscardPolicy 直接丢弃：阻塞队列满，则丢弃任务，不抛异常



DiscardOldestPolicy 丢弃队列中最老的任务，执行新任务 



CallerRunsPolicy 调用线程处理任务：队列满，不丢任务，不抛异常，若添加到线程池失败，那么主线程会自己去执行该任务

#

