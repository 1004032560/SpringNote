



~~~html
<body>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">class搜索</a>
<br><br>
<a href="#" id="btn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">js搜索</a>
</body>
~~~



使用 JS 方式，应该将 JS 代码放到 body 体中

~~~javascript
<script type="text/javascript">
	$('#btn').linkbutton({    
		iconCls: 'icon-search'   
	});
</script>
~~~



EasyUI 对应的图标：

~~~html
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cut'">剪切</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">剪切</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">剪切</a>
~~~



### 按钮的点击







