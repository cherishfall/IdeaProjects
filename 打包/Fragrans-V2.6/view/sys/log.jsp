<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">事件级别:</label><input name="level"
					class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">操作用户账号:</label><input name="account"
					class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">发生时间从:</label>
				 <input id="timeFrom" name="timeFrom" class="easyui-datetimebox"
					data-options="width:150" />
					 至<input id="timeTo" name="timeTo"
					class="easyui-datetimebox" data-options="width:150" />
			</p>
		    <a href="#" id="btn-search" class="easyui-linkbutton" style="margin-top:3px;" iconCls="icon-search" >查询</a>
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
		
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="日志信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 400px; height: 300px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id"> <input
				class="hidden" name="deleted">
			<div class="ui-edit">
				<div class="ftitle">日志信息</div>
				<div class="fitem">
					<label>日志级别:</label> <input class="easyui-validatebox"
						type="text" name="level" missingMessage="请输入操作用户帐号"
						data-options="required:true,validType:'length[1,25]'">
				</div>
				<div class="fitem">
					<label>操作描述:</label> <input class="easyui-validatebox" type="text"
						name="opDesc" missingMessage="请输入事件类型"
						data-options="required:true,validType:'length[1,50]'">
				</div>
				<div class="fitem">
					<label>操作用户帐号:</label> <input class="easyui-validatebox"
						type="text" name="account" missingMessage="请输入操作用户帐号"
						data-options="required:true,validType:'length[1,25]'">
				</div>
				
				<div class="fitem">
					<label>操作者所在的IP地址:</label> <input class="easyui-validatebox" type="text"
						name="ipAddress" missingMessage="请输入信息值"
						data-options="required:true,validType:'length[1,100]'">
				</div>
				<div class="fitem">
					<label>创建时间:</label> <input class="easyui-datetimebox"
						name="createTime" missingMessage="请输入创建时间"
						data-options="required:true,editable:false">
				</div>
			</div>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/log.js"></script>
</body>
</html>
