<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.innotek.common.util.UtilDate"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript">
	$(function() {
		$('#tt').tabs({
			tabPosition : 'left'
		});
	});
</script>
</head>
<body class="easyui-layout">
	<div id="tt" class="easyui-tabs">
		<div title="诱导同步管理">
			<div region="center" border="false" style="height: 517px">
				<table id="data-list"></table>
			</div>
		</div>
		<div title="无流量数据同步">
			<!-- Search panel start -->
			<div class="datagrid-toolbar" region="north" style="height: 42px;"
				title="过滤条件"
				data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false">
				<form id="searchForm">
					<p class="ui-fields">
						<label class="ui-label">区域：</label><input name="areaCode"
							class="easyui-combotree ui-text" style="width: 150px;"
							data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
						<label class="ui-label">停车点名称：</label><input name="name"
							class="easyui-box ui-text" style="width: 100px;"> <label
							class="ui-label">类型：</label>
						<mytag:dictionary codeType="PARK_MODEL" id="parkType"
							name="parkType" isDefaultLine='1' dataOptions="required:false"
							style="width:120px;" />
					</p>
					<a href="#" style="margin-top: 3px;" class="easyui-linkbutton"
						iconCls="icon-search" onclick="searchForm();">搜索</a> <a href="#"
						class="easyui-linkbutton"
						onclick="$('#searchForm').form('clear');" style="margin-top: 3px;"
						iconCls="ext-icon-application_reset">重置</a>
				</form>
			</div>
			<!--  Search panel end -->
			<div class="datagrid-toolbar" region="center" border="false"
				style="height: 475px">
				<table id="data-list1"></table>
			</div>
		</div>
		<div title="流量延迟推送">
			<!-- Search panel start -->
			<div class="datagrid-toolbar" region="north" style="height: 42px;"
				title="过滤条件"
				data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false">
				<form id="delaySearchForm">
					<p class="ui-fields">
						<label class="ui-label">区域：</label><input name="areaCode"
							class="easyui-combotree ui-text" style="width: 150px;"
							data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
						<label class="ui-label">停车点名称：</label><input name="name"
							class="easyui-box ui-text" style="width: 100px;"> <label
							class="ui-label">类型：</label>
						<mytag:dictionary codeType="PARK_MODEL" id="delayParkType"
							name="parkType" isDefaultLine='1' dataOptions="required:false"
							style="width:120px;" />
					</p>
					<a href="#" style="margin-top: 3px;" class="easyui-linkbutton"
						iconCls="icon-search" onclick="delaySearchForm();">搜索</a> <a
						href="#" class="easyui-linkbutton"
						onclick="$('#delaySearchForm').form('clear');"
						style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
				</form>
			</div>
			<!--  Search panel end -->
			<div region="center" border="false" style="height: 475px">
				<table id="data-list2"></table>
			</div>
		</div>
		<div title="诱导同步延迟">
			<div region="center" border="false" style="height: 517px">
				<table id="data-list3"></table>
			</div>
		</div>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="编辑"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 540px; height: 340px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">应用ID:</td>
					<td colspan="2"><input class="easyui-validatebox" type="text" name="appId" readonly="readonly"
                    	missingMessage="请输入应用编号"
	                	data-options="required:true,validType:'length[1,50]'" style="width:150px;background-color:#eeeeee;"></td>
				</tr>
				<tr>
					<td style="text-align: right;">应用密钥值:</td>
					<td colspan="2"><input class="easyui-validatebox" type="text" name="appKey" readonly="readonly"
					missingMessage="请输入应用密钥值"
	                data-options="required:true,validType:'length[1,64]'" style="width:260px;background-color:#eeeeee;"></td>
				</tr>
				<tr>
					<td style="text-align: right;">区域编码:</td>
					<td><input class="easyui-combotree"
						id="areaCode" name="areaCode" missingMessage="请选择区域" 
						data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true"/>
						<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#areaCode').combotree('clear');"/></td>
					<td style="text-align: right;">区域名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="areaName" missingMessage="请输入区域名称"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">应用名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="appName" missingMessage="请输入应用名称"
						data-options="required:true,validType:'length[1,32]'" /></td>
					<td style="text-align: right;">有效期:</td>
					<td><input class="easyui-datebox" type="text"
						name="expiredTime" missingMessage="请输入有效期"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">应用状态:</td>
					<td><mytag:dictionary codeType="SYNC_STATE" id="appStatus" name="appStatus"/>  
					</td>
					<td style="text-align: right;">
						允许授权连接的IP:</td>
					<td><input class="easyui-validatebox" type="text"
						name="authIp" missingMessage="请输入允许授权连接的IP，多个IP逗号分隔(0.0.0.0表示不限制)"
						data-options="required:true,validType:'length[1,255]'" /></td>
				</tr>
					<td style="text-align: right;">应用描述:</td>
					<td colspan="3">
					<textarea name="appDesc" style="width:400px;height:50px;" maxlength="225"></textarea></td>
				<tr>
				</tr> 
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/inductionDataWarning.js"></script>
</body>
</html>
