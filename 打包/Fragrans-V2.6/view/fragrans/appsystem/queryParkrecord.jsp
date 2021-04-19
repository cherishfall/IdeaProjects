<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript"
	src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">车牌号（必填）:</label><input name="plateNo" class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">车牌颜色（必填，默认：蓝牌）:</label><mytag:dictionary name="plateColor" id="plateColor" codeType="PLATE_COLOR" dataOptions="required:false" defaultValue="0"/>
				<label class="ui-label">页码（必填）:</label><input name="pageIndex" id="pageIndex" class="easyui-validatebox easyui-numberspinner" data-options="min:1,max:100" style="width: 100px;" value="1"/>
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="searchClear();" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/queryParkrecord.js"></script>
</body>
</html>
