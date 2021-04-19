<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<!-- <div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">信息名称:</label><input name="codeName" class="easyui-box ui-text" style="width:100px;">
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div> -->
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-mark" class="easyui-dialog" title="活动标识配置"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 300px; height: 270px;">
		<form id="editMarkForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">活动：</td>
					<td><input class="easyui-combobox" type="text"
						id="activityIdAdd" name="activityId" missingMessage="请输入活动id"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动类型：</td>
					<td>
						<mytag:dictionary name="activityType" id="activityType" codeType="activityType"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">活动标识：</td>
					<td><input class="easyui-validatebox" type="text"
						name="mark" missingMessage="请输入活动标识"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">每日可领张数：</td>
					<td><input class="easyui-validatebox" type="text"
						name="dayGetcount" missingMessage="请输入每日可领张数"
						data-options="required:true,validType:'length[1,8]'" /></td>
				</tr>
					<tr>
					<td style="text-align: right;">总共可领张数：</td>
					<td><input class="easyui-validatebox" type="text"
						name="allGetcount" missingMessage="请输入总共可领张数"
						data-options="required:true,validType:'length[1,8]'" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="活动标识配置"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 300px; height: 270px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">活动：</td>
					<td><p id="activityIdEdit"></p></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动类型：</td>
					<td>
						<mytag:dictionary name="activityType" id="activityType" codeType="activityType"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">活动标识：</td>
					<td><input class="easyui-validatebox" type="text"
						name="mark" missingMessage="请输入活动标识"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">每日可领张数：</td>
					<td><input class="easyui-validatebox" type="text"
						name="dayGetcount" missingMessage="请输入每日可领张数"
						data-options="required:true,validType:'length[1,8]'" /></td>
				</tr>
					<tr>
					<td style="text-align: right;">总共可领张数：</td>
					<td><input class="easyui-validatebox" type="text"
						name="allGetcount" missingMessage="请输入总共可领张数"
						data-options="required:true,validType:'length[1,8]'" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/activity/activityMark.js"></script>
</body>
</html>
