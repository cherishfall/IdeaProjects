<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;"
		title="过滤条件" data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">帐号:</label><input name="account" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">姓名:</label><input name="name" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">状态:</label>
					 <mytag:dictionary codeType="STATE" id="state" name="state" isDefaultLine='1' dataOptions="required:false"/>
				<label class="ui-label">性别:</label>
					 <mytag:dictionary codeType="GENDER" id="gender" name="gender" isDefaultLine='1' dataOptions="required:false"/>  
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton" style="margin-top:3px;" iconCls="icon-search" >查询</a>
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>


	<div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'用户信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width: 600px; height:350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">登录账号:</td>
					<td>
					<input class="hidden" type="text" name="id" />
					<input class="easyui-validatebox" type="text" name="account" missingMessage="请输入登录账号"
 							   data-options="required:true,validType:'length[1,10]'">
 					</td>
				 	<td style="text-align: right;">所属部门:</td>
					<td> 
						<input id="departmentId" name="departmentId"
						class="easyui-combotree" data-options="fit : true,
						idField : 'id',treeField : 'departmentName',parentField : 'parentId',required:true" 
						style="width:200px"/>
						<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#departmentId').combotree('clear');" />	
 					</td>
				</tr>
				<tr>
					<td style="text-align: right;">真实姓名:</td>
					<td><input class="easyui-validatebox" type="text"
						name="name" missingMessage="请输入真实姓名"
						data-options="required:true,validType:'length[1,50]'"> 
					</td>
 					<td style="text-align: right;"> 是否超级管理员: </td>
					<td>  
						<c:if test="${session_user.superAdmin == 1}">
								<mytag:dictionary codeType="YESORNO" id="superAdmin" name="superAdmin" style="width:150px"/>  
						</c:if>
						<c:if test="${session_user.superAdmin != 1}">
							 <input class="hidden" name="superAdmin" style="width:150px"> <c:if test="${session_user.superAdmin != 1}">否</c:if>  
						</c:if>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">性别:</td>
					<td> 
						<mytag:dictionary codeType="GENDER" id="gender" name="gender"/>  
					</td>
					<td style="text-align: right;">联系方式:</td>
					<td> 
						<input class="easyui-validatebox" type="text" name="phone" missingMessage="请输入联系方式"
							   data-options="required:true,validType:'mobile'" style="width:150px">  
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">昵称:</td>
					<td> 
						<input class="easyui-validatebox" type="text" name="nickname" missingMessage="请输入昵称"
										data-options="validType:'length[1,32]',required:true"> 
					</td>
					<td style="text-align: right;">电子邮箱:</td>
					<td> 
						<input class="easyui-validatebox" type="text" name="email" missingMessage="请输入电子邮箱"
										 data-options="required:true,validType:'email'" style="width:150px">  
					</td>
				</tr>
				
				<tr>
					<td style="text-align: right;">状态 :</td>
					<td> 
						 <mytag:dictionary codeType="STATE" id="state" name="state" />  
					</td>
				</tr>
				
				
				<tr>
					<td style="text-align: right;">备注:</td>
					<td colspan="3"><textarea name="note"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
				</tr>
				
				
			</table>
		</form>
	</div>
 
	<!-- authority Form -->
	<div id="authority" class="easyui-dialog" title="授权"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 400px; height: 300px;">
		<form id="authorityForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
					<label>账号:</label> <input class="easyui-validatebox" type="text"
						readonly="readonly" name="account" data-options="required:true"
						readonly="readonly"></input>
				</div>
				<div class="fitem">
					<label>角色选择:</label> <select class="easyui-combobox" id="roleIds"
						name="roleIds" data-options="width:135"></select>
				</div>
			</div>
		</form>
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/user.js"></script>
</body>
</html>
