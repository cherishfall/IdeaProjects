<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@include file="/view/inc.jsp" %>
	</head>
	<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
	<form id="searchForm">
		<p class="ui-fields">
			<label class="ui-label">手机号码:</label><input name="account" class="easyui-box ui-text" style="width:100px;">
    	</p>
		<a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
		<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
	</form>  
	</div> 
	<!--  Search panel end -->
     
	<!-- DataList  -->
	<div region="center" border="false" >
	<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">  
		<form id="editForm" class="ui-form" method="post">  
			<input class="hidden" type="text" name="id">
     		
			<table cellpadding="5px;">	
				<tr>
					<td style="text-align: right;"> 用户手机号码或邮箱地址:</td>
					<td> 
						 <input class="easyui-validatebox" type="text" name="account" missingMessage="请输入用户手机号码或邮箱地址"
	                		    data-options="required:true,validType:'length[1,64]'" />
					</td>					 
				</tr>
				<tr>
					<td style="text-align: right;"> 验证码:</td>
					<td> 
						<input class="easyui-validatebox" type="text" name="captcha" missingMessage="请输入验证码"
			                		    data-options="required:true,validType:'length[1,6]'" />
					</td>					 
				</tr>
				<tr>
					<td style="text-align: right;"> 发送验证码原因: 1:注册激活  2:重置密码:</td>
					<td> 
						 <input class="easyui-validatebox" type="text" name="reason" missingMessage="请输入发送验证码原因: 1:注册激活  2:重置密码"
	                		    data-options="required:true,validType:'length[1,10]'" />
					</td>					 
				</tr>
				<tr>
					<td style="text-align: right;"> 过期时间:</td>
					<td> 
						 <input class="easyui-validatebox" type="text" name="expiredTime" missingMessage="请输入过期时间"
	                		    data-options="required:true,validType:'length[1,19]'" />
					</td>					 
				</tr>
				<tr>
					<td style="text-align: right;"> 创建时间:</td>
					<td> 
						 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间"
	                		    data-options="required:true,validType:'length[1,19]'" />
					</td>					 
				</tr>
				<tr>
					<td style="text-align: right;"> 更新时间:</td>
					<td> 
						 <input class="easyui-validatebox" type="text" name="updateTime" missingMessage="请输入更新时间"
	                		    data-options="required:true,validType:'length[1,19]'" />
					</td>					 
				</tr>
				<tr>
					<td style="text-align: right;"> 操作标示 ADD：增加 UPDATE:修改 DELETE:删除:</td>
					<td> 
						 <input class="easyui-validatebox" type="text" name="flag" missingMessage="请输入操作标示 ADD：增加 UPDATE:修改 DELETE:删除"
	                		    data-options="required:true,validType:'length[1,16]'" />
					</td>					 
				</tr>
			</table>
		</form>
	</div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/user/userCaptcha.js"></script>
  </body>
</html>
