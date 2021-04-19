<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list" style="width:700px"></table>
	</div>

	<!-- Edit Form -->

	<div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'菜单信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:550px; height:320px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">app按钮名称:</td>
					<td><input class="hidden" type="text" name="ID" id="id" value="">
					<input class="hidden" type="text" name="userName" id="" value="${session_user.name}">
						<input class="hidden" name="deleted"> <input
						class="easyui-validatebox" type="text" name="name"
						missingMessage="请输入app按钮名称"
						data-options="required:true,validType:'length[1,50]'"></td>

					<td style="text-align: right;">按钮ID:</td>
					<td><input class="easyui-validatebox"  class="easyui-validatebox" missingMessage="请输入app按钮ID" type="text" name="id"
						data-options="required:true,validType:'length[1,100]'"></td>
				</tr>
				


			</table>
		</form>
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/appMenu.js"></script>
</body>
</html>
