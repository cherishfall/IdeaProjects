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
				<label class="ui-label">停车点名称:</label><input name="parkName" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">剩余可预约泊位数:</label><input name="remainBookableNum" class="easyui-box ui-text" style="width:100px;"> 
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
	<div id="edit-win" class="easyui-dialog" title="编辑"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 600px; height: 300px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">所在城市:</td>
					<td><input id="cityId" name="cityId" 
						class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath}/park/getCityTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true" />
						<img
						src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#regionId').combotree('clear');"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">空余泊位数:</td>
					<td><input class="easyui-validatebox" type="text"
						name="availableBerthNum" missingMessage="请输入空余泊位数"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">可预约泊位数:</td>
					<td><input class="easyui-validatebox" type="text"
						name="bookableNum" missingMessage="请输入可预约泊位数"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">剩余可预约泊位数:</td>
					<td><input class="easyui-validatebox" type="text"
						name="remainBookableNum" missingMessage="请输入剩余可预约泊位数"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/guidance/parkFlow.js"></script>
</body>
</html>
