<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">任务名称:</label><input name="name" class="easyui-box ui-text" style="width:100px;">
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

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'任务信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:600px; height:350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<table cellpadding="5px;">				 
				<tr>				 
					<td style="text-align: right;"> 任务名称（类名）:  </td>
					<td colspan="3"> 
						  <input class="hidden" type="text" name="id" />	
						  <input class="easyui-validatebox" type="text" name="name" missingMessage="请输入任务名称（类名）"
						data-options="required:true,validType:'length[1,30]'" />
	      
					</td>
				</tr>
				 
				<tr>				 
					<td style="text-align: right;">重复执行时间（定时扫描）:</td>
					<td colspan="3"> 
					 <input class="easyui-validatebox" type="text" name="repeatTime" id="repeatTime" missingMessage="请输入重复执行时间（定时扫描）"
						data-options="validType:'length[1,20]'" />    
					</td>
				</tr> 	
				
				<tr>				 
					<td style="text-align: right;">  任务描述:  </td>
					<td colspan="3"> 						
						 <textarea class="easyui-validatebox" rows="3" cols="40"  type="text" name="note" missingMessage="请输入任务描述"
								data-options="required:true,validType:'length[1,20]'"></textarea>
					</td>
				</tr>			
			</table>
		</form>
	</div>
	
	
<!-- 	<div id="edit-win" class="easyui-dialog" title="编辑" -->
<!-- 		data-options="closed:true,iconCls:'icon-save',modal:true" -->
<!-- 		style="width: 400px; height: 300px;"> -->
<!-- 		<form id="editForm" class="ui-form" method="post"> -->
<!-- 			<input class="hidden" type="text" name="id"> -->
<!-- 			<!-- <input class="hidden" name="deleted"> --> -->
<!-- 			<div class="ui-edit"> -->
<!-- 				<div class="ftitle">信息</div> -->
<!-- 				<div class="fitem"> -->
<!-- 					<label>任务名称（类名）:</label> <input class="easyui-validatebox" -->
<!-- 						type="text" name="name" missingMessage="请输入任务名称（类名）" -->
<!-- 						data-options="required:true,validType:'length[1,30]'" /> -->
<!-- 				</div> -->
<!-- 				<div class="fitem"> -->
<!-- 					<label>任务描述:</label> <input class="easyui-validatebox" -->
<!-- 						type="text" name="note" missingMessage="请输入任务描述" -->
<!-- 						data-options="required:true,validType:'length[1,20]'"> -->
<!-- 				</div> -->
<!-- 				<div class="fitem"> -->
<!-- 					<label>重复执行时间（定时扫描）:</label> <input class="easyui-validatebox" -->
<!-- 						type="text" name="repeatTime" id="repeatTime" missingMessage="请输入重复执行时间（定时扫描）" -->
<!-- 						data-options="validType:'length[1,20]'"> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</form> -->
<!-- 	</div> -->
	<div id="excuteRecordDialog" class="easyui-dialog" title="执行记录"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 700px; height: 400px;">
		<table id="excuteRecord"></table>
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/quartz.js"></script>
</body>
</html>
