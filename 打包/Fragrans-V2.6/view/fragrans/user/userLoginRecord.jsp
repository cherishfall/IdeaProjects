<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">用户账号:</label><input name="userAccount"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">客户端设备号:</label><input name="deviceNo"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">操作类型:</label><mytag:dictionary codeType="USER_LOGIN_TYPE" id="type" name="type" isDefaultLine='1' dataOptions="required:false"/>
				<label class="ui-label">结果状态:</label><mytag:dictionary codeType="USER_LOGIN_RECORD_STATUS" id="status" name="status" isDefaultLine='1' dataOptions="required:false"/>
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

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="用户登录记录"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 400px; height: 300px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				</tr>
				<tr>
					<td style="text-align: right;">客户端设备号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="deviceNo" missingMessage="请输入客户端设备号"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">客户端版本:</td>
					<td><input class="easyui-validatebox" type="text"
						name="clientVersion" missingMessage="请输入客户端版本"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">手机型号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="deviceModel" missingMessage="请输入手机型号"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">OS版本:</td>
					<td><input class="easyui-validatebox" type="text"
						name="deviceOsVersion" missingMessage="请输入OS版本"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">操作类型:</td>
					<td><mytag:dictionary codeType="USER_LOGIN_TYPE" id="type" name="type"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">状态 :</td>
					<td><mytag:dictionary codeType="USER_LOGIN_RECORD_STATUS" id="status" name="status"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">登录退出结果，如登录成功、退出成功、登录失败）:</td>
					<td><input class="easyui-validatebox" type="text"
						name="description" missingMessage="请输入登录退出结果，如登录成功、退出成功、登录失败）"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/user/userLoginRecord.js"></script>
</body>
</html>
