<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<%@include file="/view/inc.jsp" %>
</head>
<body class="easyui-layout">
<!-- Search panel start -->
<div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件"
	 data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >
	<form id="searchForm">
		<p class="ui-fields">
			<label class="ui-label">手机号码:</label><input name="userAccount" class="easyui-box ui-text" style="width:100px;">
			<label class="ui-label">车牌号:</label><input name="plateNo" class="easyui-box ui-text" style="width:100px;">
			<label class="ui-label">车牌颜色:</label><mytag:dictionary id="plateColorSel" name="plateColor" codeType="PLATE_COLOR" isDefaultLine="1" dataOptions="required:false"/>
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
<div id="edit-win" class="easyui-dialog" title="修改电子标签编号" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:350px;height:300px;">
	<form id="editForm" class="ui-form" method="post">
		<input class="hidden" type="text" name="id" id="id">
		<input class="hidden" type="text" name="userId" id="userId">

		<table cellpadding="10px;">
			<tr>
				<td style="text-align: right;">手机号码:</td>
				<td>
					<p id="userAccount"></p>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">车牌号:</td>
				<td>
					<p id="plateNoEdit"></p>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">车牌颜色:</td>
				<td>
					<p id="plateColorEdit"></p>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;"> 电子标签编号:</td>
				<td>
					<input class="easyui-validatebox" type="text" id="electTagNoEdit" name="electTagNo" missingMessage="请输入电子标签编号"
						   data-options="required:true,validType:'length[1,36]'" style="width: 170px;height:30px;"/>
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="processAutoPayDiv" class="easyui-dialog" data-options="draggable:true,title:'开通代扣',iconCls:'icon-save',closed:true,modal:true "
	 style="width: 400px; height: 350px; padding: 10px;">
	<form id="processAutoPayForm" class="ui-form" method="post" style="width: 340px; height: 120px;">
		<table cellpadding="5px 0;" style="padding-top: 20px;">
			<tr>
				<td style="text-align: right;">选择城市：</td>
				<td>
					<input id="cityCode" name="cityCode" class="easyui-combotree"
						   data-options="url:'${pageContext.request.contextPath}/area/getOnlineAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true" style="width: 170px;height:30px;"/>
					<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						 onclick="$('#cityCode').combotree('clear');" />
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">手机号码：</td>
				<td>
					<input class="easyui-validatebox" type="text"
						   name="phone" id="phone" data-options="required:true,validType:'mobile'" placeholder="请输入手机号码"
						   style="width: 170px;height:30px;"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">车牌号：</td>
				<td>
					<input class="easyui-validatebox" type="text"
						   name="plateNo" id="plateNo" data-options="required:true,validType:'plateNo'" placeholder="请输入车牌号"
						   style="width: 170px;height:30px;"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">车牌颜色：</td>
				<td>
					<mytag:dictionary id="plateColor" name="plateColor" codeType="PLATE_COLOR" style="width: 170px;height:30px;"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">电子标签编号：</td>
				<td>
					<input class="easyui-validatebox" type="text"
						   name="electTagNo" id="electTagNo" data-options="required:true" placeholder="请输入电子标签编号"
						   style="width: 170px;height:30px;"/>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- js -->
<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/membercard/memberCardAutoPay.js"></script>
</body>
</html>
