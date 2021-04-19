<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<%@include file="/view/inc.jsp"%>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/assets/css/smart_wizard.css">
<script type="text/javascript"
	src="<%=basePath%>/assets/js/echarts-2.1.8/build/dist/chart/pie.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="<%=basePath%>/assets/js/echarts-2.1.8/build/dist/chart/funnel.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="<%=basePath%>/assets/js/jquery.smartWizard-2.0.js"></script>

<style type="text/css">
#wizard {
	margin-top: 55px;
}
</style>

</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">日期:</label> <input id="startTime"
					name="startTime" class="easyui-datebox" data-options="width:150" />
				至 <input id="endTime" name="endTime" class="easyui-datebox"
					data-options="width:150" /> <label class="ui-label">版本号:</label><input
					id="appVersion" class="easyui-combobox" name="appVersion"
					panelHeight="100px" /> <a href="javascript:void(0);"
					id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
				<a href="#" id="btn-reset" class="easyui-linkbutton"
					style="margin-top:3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div id="wizard" class="swMain"
		style="margin-left: 10px;margin-top: 70px">
		<ul class="anchor" style="width:1000px;margin-left:180px">
			<li><a class="disabled" href="#step-1" isdone="0" rel="1"> <span
					class="stepDesc"> Step 1 <br>
				</span>
			</a></li>
			<li><a class="disabled" href="#step-2" isdone="0" rel="2"> <span
					class="stepDesc"> Step 2 <br>
				</span>
			</a></li>
			<li><a class="disabled" href="#step-3" isdone="0" rel="3"> <span
					class="stepDesc"> Step 3 <br>
				</span>
			</a></li>
			<li><a class="disabled" href="#step-4" isdone="0" rel="4"> <span
					class="stepDesc"> Step 4 <br>
				</span>
			</a></li>
			<li><a class="disabled" href="#step-5" isdone="0" rel="5"> <span
					class="stepDesc"> Step 5 <br>
				</span>
			</a></li>
			<li><a class="disabled" href="#step-6" isdone="0" rel="6"> <span
					class="stepDesc"> Step 6 <br>
				</span>
			</a></li>
		</ul>
		<div id="container"
			style=" border: 1px solid #A4BED4; width: 160px; height: 360px;overflow: auto;float:left;">
			<ul id="ztree" data-options="animate:true"></ul>
		</div>

		<div class="stepContainer" style="height: 360px;float:left;">
			<div id="step-1" class="content" style="display:none;height: 360px;"></div>
			<div id="step-2" class="content"
				style="display: none;height: 360px;float:left;"></div>
			<div id="step-3" class="content"
				style="display: none;height: 360px;float:left;"></div>
			<div id="step-4" class="content"
				style="display: none;height: 360px;float:left;"></div>
			<div id="step-5" class="content"
				style="display: none;height: 360px;float:left;"></div>
			<div id="step-6" class="content"
				style="display: none;height: 360px;float:left;"></div>
		</div>

	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/appAccessLocus.js"></script>
</body>
</html>
