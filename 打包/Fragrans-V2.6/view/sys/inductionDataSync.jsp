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
				<label class="ui-label">区域名称:</label><input name="areaName"
					class="easyui-box ui-text" style="width: 100px;"> <label
					class="ui-label">设备ID:</label><input name="appId"
					class="easyui-box ui-text" style="width: 100px;"> <label
					class="ui-label">设备密钥:</label> <input name="appKey"
					class="easyui-box ui-text" style="width: 100px;"> <label
					class="ui-label">设备名称:</label> <input name="appName"
					class="easyui-box ui-text" style="width: 100px;"> <label
					class="ui-label">失效日期:</label> <input name="expiredTime"
					type="text" class="easyui-datebox" " value="" style="width:140px" />
				<label class="ui-label">设备状态:</label>
				<mytag:dictionary codeType="APP_STATUS" id="isOpen" name="appStatus"
					isDefaultLine='0' dataOptions="required:false" />

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
	<div id="edit-win" class="easyui-dialog" title="诱导数据同步"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 650px; height: 500px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">区域编码:</td>
					<td><input class="easyui-validatebox" type="text" name="areaCode"
						missingMessage="请输入区域编码"
						data-options="required:true,validType:'length[1,50]'" /></td>
					<td style="text-align: right;">区域名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="areaName" missingMessage="请输入区域名称"
						data-options="required:true,validType:'length[1,20]'" /></td>
				</tr>

				<tr>
					<td style="text-align: right;">设备ID:</td>
					<td><input class="easyui-validatebox" type="text"
						name="appId" missingMessage="请输入设备ID"
						data-options="required:true,validType:'length[1,255]'" /></td>
					<td style="text-align: right;">设备密钥:</td>
					<td><input class="easyui-validatebox" type="text"
						name="appKey" missingMessage="请输入设备密钥"
						data-options="required:true,validType:'length[1,255]'" /></td>
				</tr>

				<tr>
					<td style="text-align: right;">设备名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="appName" missingMessage="请输入设备名称"
						data-options="required:true,validType:'length[1,255]'" /></td>
					<td style="text-align: right;">失效日期:</td>
					<td><input name="expiredTime" type="text"
						class="easyui-datebox" value="" style="width:145px" /></td>
				</tr>

				<tr>
					<td style="text-align: right;">设备状态:</td>
					<td><mytag:dictionary codeType="APP_STATUS" id="isDynamic"
							name="appStatus" /></td>
					<td style="text-align: right;">设备描述:</td>
					<td><input class="easyui-validatebox" type="text"
						name="appDesc" missingMessage="请输入设备描述"
						data-options="required:false,validType:'length[1,255]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">授权IP:</td>
					<td><input class="easyui-validatebox" type="text"
						name="authIp" missingMessage="请输入设备IP"
						data-options="required:false,validType:'length[1,255]'" /></td>

				</tr>
			</table>
		</form>
	</div>

	<div id="map" class="easyui-dialog"
		style="width: 650px; height: 480px; padding: 5px" closed="true">
		<div id="allMap" style="height: 420px; width: 570px"></div>
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/inductionDataSync.js"></script>
</body>
</html>
