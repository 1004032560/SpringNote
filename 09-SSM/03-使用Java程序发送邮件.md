### 发送邮件激活账户



点击邮件的链接激活账户，只有激活账户之后才能登陆。

如果未激活会提示你到邮箱中接受邮件并激活账户



#### 发送邮件的原理：

Smtp：Send mail transfer protocal 发送邮件传输协议

pop3：邮件接收协议

邮件服务器包含：

1. Smtp 邮件发送服务器
2. pop3：邮件接收服务器
3. 各个账户存储空间

![looper_2020-07-01_10-59-52.png](image/looper_2020-07-01_10-59-52.png)

1. 用户（looper@sohu.com）写好一封 Email 邮件发送到 sohu（搜狐）的 Smtp 服务
   * 如果该邮件的收件人地址是自己管辖的账户，则就会将该邮件存放到自己的服务器，为该邮件分配的地址空间
   * 如果邮件的收件人地址不是自己管辖的账户，则就会通过收件人的地址去寻找对应的 Smtp 服务器
   * 将该邮件存放到自己的服务器，为该邮件分配的地址空间

2. 发送到与收件人对应的 Smtp 服务器之后，用户通过 POP3 服务器接收邮件，POP3 服务器会实时监控 Smtp 中是否有该用户的新





### 用户注册并且发送邮件

注册

~~~java
@RequestMapping("/regist")
public String regist(User user, HttpSession session, Model model) {
    // 发邮件
    // 收件人
    String email = user.getEmail();
    String code = (String) session.getAttribute("code");
    String title = "网上商城账户激活";
    String content = "<h1>购物天堂商城官方激活邮件!点下面链接完成激活操作!</h1><h3><a href='http://192.168.36.103:8080/shop/user_active.action?code="
            + code + "'>http://192.168.36.103:8080/shop/user_active.action?code=" + code + "</a></h3>";
    MailUtil.sendMail(email, title, content);
    user.setState(1);// 未激活
    user.setCode(code);// 保存验证码
    userService.add(user);
    model.addAttribute("email", email);
    return "jsp/userValid";
}
~~~

发送邮件

~~~java
public class MailUtil {
	public static void sendMail(String to, String title, String content) {
		Properties prop = new Properties();
		// 163邮箱设置:
		prop.setProperty("mail.host", "smtp.163.com");
		prop.setProperty("mail.transport.protocol", "smtp");
		prop.setProperty("mail.smtp.auth", "true");
		// 使用JavaMail发送邮件的5个步骤
		// 1、创建session
		Session session = Session.getInstance(prop);
		// 开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
		session.setDebug(true);
		// 2、通过session得到transport对象
		Transport ts;
		try {
			ts = session.getTransport();
			// 3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
			ts.connect("smtp.163.com", "17320038067@163.com", "QHPQFJIAWCUSYPSH");
			// 4、创建邮件
			Message message = createSimpleMail(session, to, title, content);
			// 5、发送邮件
			ts.sendMessage(message, message.getAllRecipients());
			ts.close();
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @Method: createSimpleMail
	 * @Description: 创建一封只包含文本的邮件
	 */
	public static MimeMessage createSimpleMail(Session session, String to, String title, String content)
			throws Exception {
		// 创建邮件对象
		MimeMessage message = new MimeMessage(session);
		// 指明邮件的发件人
		message.setFrom(new InternetAddress("17320038067@163.com"));
		// 指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		// "954028010@qq.com"));
		// 邮件的标题
		message.setSubject(title);
		// 邮件的文本内容
		message.setContent(content, "text/html;charset=UTF-8");
		// 返回创建好的邮件对象
		return message;
	}
}
~~~

