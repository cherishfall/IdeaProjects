<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 110px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
			<div style="padding:10px;">
				 <label class="ui-label">服务名称:</label><input name="serviceName" class="easyui-box ui-text" style="width:200px;">
				 <label class="ui-label">用户账号:</label><input name="userAccount" class="easyui-box ui-text" style="width:200px;">
				 <label class="ui-label">请求内容:</label><input name="requestMsg" class="easyui-box ui-text" style="width:200px;">
				 <label class="ui-label">响应内容:</label><input name="repsonseMsg" class="easyui-box ui-text" style="width:200px;">
			</div>
			<div style="padding-left:10px;">
				 <label class="ui-label">请求时间从:</label>
				 <input id="startDate" name="startDate" class="easyui-datetimebox"
					data-options="width:150" />
					 至 <input id="endDate" name="endDate"
					class="easyui-datetimebox" data-options="width:150" />
				 <a href="#" id="btn-search" class="easyui-linkbutton"  iconCls="icon-search">查询</a> 
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
			</div>
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
					<td style="text-align: right;">应用ID:</td>
					<td><input class="easyui-validatebox" type="text" name="appId"
						missingMessage="请输入应用ID"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">设备号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="deviceNo" missingMessage="请输入设备号"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">操作记录描述:</td>
					<td><input class="easyui-validatebox" type="text" name="note"
						missingMessage="请输入操作记录描述"
						data-options="required:true,validType:'length[1,500]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">请求数据:</td>
					<td><input class="easyui-validatebox" type="text"
						name="requestMsg" missingMessage="请输入请求数据"
						data-options="required:true,validType:'length[1,2000]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">响应数据:</td>
					<td><input class="easyui-validatebox" type="text"
						name="repsonseMsg" missingMessage="请输入响应数据"
						data-options="required:true,validType:'length[1,2000]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">请求时间:</td>
					<td><input class="easyui-validatebox" type="text"
						name="requestTime" missingMessage="请输入请求时间"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">响应时间:</td>
					<td><input class="easyui-validatebox" type="text"
						name="responseTime" missingMessage="请输入响应时间"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">操作标示:</td>
					<td><input class="easyui-validatebox" type="text" name="flag"
						missingMessage="请输入操作标示 ADD：增加 UPDATE:修改 DELETE:删除"
						data-options="required:true,validType:'length[1,16]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">创建时间:</td>
					<td><input class="easyui-validatebox" type="text"
						name="createTime" missingMessage="请输入创建时间,默认SYSDATE"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- detail -->
	<div id="detail" class="easyui-dialog" title="数据"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 570px; height: 500px;">
		<form id="detailForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">服务名称:</td>
					<td colspan="3"><p id="serviceName" name="serviceName" style="width:400px;"> </p>
<!-- 					<input id="serviceName" name="serviceName" -->
<!-- 						style="height: 30px; width: 400px;" maxlength="100" readonly="readonly"></textarea></td> -->
				</tr>
				<tr>
					<td style="text-align: right;">请求数据:</td>
					<td colspan="3"><textarea name="requestMsg"
						style="height: 100px; width: 400px;" maxlength="100" readonly="readonly"></textarea></td>
				</tr>
				<tr>
					<td style="text-align: right;">响应数据:</td>
					<td colspan="3"><textarea name="repsonseMsg"
						style="height: 150px; width: 400px;" maxlength="100" readonly="readonly"></textarea></td>
				</tr>
				<tr>
					<td style="text-align: right;">操作记录描述:</td>
					<td colspan="3"><textarea name="note"
						style="height: 80px; width: 400px;" maxlength="100" readonly="readonly"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- detail -->
	<div id="decodeBase64Div" class="easyui-dialog" title="BASE64解码"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 590px; height: 500px;">
		<form id="decodeBase64Form" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">加密报文:</td>
					<td colspan="6"><textarea id="codeMsg" name="codeMsg"
						style="height: 180px; width:450px;" ></textarea></td>
				</tr>
				<tr>
					<td style="text-align: right;">解密报文:</td>
					<td colspan="6"><textarea id="decodeMsg" name="decodeMsg"
						style="height: 180px; width: 450px;"  readonly="readonly"></textarea></td>
				</tr>
			</table>
			<div style="width:160px;float:left;position: relative;top:25px;left:400px;">
				<a id="confirm" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="margin:0 auto;">确定</a>  
				<a id="close" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'">关闭</a></td>
			</div>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/appLog.js"></script>
</body>
</html>
