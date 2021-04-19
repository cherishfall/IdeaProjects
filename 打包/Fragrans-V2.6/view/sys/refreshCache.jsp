<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style>
	.cachaDiv{width:800px;position: relative;top:20px;left:180px;}
	.datagrid-btable tr{height: 40px;}
	.datagrid-header-row td{height: 40px;font-family:微软雅黑;color:#000;font-size:22px;}
	.textDesc{width: 590px;font-family:微软雅黑;color:#000;font-size:20px;}
</style> 
<%@include file="/view/inc.jsp"%>
<script type="text/javascript">
	function refreshCache() {
		$.messager.confirm("提示", "确认更新缓存?", function(r) {
			if (r) {
				$.ajax({
					url : 'refreshCache.do',
					type : 'post',
					success : function(result) {
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function sendParam(){
		$.messager.confirm("提示", "确认发送参数给接受程序?", function(r) {
			if (r) {
				$.ajax({
					url : 'sendParam.do',
					type : 'post',
					success : function(result) {
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function initCode(){
		$.messager.confirm("提示", "确认检查编码?", function(r) {
			if (r) {
				$.ajax({
					url : 'initCode.do',
					type : 'post',
					success : function(result) {
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function refreshPara(){
		$.messager.confirm("提示", "确认刷新全局参数缓存?", function(r) {
			if (r) {
				$.ajax({
					url : 'refreshPara.do',
					type : 'post',
					success : function(result) {
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function refreshDictionary(){
		$.messager.confirm("提示", "确认刷新数据字典缓存?", function(r) {
			if (r) {
				$.ajax({
					url : 'refreshDictionary.do',
					type : 'post',
					success : function(result) {
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function refreshCityList(){
		$.messager.confirm("提示", "确认刷新城市列表缓存?", function(r) {
			if (r) {
				$.ajax({
					url : 'refreshCityList.do',
					type : 'post',
					success : function(result) {
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function refreshKey(){
		$.messager.confirm("提示", "确认刷新应用秘钥缓存?", function(r) {
			if (r) {
				$.ajax({
					url : 'refreshKey.do',
					type : 'post',
					success : function(result) {
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function refreshUserSignKey(){
		$.messager.confirm("提示", "确认刷新全部用户签到缓存，务必谨慎操作哦 ?", function(r) {
			if (r) {
				$.ajax({
					url : 'refreshUserSignKey.do',
					type : 'post',
					success : function(result) {
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	
</script>
</head>
<body>
	<div class="cachaDiv">
		<p class="textDesc">刷新缓存功能列表 </p>
		<table class="easyui-datagrid" data-options="fitColumns:true,singleSelect:true,onClickRow: function (rowIndex, rowData) {
                $(this).datagrid('unselectRow', rowIndex);}" >   
		    <thead>   
		        <tr>   
		            <th data-options="field:'button',width:200">按钮</th>   
		            <th data-options="field:'desc',width:600">说明</th>   
		        </tr>   
		    </thead>   
		    <tbody>   
		        <tr>
					<td><a href="#" class="easyui-linkbutton"
						onclick="refreshCache()" data-options="iconCls:'icon-reload'">刷新缓存</a></td>
					<td>刷新数据字典缓存并检查日历是否完整（不完整则生成本年的日历）</td>
				</tr>
				<tr>
					<td><a href="#" class="easyui-linkbutton"
						onclick="sendParam()" data-options="iconCls:'icon-reload'">发送参数</a></td>
					<td>发送系统配置参数给转发程序</td>
				</tr>
				<tr>
					<td><a href="#" class="easyui-linkbutton"
						onclick="initCode()" data-options="iconCls:'icon-reload'">检查编码</a></td>
					<td>新建城市后，初始化该城市的编码</td>
				</tr>   
				<tr>
					<td><a href="#" class="easyui-linkbutton"
						onclick="refreshPara()" data-options="iconCls:'icon-reload'">刷新全局参数</a></td>
					<td>重新加载para全局参数数据到redis缓存</td>
				</tr>   
				<tr>
					<td><a href="#" class="easyui-linkbutton"
						onclick="refreshDictionary()" data-options="iconCls:'icon-reload'">刷新数据字典</a></td>
					<td>重新加载数据字典数据到redis缓存</td>
				</tr>   
				<tr>
					<td><a href="#" class="easyui-linkbutton"
						onclick="refreshCityList()" data-options="iconCls:'icon-reload'">刷新城市列表</a></td>
					<td>重新加载城市列表到redis缓存</td>
				</tr>   
				<tr>
					<td><a href="#" class="easyui-linkbutton"
						onclick="refreshKey()" data-options="iconCls:'icon-reload'">刷新应用秘钥</a></td>
					<td>重新加载应用秘钥信息到redis缓存</td>
				</tr> 
				<tr>
					<td><a href="#" class="easyui-linkbutton"
						onclick="refreshUserSignKey()" data-options="iconCls:'icon-reload'">刷新用户签到信息</a></td>
					<td>重新加载用户签到信息到redis缓存</td>
				</tr>   
		    </tbody>   
		</table> 
	</div>
   
</body>
</html>