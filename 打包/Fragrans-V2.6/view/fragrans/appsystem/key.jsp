<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.innotek.common.util.UtilDate"%>
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
				 <label class="ui-label">应用名称:</label><input name="appName" class="easyui-box ui-text" style="width:100px;">
				 <label class="ui-label">应用状态:</label>
					 <mytag:dictionary codeType="APP_STATUS" id="appStatus" name="appStatus" isDefaultLine='1' dataOptions="required:false"/> 
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
	<div id="edit-win" class="easyui-dialog" title="密钥信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 480px; height: 380px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">应用编号:</td>
					<td><input class="easyui-validatebox" type="text" name="appId" readonly="readonly"
	                data-options="required:true,validType:'length[1,32]'" readonly="readonly" style="background-color:#eee;width:250px">
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">应用密钥值:</td>
					<td><input class="easyui-validatebox" type="text" name="appKey" 
	                data-options="required:true,validType:'length[1,64]'" readonly="readonly" style="background-color:#eee;width:250px">
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">应用名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="appName" missingMessage="请输入应用名称"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">有效期:</td>
					<td><input class="easyui-datebox" type="text"
						name="expiredDay" missingMessage="请输入有效期"
						data-options="required:false,editable:false" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">应用状态:</td>
					<td> 
						 <mytag:dictionary codeType="APP_STATUS" id="appStatus" name="appStatus" />  
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">应用描述:</td>
					<td>
						<input class="easyui-validatebox" type="text"
						name="appDesc" missingMessage="请输入应用名称"
						data-options="required:true,validType:'length[1,100]'" style="width:300px;height:50px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">是否超级权限:</td>
					<td> 
						 <mytag:dictionary codeType="YESORNO" id="isSuper" name="isSuper" />  
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="requestAuthConfDiv" class="easyui-dialog"
		 data-options="draggable:true,title:'授权接口',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		 style="width:670px; height:360px; padding: 10px;">
		<form class="ui-form" method="post">
			<table id="requestAuthConf"></table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/key.js"></script>
</body>
</html>
