<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
	<script type="text/javascript" src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
<style>
.datagrid-btable tr{height:50px;}
.datagrid-cell {height:50px;line-height:50px;}
.datagrid-header {height:20px;line-height:20px;}

</style> 
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">用户帐号:</label><input name="userAccount"
					class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">手机号码:</label><input name="mobile"
					class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">应用状态:</label>
				<mytag:dictionary codeType="USER_STATUS" id="status" name="status"
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
	<div id="edit-win" class="easyui-dialog" title="客户端用户信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 600px; height: 350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">用户账号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="userAccount" id="userAccount" missingMessage="请输入用户账户（手机号码）"
						data-options="required:true,validType:'mobile'"/></td>
					<td style="text-align: right;">昵称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="nickName"
						data-options="required:false,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">应用状态:</td>
					<td> 
						 <mytag:dictionary codeType="USER_STATUS" id="status" name="status" />  
					</td>
					<td style="text-align: right;">手机号码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="mobile" id="mobile" missingMessage="请输入手机号码"
						data-options="required:true,validType:'mobile'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">邮箱:</td>
					<td><input class="easyui-validatebox" type="text"
						name="email"
						data-options="required:false,validType:'email'" /></td>
					<td style="text-align: right;">邮箱是否已激活:</td>
					<td> 
						 <mytag:dictionary codeType="IS_EMAIL_ACTIVITED" id="isEmailActivated" name="isEmailActivated" />  
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">区域名称:</td>
					<td>
						<input id="areaId" name="areaId" class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
						<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#areaId').combotree('clear');" />
					</td>
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

  	 
  	 <!-- appUserCar -->
	 <div id="appUserCar" class="easyui-dialog"
		data-options="draggable:true,title:'用户车辆',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:580px; height:400px; padding: 10px;">
		<form id="editFormCar" class="ui-form" method="post">
			<table id="userCar"></table>
		</form>
	</div> 
	<!-- appUserPay -->
	 <div id="appUserPay" class="easyui-dialog"
		data-options="draggable:true,title:'用户支付',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:680px; height:400px; padding: 10px;">
		<form id="editFormPay" class="ui-form" method="post">
			<table id="userPay"></table>
		</form>
	</div> 
	<!-- appUserCaptcha -->
	 <div id="appUserCaptcha" class="easyui-dialog"
		data-options="draggable:true,title:'用户验证',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:780px; height:400px; padding: 10px;">
		<form id="editFormCaptcha" class="ui-form" method="post">
			<table id="userCaptcha"></table>
		</form>
	</div>
	
	<!-- Edit Form -->
	<div id="edit-win-collector" class="easyui-dialog" title="收费员信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 600px; height: 350px;">
		<div style="">
		<form id="editCollectorForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">用户账号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="userAccount" id="_userAccount" missingMessage="请输入用户账户（手机号码）"
						data-options="required:true,validType:'mobile'"/></td>
					<td style="text-align: right;">昵称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="nickName"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">应用状态:</td>
					<td> 
						 <mytag:dictionary codeType="USER_STATUS" id="_status" name="status" />  
					</td>
					<td style="text-align: right;">手机号码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="mobile" id="_mobile" missingMessage="请输入手机号码"
						data-options="required:true,validType:'mobile'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">邮箱:</td>
					<td><input class="easyui-validatebox" type="text"
						name="email"
						data-options="required:false,validType:'email'" /></td>
					<td style="text-align: right;">邮箱是否已激活:</td>
					<td> 
						 <mytag:dictionary codeType="IS_EMAIL_ACTIVITED" id="_isEmailActivated" name="isEmailActivated" />  
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">区域名称:</td>
					<td>
						<input id="_areaId" name="areaId" class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true" />
						<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#_areaId').combotree('clear');" />
					</td>
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
		<div style="position: relative;top:50px;border:solid 0.1px #EAEAEA;">
		<div style="width:60px;float:left;position: relative;top:10px;left:460px;">
			<a id="confirm" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="margin:0 auto;">保存</a>  
		</div> 
        <div style="width:60px;float:left;position: relative;top:10px;left:460px;">
			<a id="close" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'">关闭</a>  
		</div>
		</div>
	</div>
	
	<div id="regerDiv" class="easyui-dialog"
		data-options="draggable:true,title:'邀请信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true " style="width: 600px; height: 465px; padding: 10px;">
		<div id="cc" class="easyui-layout" style="width: 550px; height: 395px;">
			<div data-options="region:'north',split:true" style="width: 500px; height: 50px;">
				<table style="padding:8px;">
					<tr>
						<td style="text-align: right;">邀请码:</td>
						<td><p id="regerCode" style=" width: 50px;"> </p></td>
						<td style="text-align: right;">上级邀请人:</td>
						<td><p id="parentAccount" style=" width: 100px;"> </p></td>
						<td style="text-align: right;">邀请人个数:</td>
						<td><p id="regerCount" style=" width: 50px;"> </p></td>
					</tr>
				</table>
			</div> 
			<div data-options="region:'center',title:'邀请人信息列表'" style="padding: 5px;width: 500px; height:300px;">
				<form id="editRegerForm" class="ui-form" method="post">
					<table id="regerTable"></table>
				</form>
			</div>
		</div>
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/user/appUser.js"></script>
</body>
</html>
