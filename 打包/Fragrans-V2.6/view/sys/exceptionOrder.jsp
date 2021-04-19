<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<style type="text/css">
easyui-combobox option {
	height: 50px;
}
</style>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">查询订单从</label><input name="startTime" id="startTime"
															class="easyui-datebox" style="width: 130px;">
				<label class="ui-label">至</label><input name="endTime" id="endTime"
															class="easyui-datebox" style="width: 130px;">
				<label class="ui-label">支付方式:</label><mytag:dictionary name="payType" id="payType" codeType="payType" isDefaultLine="1" dataOptions="required:false" />
				<label class="ui-label">交易订单编号:</label><input name="orderNo" class="easyui-box ui-text" style="width: 200px;">
				<label class="ui-label">处理状态:</label>
				<select id="cc" class="easyui-combobox" name="isHandle" style="width: 100px;" panelHeight="80px">
					<option value="">==请选择==</option>
					<option value="0">未处理</option>
					<option value="1">已处理</option>
				</select>
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

	<!--Edit Div  -->
	<div id="edit-win" class="easyui-dialog" title="转交客服"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 500px; height: 400px;">
		<form id="editForm" class="ui-form" method="post">
			<input type="hidden" id="id"> <input type="hidden"
				id="areaCode">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">城市名称:</td>
					<td><input id="areaName" name="areaName"
						class="easyui-textbox disable"
						data-options="fit : true,required:true" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">用户账号:</td>
					<td><input type="text" id="userAccount" name="userAccount"
						missingMessage="请输入用户账号" class="easyui-textbox disable"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">车牌号:</td>
					<td><input class="easyui-textbox disable" type="text"
						id="palteNo" name="palteNo" missingMessage="请输入车牌号"
						class="easyui-validatebox" data-options="validType:'length[1,64]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车记录ID:</td>
					<td><input class="easyui-textbox disable" type="text"
						id="parkrecordId" name="parkrecordId" missingMessage="请输入停车记录ID"
						data-options="validType:'length[1,64]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">是否完成订单:</td>
					<td><input name="isComplate" id="isComplate"
						class="easyui-textbox disable"></td>
				</tr>
				<tr>
					<td style="text-align: right;">投诉类型:</td>
					<td><input name="complainType" class="easyui-textbox disable"
						id="complainType" value="费用问题"></td>
				</tr>
				<tr>
					<td style="text-align: right;">投诉来源:</td>
					<td><input name="complainResource" id="complainResource"
						value="其他" class="easyui-textbox disable"></td>
				</tr>
				<tr>
					<td style="text-align: right;">投诉内容:</td>
					<td><textarea id="complainDesc" name="complainDesc" cols="50"
							rows="4" class="easyui-validatebox" type="text"
							missingMessage="请输入投诉内容" class="easyui-validatebox"
							data-options="validType:'length[1,2000]'"></textarea></td>
				</tr>
			</table>
		</form>

	</div>

	<!-- detail -->
	<div id="detail" class="easyui-dialog" title="停车记录详情"
		 data-options="closed:true,iconCls:'icon-save',modal:true"
		 style="width: 800px; height: 400px;">
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/exceptionOrder.js"></script>
</body>
</html>
