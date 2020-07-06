



~~~html
<table class="easyui-datagrid">   
    <thead>   
        <tr>   
            <th data-options="field:'code'">编码</th>   
            <th data-options="field:'name'">名称</th>   
            <th data-options="field:'price'">价格</th>   
        </tr>   
    </thead>   
    <tbody>   
        <tr>   
            <td>001</td><td>name1</td><td>2323</td>   
        </tr>   
        <tr>   
            <td>002</td><td>name2</td><td>4612</td>   
        </tr>   
    </tbody>   
</table>
~~~





通过 Ajax 获取数据

~~~html
<table class="easyui-datagrid" data-options="url:'datagrid_data.json'">   
    <thead>   
        <tr>   
            <th data-options="field:'id'">编码</th>   
            <th data-options="field:'name'">姓名</th>   
            <th data-options="field:'age'">年龄</th>   
        </tr>   
    </thead>     
</table> 
~~~

