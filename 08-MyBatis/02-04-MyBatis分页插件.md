## 1、MyBatis分页插件

~~~java
@Test
public void getStudents() {
    SqlSession session = factory.openSession();
    PageHelper.startPage(2,2);//当前页，每页显示的条数
    StudentMapper mapper = session.getMapper(StudentMapper.class);
    List<Student> students = mapper.list();
    PageInfo<Student> pageInfo = new PageInfo<>(students);

    //获取分页列表数据
    System.out.println(pageInfo.getList());
    for (Student student : pageInfo.getList()) {
        System.out.println(student);
    }
    //获取上一页
    System.out.println("上一页:"+pageInfo.getPrePage());
    //获取下一页
    System.out.println("下一页:"+pageInfo.getNextPage());
    //获取当前页
    System.out.println("当前页:"+pageInfo.getPageNum());
    //获取总页数
    System.out.println("总页数:"+pageInfo.getPageSize());

    for (Student student : students) {
        System.out.println(student);
    }
    session.commit();
    session.close();
}
~~~

<br>

<br>