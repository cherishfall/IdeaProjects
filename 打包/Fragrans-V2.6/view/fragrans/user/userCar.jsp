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
				 <label class="ui-label">车牌号:</label><input name="plateNo" class="easyui-box ui-text" style="width:100px;">
				 <label class="ui-label">是否默认:</label>
				 <mytag:dictionary codeType="IS_DEFAULT" id="isDefault" name="isDefault"
					isDefaultLine='1' dataOptions="required:false" /> 
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
	<div id="edit-win" class="easyui-dialog" title="用户车辆信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 300px; height: 200px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">车牌号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="plateNo" missingMessage="请输入车牌号"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">是否默认:</td>
					<td>  
						<mytag:dictionary codeType="IS_DEFAULT" id="isDefault" name="isDefault" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">备注:</td>
					<td><input class="easyui-validatebox" type="text" name="note"
						missingMessage="请输入备注"
						data-options="required:true,validType:'length[1,50]'" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/user/userCar.js"></script>
</body>
</html>
