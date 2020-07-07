



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



toolbar 工具栏

~~~html
<body>

<table id="dg">
</table>
<script type="text/javascript">
$('#dg').datagrid({    
    url:'datagrid_data.json',
    pagination:true,
    pagePosition:'bottom',
    toolbar: [{
    	text:'添加',
		iconCls: 'icon-add',
		handler: function(){alert('添加按钮')}
	},'-',{
		text:'编辑',
		iconCls: 'icon-edit',
		handler: function(){alert('编辑按钮')}
	},'-',{
		text:'帮助',
		iconCls: 'icon-help',
		handler: function(){alert('帮助按钮')}
	}],
    pageSize:2,
    pageList:[2,4,6,8,10],
    columns:[[    
        {field:'id',title:'编号',width:100,align:'center'},    
        {field:'name',title:'姓名',width:100,align:'right'},    
        {field:'age',title:'年龄',width:100,align:'right'}    
    ]]    
});
</script>
</body>
~~~

