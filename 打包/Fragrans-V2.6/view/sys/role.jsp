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
				<label class="ui-label">角色名称:</label><input name="roleName"
					class="easyui-box ui-text" style="width: 100px;"> <label
					class="ui-label">角色描述:</label><input name="roleDesc"
					class="easyui-box ui-text" style="width: 100px;">
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton" style="margin-top:3px;" iconCls="icon-search">查询</a>
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false" >
		<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="角色信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width:450px; height:450px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<input class="hidden" type="text" name="createdBy">
			<input class="hidden" type="text" name="createTime" > 
			<div class="ui-edit">
				<div class="fitem">
					<label>角色名称:</label> <input class="easyui-validatebox" type="text"
						id="roleName" name="roleName"
						data-options="required:true,validType:['length[1,10]','chinese']"
						style="width: 150px;">
				</div>
				<div class="fitem">
					<label>角色等级:</label> 
					<input class="easyui-combobox" type="text"
						id="roleLevel" name="roleLevel"
						data-options="required:true" style="width: 150px;"/>
				</div>
				<div class="fitem">
					<label>角色描述:</label>
					<textarea class="easyui-validatebox" data-options="validType:'length[1,50]'"
						id="roleDesc" name="roleDesc" style="width: 230px;"></textarea>
				</div>
				
				<div class="fitem">
					<label>功能权限:</label>
					<div
						style="border: 1px solid #A4BED4; width: 230px; height: 200px; margin-left: 105px; overflow: auto;">
						<ul id="menu-tree"></ul>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/role.js"></script>
</body>
</html>
