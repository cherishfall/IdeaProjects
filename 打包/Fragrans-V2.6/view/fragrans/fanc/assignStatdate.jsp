<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript">
	function orderSpms() {
		var statdate = $("#statdate").datebox("getValue");
		var cityCode = $("#cityCode").combotree("getValue");
		if(statdate==''){
			$.messager.alert('提示','请选择账单日期');
			return;
		}
		if (statdate > getNowDayMorning()) {
			sys.alert('提示', '该日期账单目前无法获取');
			return;		
		}
		if(cityCode==''){
			$.messager.alert('提示','请选择城市');
			return;
		}
		$.messager.confirm("提示", "确认获取每日账单?", function(r) {
			if (r) {
				$.messager.progress({
		            title:'请稍后',
		            msg:'正在获取每日账单...'
				});
				$.ajax({
					url : 'orderSpms/getOrderSpms.do',
					type : 'post',
					data : 
					{
						statDate:statdate,
						cityCode:cityCode,
					},
					success : function(result) {
						$.messager.progress('close');
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	function fancOrderBalance() {
		var statdate = $("#statdate").datebox("getValue");
		if(statdate==''){
			$.messager.alert('提示','请选择账单日期');
			return;
		}
		if (statdate > getNowDayMorning()) {
			sys.alert('提示', '该日期账单目前无法获取');
			return;		
		}
		$.messager.confirm("提示", "确认重新进行对账?", function(r) {
			if (r) {
				$.messager.progress({
		            title:'请稍后',
		            msg:'正在进行对账...'
				});
				$.ajax({
					url : 'fancOrderBalance/getOrderBalance.do',
					type : 'post',
					data : 
					{
						statDate:statdate
					},
					success : function(result) {
						$.messager.progress('close');
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function fancOrderSpms() {
		var statdate = $("#statdate").datebox("getValue");
		var cityCode = $("#cityCode").combotree("getValue");
		if(statdate==''){
			$.messager.alert('提示','请选择账单日期');
			return;
		}
		if (statdate > getNowDayMorning()) {
			sys.alert('提示', '该日期账单目前无法获取');
			return;		
		}
		$.messager.confirm("提示", "确认重新进行对账?", function(r) {
			if (r) {
				$.messager.progress({
		            title:'请稍后',
		            msg:'正在进行对账...'
				});
				$.ajax({
					url : 'fancOrderSpms/getOrderSpms.do',
					type : 'post',
					data : 
					{
						statDate:statdate,
						cityCode:cityCode,
					},
					success : function(result) {
						$.messager.progress('close');
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	function weixPnpayOrder() {
		var statdate = $("#statdate").datebox("getValue");
		if(statdate==''){
			$.messager.alert('提示','请选择账单日期');
			return;
		}
		$.messager.confirm("提示", "确认重新获取微信公众号支付账单?", function(r) {
			if (r) {
				$.messager.progress({
		            title:'请稍后',
		            msg:'正在获取微信公众号支付账单...'
				});
				$.ajax({
					url : 'weixpnpaylistOriginal/rebuildWeixpnpayOrder.do',
					type : 'post',
					data : {"statdate":statdate},
					success : function(result) {
						$.messager.progress('close');
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	function weixpayOrder() {
		var statdate = $("#statdate").datebox("getValue");
		if(statdate==''){
			$.messager.alert('提示','请选择账单日期');
			return;
		}
		$.messager.confirm("提示", "确认重新获取微信账单?", function(r) {
			if (r) {
				$.messager.progress({
		            title:'请稍后',
		            msg:'正在获取微信账单...'
				});
				$.ajax({
					url : 'weixpaylistOriginal/rebuildWeixpayOrder.do',
					type : 'post',
					data : {"statdate":statdate},
					success : function(result) {
						$.messager.progress('close');
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function alipayOrder(){
		var statdate = $("#statdate").datebox("getValue");
		if(statdate==''){
			$.messager.alert('提示','请选择账单日期');
			return;
		}
		$.messager.confirm("提示", "确认重新获取支付宝账单?", function(r) {
			if (r) {
				$.messager.progress({
		            title:'请稍后',
		            msg:'正在获取支付宝账单...'
				});
				$.ajax({
					url : 'alipayAccountlog/rebuildAlipayOrder.do',
					type : 'post',
					data : {"statdate":statdate},
					success : function(result) {
						$.messager.progress('close');
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	function matchOrder(){
		var statdate = $("#statdate").datebox("getValue");
		if(statdate==''){
			$.messager.alert('提示','请选择账单日期');
			return;
		}
		$.messager.confirm("提示", "确认重新生成对账单?", function(r) {
			if (r) {
				$.messager.progress({
		            title:'请稍后',
		            msg:'正在重新生成对账单...'
				});
				$.ajax({
					url : 'rebuildOrder.do',
					type : 'post',
					data : {"statdate":statdate},
					success : function(result) {
						$.messager.progress('close');
						$.messager.show({
							title : '提示',
							msg : result.msg
						});
					}
				});
			}
		});
	}
	
	$(function(){
		$('#statdate').datebox('setValue', getYesterDay());
	})
</script>
</head>
<body>
<!-- <form id="searchForm">
	<p class="ui-fields" >
	   <label class="ui-label">账单日期:</label>
	   <input id="statdate" name="statdate" class="easyui-datebox" data-options="editable:false" data-options="width:150" /><br/><br/>
	<a href="#" class="easyui-linkbutton" onclick="weixpayOrder()" iconCls="icon-search">微信</a>
	<a href="#" class="easyui-linkbutton" onclick="alipayOrder()" iconCls="icon-search">支付宝</a>
	<a href="#" class="easyui-linkbutton" onclick="matchOrder()" iconCls="icon-search">对账</a>
	</p>
	
</form> -->
<table align="center">
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td style="width:80px;"><label class="ui-label">账单日期:</label></td>
		<td style="width:180px;"><input id="statdate" name="statdate" data-options="editable:false" class="easyui-datebox" style="width:150px;" /></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td style="width:80px;"><label class="ui-label">城市名称:</label></td>
		<td style="width:180px;"><input id="cityCode" name="cityCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" /></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4">
			<a href="#" class="easyui-linkbutton" onclick="orderSpms()" iconCls="icon-search">spms每日账单</a>
			<a href="#" class="easyui-linkbutton" onclick="fancOrderSpms()" iconCls="icon-search">spms对账</a>
			<a href="#" class="easyui-linkbutton" onclick="weixpayOrder()" iconCls="icon-search">微信</a>
			<a href="#" class="easyui-linkbutton" onclick="weixPnpayOrder()" iconCls="icon-search">微信公众号</a>
			<a href="#" class="easyui-linkbutton" onclick="alipayOrder()" iconCls="icon-search">支付宝</a>
			<a href="#" class="easyui-linkbutton" onclick="matchOrder()" iconCls="icon-search">第三方支付对账</a>
			<a href="#" class="easyui-linkbutton" onclick="fancOrderBalance()" iconCls="icon-search">清分对账</a>
		</td>
	</tr>
</table>
</body>
</html>