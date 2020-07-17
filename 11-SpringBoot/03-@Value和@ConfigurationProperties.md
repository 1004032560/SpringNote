松散绑定属性名匹配规则(Relaxed binding):

– person.firstName：使用标准方式

– person.first-name：大写用-

– person.first_name：大写用_

– PERSON_FIRST_NAME：

• 推荐系统属性使用这种写法

yaml支持松散绑定,properties不支持松散绑定.