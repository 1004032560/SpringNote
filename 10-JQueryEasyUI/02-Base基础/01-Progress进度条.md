





~~~javascript
<script type="text/javascript">
	function test(){
		// 获取进度条对象
		var bar = $("#p").progressbar("bar");
		// 获取进度条当前值
		var value = $('#p').progressbar('getValue'); 
		if (value < 100){ 
			value += Math.floor(Math.random() * 10); 
			$('#p').progressbar('setValue', value); 
		}else{
			//$('#p').css("display","none");
			$('#p').hide();
		}
	}
</script>
~~~

