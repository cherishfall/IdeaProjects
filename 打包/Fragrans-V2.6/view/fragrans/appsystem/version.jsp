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
				<label class="ui-label">应用类型:</label><mytag:dictionary codeType="APP_TYPE" id="appType" name="appType" isDefaultLine='1' dataOptions="required:false"/>
				<label class="ui-label">版本状态:</label><mytag:dictionary codeType="VERSION_TYPE" id="status" name="status" isDefaultLine='1' dataOptions="required:false"/> 
				<label class="ui-label">是否是强制版本:</label><mytag:dictionary codeType="YESORNO" id="isForce" name="isForce" isDefaultLine='1' dataOptions="required:false"/>
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
	<div id="edit-win" class="easyui-dialog" title="版本信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 630px; height: 360px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">版本号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="versionCode" missingMessage="请输入版本号"
						data-options="required:true,validType:'length[1,16]'" /></td>
					<td style="text-align: right;">版本名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="versionName" missingMessage="请输入版本名称"
						data-options="required:true,validType:'length[1,64]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">版本值:</td>
					<td><input class="easyui-validatebox" type="text"
						name="versionValue" missingMessage="请输入版本值"
						data-options="required:false,validType:'length[1,10]'" /></td>
					<td style="text-align: right;">应用类型:</td>
					<td><mytag:dictionary name="appType" id="appType" codeType="APP_TYPE" style="width:200px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">版本校验码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="versionChecksum" missingMessage="请输入版本校验码（哈希值或MD5）"
						data-options="required:true,validType:'length[1,100]'" /></td>
					<td style="text-align: right;">版本下载地址:</td>
					<td><input class="easyui-validatebox" type="text"
						name="downloadUrl" missingMessage="请输入版本下载地址"
						data-options="required:true,validType:'length[1,100]'"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">资源包版本:</td>
					<td><input class="easyui-validatebox" type="text"
						name="resourceVersion" missingMessage="请输入资源包版本"
						data-options="required:true,validType:'length[1,16]'" /></td>
					<td style="text-align: right;">资源包版本值:</td>
					<td><input class="easyui-numberbox" type="text"
						name="resourceValue" missingMessage="请输入资源包版本值"
						data-options="required:false,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">资源包下载地址:</td>
					<td><input class="easyui-validatebox" type="text"
						name="resourceDownloadUrl" missingMessage="请输入资源包下载地址"
						data-options="required:true,validType:'length[1,100]'" /></td>
					<td style="text-align: right;">资源包描述:</td>
					<td><input class="easyui-validatebox" type="text"
						name="resourceDesc" missingMessage="请输入资源包描述"
						data-options="required:true,validType:'length[1,100]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">资源包校验码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="resourceChecksum" missingMessage="请输入资源包校验码（哈希值或MD5）"
						data-options="required:true,validType:'length[1,100]'" /></td>
					<td style="text-align: right;">版本状态:</td>
					<td>
						<mytag:dictionary name="status" id="status" codeType="VERSION_TYPE"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">是否是强制版本:</td>
					<td>
						<mytag:dictionary name="isForce" id="isForce" codeType="YESORNO"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">版本描述:</td>
					<td colspan="3">
						<textarea id="versionDesc" name="versionDesc"style="height: 80px; width: 390px;" maxlength="215"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/version.js"></script>
</body>
</html>
