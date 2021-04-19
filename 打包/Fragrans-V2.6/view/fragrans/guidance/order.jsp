<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 150px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">用户账号:</label><input name="userAccount"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">买家账号:</label><input name="buyerAccount"
					class="easyui-box ui-text" style="width: 130px;">
				<label class="ui-label">交易订单编号:</label><input name="orderNo"
					class="easyui-box ui-text" style="width: 180px;"> 
				<label class="ui-label">通知状态:</label>
				<mytag:dictionary name="notifyStatus" id="notifyStatus" codeType="NOTIFY_STATUS"
					isDefaultLine='1' dataOptions="required:false" />
			</p>
			<p class="ui-fields">
				<label class="ui-label">订单状态:</label>
				<mytag:dictionary name="orderStatus" id="orderStatus" codeType="ORDER_STATUS"
					isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">支付方式:</label>
				<mytag:dictionary name="payType" id="payType" codeType="PAY_METHOD"
					isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">停车记录ID:</label><input name="parkrecordId"
					class="easyui-box ui-text" style="width: 140px;"> 
			</p>
			<p class="ui-fields">
				<label class="ui-label">开始时间:</label><input name="startTime" id="startTime"
					class="easyui-datetimebox" style="width: 180px;"> 
				<label class="ui-label">结束时间:</label><input name="endTime" id="endTime"
					class="easyui-datetimebox" style="width: 180px;"> 
				<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
			</p>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="支付记录"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 550px; height: 350px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">城市代码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="cityCode" missingMessage="请输入城市代码"
						data-options="required:true,validType:'length[1,10]'" /></td>
					<td style="text-align: right;">区级代码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="areaCode" missingMessage="请输入区级代码"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">用户账号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="userAccount" missingMessage="请输入用户账号"
						data-options="required:true,validType:'length[1,32]'" /></td>
					<td style="text-align: right;">订单标题:</td>
					<td><input class="easyui-validatebox" type="text"
						name="subject" missingMessage="请输入订单标题"
						data-options="required:true,validType:'length[1,64]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车记录ID:</td>
					<td><input class="easyui-validatebox" type="text"
						name="parkrecordId" missingMessage="请输入停车记录ID"
						data-options="required:true,validType:'length[1,16]'" /></td>
					<td style="text-align: right;">支付方式:</td>
					<td><mytag:dictionary name="payType" id="payType"
							codeType="PAY_METHOD" dataOptions="required:false"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">订单金额:</td>
					<td><input class="easyui-validatebox" type="text" name="price"
						missingMessage="请输入订单金额"
						data-options="required:true,validType:'length[1,10]'" /></td>
					<td style="text-align: right;">买家账号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="buyerAccount" missingMessage="请输入买家账号"
						data-options="required:false,validType:'length[1,64]'" /></td>
				</tr>
<!-- 				<tr>
					<td style="text-align: right;">交易订单编号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="orderNo" readonly="readonly" style="background-color:#eee"/></td>
				</tr>
 -->
 				<tr>
					<td style="text-align: right;">订单描述:</td>
					<td colspan="3"><textarea name="orderBody"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- paylog -->
	<div id="paylog" class="easyui-dialog" title="支付明细"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 900px; height: 300px;">
	</div>
	
	<!-- detail -->
	<div id="detail" class="easyui-dialog" title="停车记录详情"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 800px; height: 400px;">
	</div>
	
	<div id="export-win" class="easyui-dialog" title="导出支付订单"
		 data-options="closed:true,iconCls:'icon-save',modal:true"
		 style="width: 350px; height: 260px;" singleSelect:false>
		<form id="exportForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem" style="position:absolute; top:50px;">
					<div style="padding:5px;">
						<label class="ui-label">城市名称:</label>
						<input id="cityId" name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
					</div>
					<div style="padding:5px;">
						<label>开始日期:</label>
						<input id="startDate" name="startDate" class="easyui-datebox" data-options="width:150" />
					</div>
					<div style="padding:5px;">
						<label>结束日期:</label>
						<input id="endDate" name="endDate" class="easyui-datebox" data-options="width:150" />
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/guidance/order.js"></script>
</body>
</html>
