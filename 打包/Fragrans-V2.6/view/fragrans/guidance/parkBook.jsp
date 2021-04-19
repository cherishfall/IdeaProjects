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
				<label class="ui-label">区域名称:</label><input name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				 <label class="ui-label">停车场名称:</label><input name="name" class="easyui-box ui-text" style="width:100px;">
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
	<div id="edit-win" class="easyui-dialog" title="预约信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 550px; height: 350px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">停车场名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="name" readonly="readonly" style="background-color:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车点编码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="parkCode" readonly="readonly" style="background-color:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">预约费:</td>
					<td><input class="easyui-numberbox" type="text"
						name="bookRate" missingMessage="请输入预约费"
						data-options="required:true,validType:['length[1,10]']" /></td>
				</tr>
				
				<tr>
					<td style="text-align: right;">数据来源:</td>
					<td><input class="easyui-validatebox" type="text"
						name="dataFrom" missingMessage="请输入数据来源"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">备注:</td>
					<td colspan="3"><textarea name="remark"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/guidance/parkBook.js"></script>
</body>
</html>
