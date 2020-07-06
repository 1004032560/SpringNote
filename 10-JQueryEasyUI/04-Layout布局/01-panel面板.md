使用$.fn.panel.defaults重写默认值对象。

面板作为承载其它内容的容器。这是构建其他组件的基础（比如：layout,tabs,accordion等）。它还提供了折叠、关闭、最大化、最小化和自定义行为。面板可以很容易地嵌入到web页面的任何位置。



~~~html
<body>
	<div id="p" class="easyui-panel" title="My Panel"
		style="width: 500px; height: 150px; padding: 10px; background: #fafafa;"
		data-options="iconCls:'icon-save',closable:true,    
                collapsible:true,minimizable:true,maximizable:true">
		<p>panel content.</p>
		<p>panel content.</p>
	</div>
	<br>
	<br>
	<br>
	<div id="p" style="padding: 10px;">
		<p>panel content.</p>
		<p>panel content.</p>
	</div>
	<script type="text/javascript">
		$('#p').panel({
			width : 500,
			height : 150,
			title : 'My Panel',
			tools : [ {
				iconCls : 'icon-add',
				handler : function() {
					alert('new')
				}
			}, {
				iconCls : 'icon-save',
				handler : function() {
					alert('save')
				}
			} ]
		});
	</script>
</body>
~~~

