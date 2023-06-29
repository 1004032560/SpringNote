## RocketMQ应用



在通过部署好 RocketMQ 服务器之后，通过程序去连接服务端，并且进行消息发送和消息接收。



创建 SpringBoot 项目，添加 maven 依赖

~~~pom.xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.7.13</version>
		<relativePath/> <!-- lookup parent from repository -->
	</parent>
	<groupId>com.looper.rmq</groupId>
	<artifactId>SpringRocketMQ</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<name>01-Spring-RocketMQ</name>
	<description>01-Spring-RocketMQ</description>

	<properties>
		<java.version>1.8</java.version>
	</properties>

	<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<optional>true</optional>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>

		<dependency>
			<groupId>org.apache.rocketmq</groupId>
			<artifactId>rocketmq-spring-boot-starter</artifactId>
		</dependency>

		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>fastjson</artifactId>
			<version>1.2.78</version>
		</dependency>
	</dependencies>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
				<configuration>
					<excludes>
						<exclude>
							<groupId>org.projectlombok</groupId>
							<artifactId>lombok</artifactId>
						</exclude>
					</excludes>
				</configuration>
			</plugin>
		</plugins>
	</build>

</project>
~~~



配置 yml 文件

~~~yml
rocketmq:
  producer:
    group: looper_producer_group
  name-server: 192.79.33.54:9876
~~~



创建消息消费类，对指定的 topic 进行监听

~~~java
package com.looper.rmq.listener;

import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.stereotype.Component;

/**
 * @author looper
 * @date 2023-06-29
 */
@Component
@RocketMQMessageListener(topic = "looper_topic", consumerGroup = "looper_consumer_group")
public class LooperGroupRocketMQListener implements RocketMQListener<String> {

    @Override
    public void onMessage(String msg) {
        System.out.println("收到消息：" + msg);
    }

}
~~~



编写测试进行消息发送，然后消费者接收到消息。

~~~java
package com.looper.rmq;

import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * @author looper
 * @date 2023-06-29
 */
@SpringBootTest
public class RocketMQTest {

    @Autowired
    private RocketMQTemplate rocketMQTemplate;

    @Test
    public void test() {
        rocketMQTemplate.convertAndSend("looper_topic", "Hello looper RocketMQ!");
        try {
            Thread.sleep(60000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

}
~~~



启动后 RocketMQ 的一次消息发送和接收就算成功了。