<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript"
	src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
<style>
	.datagrid-btable tr {
		height: 50px;
	}
	
	.datagrid-cell {
		height: 50px;
		line-height: 50px;
	}
	
	.datagrid-header {
		height: 20px;
		line-height: 20px;
	}
</style>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">收费员帐号:</label>
				<input name="userAccount" class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">手机号码:</label>
				<input name="mobile" class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">区域名称:</label>
				<input name="areaId" class="easyui-combotree ui-text" style="width: 150px;"
					data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
				<label class="ui-label">应用状态:</label>
				<mytag:dictionary codeType="USER_STATUS" id="status" name="status" isDefaultLine='1' dataOptions="required:false" />
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"iconCls="icon-search">查询</a> 
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- 编辑收费员信息 -->
	<div id="edit-win" class="easyui-dialog" title="收费员信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 600px; height: 350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">收费员账号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="userAccount" id="userAccount" missingMessage="请输入用户账户（手机号码）"
						data-options="required:true,validType:'mobile'" /></td>
					<td style="text-align: right;">昵称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="nickName"
						data-options="required:false,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">应用状态:</td>
					<td><mytag:dictionary codeType="USER_STATUS" id="status"
							name="status" /></td>
					<td style="text-align: right;">手机号码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="mobile" id="mobile" missingMessage="请输入手机号码"
						data-options="required:true,validType:'mobile'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">区域名称:</td>
					<td><input id="areaId" name="areaId" class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true" />
						<img
						src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#areaId').combotree('clear');" /></td>
					<td style="text-align: right;">地址:</td>
					<td><input class="easyui-validatebox" type="text"
						name="address"
						data-options="required:false,validType:'length[1,50]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">备注:</td>
					<td colspan="3"><textarea name="remark"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="regerDiv" class="easyui-dialog"
		data-options="draggable:true,title:'邀请信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width: 600px; height: 465px; padding: 10px;">
		<div class="easyui-layout"
			style="width: 550px; height: 395px;">
			<div data-options="region:'north',split:true"
				style="width: 500px; height: 60px;">
				<table style="padding: 8px;">
					<tr>
						<td class="ui-label">查询推广成绩从</td>
						<td><input id="startTime" name="startTime" class="easyui-datebox" data-options="width:150" /></td>
						<td class="ui-label">至</td>
						<td><input id="endTime" name="endTime" class="easyui-datebox" data-options="width:150" /></td>
						<td>
							<a href="#" id="search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
						</td>
					</tr>
				</table>
			</div>
			<div data-options="region:'center',split:true"
				style="width: 500px; height: 80px;">
				<table style="padding: 8px;">
					<tr>
						<td style="text-align: right;">邀请码 ：</td>
						<td><p id="regerCode" style="width: 150px;"></p></td>
						<!-- <td style="text-align: right;">上级邀请人 ：</td>
						<td><p id="parentAccount" style="width: 100px;"></p></td> -->
						<td style="text-align: right;">邀请人数 ：</td>
						<td><p id="regerCount" style="width: 150px;"></p></td>
					</tr>
					<!-- 
					<tr></tr>
					<tr>
						<td style="text-align: right;">推广缴费用户数 ：</td>
						<td><p id="payUserCount" style="width: 50px;"></p></td>
						<td style="text-align: right;">推广用户缴费订单数 ：</td>
						<td><p id="userPayOrderCount" style="width: 50px;"></p></td>
					</tr> -->
				</table>
			</div>
			<div data-options="region:'south',title:'邀请人信息列表'"
				style="padding: 5px; width: 500px; height: 280px;">
				<form class="ui-form" method="post">
					<table id="regerTable"></table>
				</form>
			</div>
		</div>
	</div>
	
	<div id="exportRegerResult" class="easyui-dialog" title="导出业绩"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 400px; height: 200px;" singleSelect:false>
		<form id="exportResultForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem" style="position:absolute; top:50px;">
				<div style="padding:5px;">
				<label class="ui-label">城市:</label><input id="exp_cityCode" name="cityCode" class="easyui-combotree ui-text" style="width:200px;" data-options="url:'${pageContext.request.contextPath}/area/getCity.do',fit : true,
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
		src="<%=basePath%>/assets/js/business/fragrans/user/userCollector.js"></script>
</body>
</html>
