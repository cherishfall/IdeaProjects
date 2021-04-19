<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<!-- <div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">信息名称:</label><input name="codeName" class="easyui-box ui-text" style="width:100px;">
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div> -->
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="编辑"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 550px; height: 250px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">消息分类名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="messageTopicName" missingMessage="请输入消息分类名称"
						data-options="required:true,validType:'length[1,64]'" /></td>
					<td style="text-align: right;">所在城市:</td>
					<td><input id="cityCode" name="cityCodeArr" 
						class="easyui-combobox"
						data-options="fit : true,required:false,editable:false" style="width:150px"/>
				</tr>
				<tr>
					<td style="text-align: right;">消息分类类型:</td>
						<td><mytag:dictionary name="topicType" id="topicType" codeType="TOPIC_TYPE"/>	
					<td style="text-align: right;">显示策略:</td>
					<td><mytag:dictionary name="displayconf" id="displayconf" codeType="DISPLAYCONF"/>
				</tr>
				<tr>
					<td style="text-align: right;">是否通用:</td>
					<td><mytag:dictionary name="isCommon" id="isCommon" codeType="YESORNO"/>
					<td style="text-align: right;">排序号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="orderNum" missingMessage="请输入排序号"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/messageTopic.js"></script>
</body>
</html>
