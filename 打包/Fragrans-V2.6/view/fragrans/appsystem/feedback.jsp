<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script src="<%=basePath%>/assets/js/ckeditor/ckeditor.js"></script>
   <script src="<%=basePath%>/assets/js/ckeditor/samples/js/sample.js"></script>
   <link rel="stylesheet" href="<%=basePath%>/assets/js/ckeditor/samples/css/samples.css">
   <link rel="stylesheet" href="<%=basePath%>/assets/js/ckeditor/samples/toolbarconfigurator/lib/codemirror/neo.css">
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 100px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">用户账户:</label><input name="account" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">手机号:</label><input name="phone" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">车牌号:</label><input name="plate" class="easyui-box ui-text" style="width:100px;">
			    <label class="ui-label">联系人:</label><input name="contact" class="easyui-box ui-text" style="width:100px;">
			    <label class="ui-label">问题类型:</label><mytag:dictionary codeType="FEEDBACK_TYPE" id="type" name="type" isDefaultLine='1' dataOptions="required:false" />
					 <br/>
			    <label class="ui-label">反馈内容:</label><input name="content" class="easyui-box ui-text" style="width:100px;">
			    <label class="ui-label">处理状态:	</label>
				<mytag:dictionary codeType="COMPLAIN_STATUS" id="processStatus" name="processStatus" isDefaultLine='1' dataOptions="required:false" />
			    <label class="ui-label">反馈时间从:</label><input name="startTime" type="text" class="easyui-datetimebox" value="" style="width:168px"></input>
			    <label class="ui-label">到：</label><input name="endTime" type="text" class="easyui-datetimebox" value="" style="width:168px"></input>
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
	<div id="edit-win" class="easyui-dialog" title="用户反馈"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 510px; height: 450px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id" id="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<!-- <td style="width:400px;text-align: right;">
					<lable>用户设备ID:</lable>
					<input class="easyui-validatebox" type="text"
						name="deviceId" missingMessage="请输入用户设备ID"
						data-options="required:true,validType:'length[1,36]'" /></td> -->
					<td style="width:400px;text-align: right;">
					<lable>用户账户:</lable>
					<input class="easyui-validatebox" type="text"
						name="account" missingMessage="请输入用户账户" readonly="readonly" style="background:#eee"/></td>
					<td style="width:400px;text-align: right;">
					<lable>车牌号:</lable>
					<input class="easyui-validatebox" type="text" name="plate"
						missingMessage="请输入车牌号" readonly="readonly" style="background:#eee"/></td>
				</tr>
				<tr>
					<td style="width:400px;text-align: right;">
					<lable>联系人:</lable>
					<input class="easyui-validatebox" type="text"
						name="contact" missingMessage="请输入联系人" readonly="readonly" style="background:#eee"/></td>
					<td style="width:400px;text-align: right;" >
					<lable>应用ID:</lable>
					<input class="easyui-validatebox" type="text" name="appId"
						missingMessage="请输入应用ID" readonly="readonly" style="background:#eee"/></td>
				</tr>
				<tr>
					<td style="width:400px;text-align: right;">
					<lable>应用版本号:</lable>
					<input class="easyui-validatebox" type="text" name="appVersion"
						missingMessage="请输入应用版本号" readonly="readonly" style="background:#eee"/></td>
					<td style="width:400px;text-align: right;">
					<lable>问题类型:</lable>
					<input class="easyui-validatebox" type="text" id="type" name="type" readonly="readonly" style="background:#eee"/></td>
				</tr>
				<tr>
					<td colspan="4" style="width:800px;text-align: right;"> 
						<lable>反馈内容:</lable>
						<textarea id="content" name="content" cols="40" rows="6" readonly="readonly" style="width:395px;"></textarea> 
					</td>
				</tr>
				<tr>
				 	<td colspan="4" style="text-align: right;"> 
						<lable>处理结果:</lable>
						<textarea id="processResult" name="processResult" cols="40" rows="6" style="width:395px;"></textarea> 
					</td>
				 </tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/feedback.js"></script>
</body>
</html>
