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
				<label class="ui-label">任务编号:</label><input name="quartzId" class="easyui-box ui-text" style="width:100px;" />
				<label class="ui-label">执行结果:</label> <mytag:dictionary dataOptions="required:false" codeType="JOB_RESULT" id="result" name="result"/>  
				<label class="ui-label">执行时间:</label>
				 <input id="startExecuteTime" name="startExecuteTime" class="easyui-datebox" style="width:100px;" /> 至 
	 	 	     <input id="endExecuteTime" name="endExecuteTime" class="easyui-datebox" style="width:100px;" />
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
	
	<div id="missionDetailWin" ></div>

	 
	<div id="excuteRecordDialog" class="easyui-dialog" title="执行记录"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 700px; height: 400px;">
		<table id="excuteRecord"></table>
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/quartzDetail.js"></script>
</body>
</html>
