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
				<label class="ui-label">邀请注册人数范围:</label><input name="regUserCountlimitMin" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label"> ~ </label><input name="regUserCountlimitMax" class="easyui-box ui-text" style="width:100px;">
			</p>
			<p class="ui-fields">
				<label class="ui-label">邀请注册缴费人数大于等于:</label><input name="payUserCountlimit" class="easyui-box ui-text" style="width:100px;">
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
	
	<div id="sms-win" class="easyui-dialog" title="发送短信"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 440px; height: 260px;">
		<form id="smsForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="userAccount">
			<div class="ui-edit">
				<div class="fitem" style="position:absolute; top:50px;">
					<div style="padding:5px;">
					<label class="ui-label">短信内容:</label>
						<textarea class="easyui-validatebox" type="text"
							id="content" name="content" missingMessage="请输入短信内容"
							data-options="required:true,validType:'length[1,225]'" style="width:250px;height:120px;"></textarea>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div id="test-sms-win" class="easyui-dialog" title="发送短信"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 440px; height: 260px;">
		<form id="testSmsForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="userAccount">
			<div class="ui-edit">
				<div class="fitem" style="position:absolute; top:50px;">
					<div style="padding:5px;">
					<label class="ui-label">手机号:</label>
						<input class="easyui-validatebox" type="text"
							id="shareGetUsers" name="shareGetUsers" missingMessage="请输入手机号码"
							data-options="required:true,validType:'length[1,11]'"/>
					</div>
					<div style="padding:5px;">
					<label class="ui-label">短信内容:</label>
						<textarea class="easyui-validatebox" type="text"
							id="testContent" name="content" missingMessage="请输入短信内容"
							data-options="required:true,validType:'length[1,225]'" style="width:250px;height:120px;"></textarea>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/activity/shareGetUser.js"></script>
</body>
</html>
