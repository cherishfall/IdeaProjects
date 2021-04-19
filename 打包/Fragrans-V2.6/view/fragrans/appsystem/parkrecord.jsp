<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript"
	src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 100px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">区域名称:</label><input name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">停车点名称:</label><input name="parkName"
					class="easyui-box ui-text" style="width: 150px;">
				<label class="ui-label">车牌号:</label><input name="plateNo"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">停车记录id:</label><input name="parkrecordId"
					class="easyui-box ui-text" style="width: 100px;">
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
	<div id="edit-win" class="easyui-dialog" title="编辑"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 400px; height: 300px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">城市代码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="cityCode" missingMessage="请输入城市代码"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">订单编号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="orderNo" missingMessage="请输入订单编号"
						data-options="required:true,validType:'length[1,64]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车记录ID:</td>
					<td><input class="easyui-validatebox" type="text"
						name="parkrecordId" missingMessage="请输入停车记录ID"
						data-options="required:true,validType:'length[1,64]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">泊位编号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="berthCode" missingMessage="请输入泊位编号"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车点名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="parkName" missingMessage="请输入停车点名称"
						data-options="required:true,validType:'length[1,255]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车点位置:</td>
					<td><input class="easyui-validatebox" type="text"
						name="parkAddress" missingMessage="请输入停车点位置"
						data-options="required:true,validType:'length[1,255]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">车牌号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="plateNo" missingMessage="请输入车牌号"
						data-options="required:true,validType:'length[1,20]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">驶入时间:</td>
					<td><input class="easyui-validatebox" type="text"
						name="arrivalTime" missingMessage="请输入驶入时间"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">本次缴费结算时间:</td>
					<td><input class="easyui-validatebox" type="text"
						name="departureTime" missingMessage="请输入本次缴费结算时间"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">费率描述:</td>
					<td><input class="easyui-validatebox" type="text"
						name="chargeRate" missingMessage="请输入费率描述"
						data-options="required:true,validType:'length[1,100]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车总费:</td>
					<td><input class="easyui-validatebox" type="text"
						name="parkFee" missingMessage="请输入停车总费"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">已付费:</td>
					<td><input class="easyui-validatebox" type="text"
						name="padFee" missingMessage="请输入已付费"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">未付费:</td>
					<td><input class="easyui-validatebox" type="text"
						name="unpadFee" missingMessage="请输入未付费"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">折扣费:</td>
					<td><input class="easyui-validatebox" type="text"
						name="discountFee" missingMessage="请输入折扣费"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车状态(1驶离;2未驶离):</td>
					<td><input class="easyui-validatebox" type="text"
						name="parkStatus" missingMessage="请输入停车状态(1驶离;2未驶离)"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">是否有欠费(1是;0否):</td>
					<td><input class="easyui-validatebox" type="text"
						name="isComplate" missingMessage="请输入是否有欠费(1是;0否)"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">
						描述（可填具体位置信息，如街道，车位号，停车起至时间，小时停车价格等）:</td>
					<td><input class="easyui-validatebox" type="text" name="note"
						missingMessage="请输入描述（可填具体位置信息，如街道，车位号，停车起至时间，小时停车价格等）"
						data-options="required:true,validType:'length[1,500]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">创建时间,默认SYSDATE:</td>
					<td><input class="easyui-validatebox" type="text"
						name="createTime" missingMessage="请输入创建时间,默认SYSDATE"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">更新时间,默认SYSDATE:</td>
					<td><input class="easyui-validatebox" type="text"
						name="updateTime" missingMessage="请输入更新时间,默认SYSDATE"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- detail -->
	<div id="detail" class="easyui-dialog" title="停车记录详情"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 800px; height: 400px;">
	</div>
	
	<!-- paylog -->
	<div id="paylog" class="easyui-dialog" title="支付明细"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 900px; height: 300px;">
	</div>
	
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/parkrecord.js"></script>
</body>
</html>
