1. 创建 MyInterceptor 类实现 HandlerInterceptor 接口

2. 重写三个方法 postHandle（返回值为true的时候放行）、preHandle、afterCompletion

3. 创建 MyConfig 配置类实现 WebMvcConfigurer 接口，添加 @Configuration

4. 重写 addInterceptors 方法，在该方法中配置创建的拦截器类，配置拦截的路径

5. 创建 Controller 类进行测试