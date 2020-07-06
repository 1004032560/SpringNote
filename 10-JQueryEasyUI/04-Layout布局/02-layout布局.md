### Layout（布局）

使用$.fn.layout.defaults重写默认值对象。

布局容器有5个区域：北、南、东、西和中间。中间区域面板是必须的，边缘的面板都是可选的。每个边缘区域面板都可以通过拖拽其边框改变大小，也可以点击折叠按钮将面板折叠起来。布局可以进行嵌套，用户可以通过组合布局构建复杂的布局结构。



~~~html
<body>
<div id="cc" class="easyui-layout" style="width:600px;height:400px;">   
    <div data-options="region:'north',title:'North Title',split:true" style="height:100px;"></div>   
    <div data-options="region:'south',title:'South Title',split:true" style="height:100px;"></div>   
    <div data-options="region:'east',iconCls:'icon-reload',title:'East',split:true" style="width:100px;"></div>   
    <div data-options="region:'west',title:'West',split:true" style="width:100px;"></div>   
    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;"></div>   
</div> 
</body>
~~~







~~~html
<body class="easyui-layout">
    <div data-options="region:'north',title:'North Title',split:true" style="height:100px;"></div>   
    <div data-options="region:'south',title:'South Title',split:true" style="height:100px;"></div>   
    <div data-options="region:'east',iconCls:'icon-reload',title:'East',split:true" style="width:100px;"></div>   
    <div data-options="region:'west',title:'West',split:true" style="width:100px;"></div>   
    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;"></div>   
</body> 
~~~

