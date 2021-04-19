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
 	 	   			<label class="ui-label">用户账号:</label><input id="userAccount" name="userAccount" class="easyui-box ui-text" style="width:100px;">
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
	<div id="sendTicket" class="easyui-dialog" title="赠送补偿券"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 270px; height: 200px;">
		<form id="sendTicketForm" class="ui-form" method="post">
			<input class="hidden" type="text" id="userAccountForTicket" name="userAccount">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">选择补偿券:</td>
					<td><input id="activityId" name="activityId" class="easyui-combobox"  data-options="required:true" />
					</td>
				</tr>
			</table>
		</form>
	</div>

	<!-- paylog -->
	<div id="paylog" class="easyui-dialog" title="支付明细"
		 data-options="closed:true,iconCls:'icon-save',modal:true"
		 style="width: 900px; height: 300px;">
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/activityTicketPutLog.js"></script>
</body>
</html>
