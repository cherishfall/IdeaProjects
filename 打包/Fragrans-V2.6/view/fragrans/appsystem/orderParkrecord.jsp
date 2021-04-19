<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<style type="text/css">
	#pic{
		margin:0 auto;
		width:480px;
		padding:0;
		text-align:center;
	}
	#pic img{
		max-width:480px;
		width:expression(document.body.clientWidth>document.getElementById("pic").scrollWidth*9/10? "480px": "auto" );
	}
</style>
<script type="text/javascript"
	src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">区域名称:</label><input name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">停车点名称:</label><input name="parkName"
					class="easyui-box ui-text" style="width: 150px;">
				<label class="ui-label">车牌号:</label><input name="plateNo"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">停车记录id:</label><input name="parkrecordId"
					class="easyui-box ui-text" style="width: 100px;">
				<!--<label class="ui-label">用户账号:</label><input name="userAccount"
					class="easyui-box ui-text" style="width: 100px;">-->
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- detail -->
	<div id="detail" class="easyui-dialog" title="停车记录详情"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 800px; height: 400px;">
	</div>
	
	<!-- refund -->
	<div id="refund" class="easyui-dialog" title="退款"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 500px; height: 500px;">
		<form id="refundForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">付款日期:</td>
						<td><input class="easyui-validatebox" type="text"
							name="payTime" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">订单编号:</td>
						<td><input class="easyui-validatebox" type="text"
							name="orderNo" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">实付款:</td>
						<td><input class="easyui-validatebox" type="text"
							name="price" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">支付方式:</td>
						<td><input class="easyui-validatebox" type="text"
							name="payType" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款成功金额(元):</td>
						<td><input class="easyui-validatebox" type="text"
							name="sucRefund" readonly="readonly" style="width:200px;background:#eee;color:blue;font-weight:bold"/></td>
				</tr>
				<%--<tr>--%>
					<%--<td style="text-align: right;">退款失败金额:</td>--%>
						<%--<td><input class="easyui-validatebox" type="text"--%>
							<%--name="failRefund" readonly="readonly" style="width:200px;background:#eee;color:red;font-weight:bold"/></td>--%>
				<%--</tr>--%>
				<tr>
					<td style="text-align: right;">退款金额(元):</td>
					<td><input class="easyui-numberbox" type="text"
							id="refundFee" name="refundFee" style="width:200px" data-options="required:true"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款原因:</td>
					<td colspan="3"><textarea id="reason" name="reason"
					style="height: 100px; width: 350px;" maxlength="100"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- paylog -->
	<div id="paylog" class="easyui-dialog" title="支付明细"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 900px; height: 300px;">
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/orderParkrecord.js"></script>
</body>
</html>
