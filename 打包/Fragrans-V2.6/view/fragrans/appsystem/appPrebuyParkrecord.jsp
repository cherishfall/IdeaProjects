<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
<link rel="stylesheet" href="<%=basePath%>/assets/css/showPhoto/style.css">
<style type="text/css">
#pic {
	margin: 0 auto;
	width: 500px;
	padding: 0;
	text-align: center;
}

#pic img {
	max-width: 500px;
	width: expression(document.body.clientWidth > document.getElementById ("pic").scrollWidth*9/10? "500px": "auto");
}
#picture {
	margin: 0 auto;
	width: 500px;
	padding: 0;
	text-align: center;
}

#picture img {
	max-width: 500px;
	width: expression(document.body.clientWidth > document.getElementById ("picture").scrollWidth*9/10? "500px": "auto");
}
</style>

</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 100px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">区域名称:</label><input name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">停车点名称:</label><input name="parkName"
					class="easyui-box ui-text" style="width: 150px;">
				<label class="ui-label">车牌号:</label><input name="plateNo"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">停车记录id:</label><input name="parkrecordId"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">预买状态:</label><mytag:dictionary name="status" id="status" codeType="PREBUY_STATUS" isDefaultLine="1" dataOptions="required:false"/>
			</p>
			<p class="ui-fields">
			<label class="ui-label">是否驶离:</label><mytag:dictionary name="isDeparture" id="isDeparture" codeType="YESORNO" isDefaultLine="1" dataOptions="required:false"/>
				<label class="ui-label">开始时间:</label><input name="startTime" id="startTime"
					class="easyui-datetimebox" style="width: 180px;"> 
				<label class="ui-label">结束时间:</label><input name="endTime" id="endTime"
					class="easyui-datetimebox" style="width: 180px;"> 
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
	
	<!-- detail -->
	<div id="parkrecordDetail" class="easyui-dialog" title="停车记录详情"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 800px; height: 400px;">
	</div>
	
	<!--照片-->
	 <div id="photoDiv" class="easyui-dialog" title="照片(点击箭头切换)" data-options="closed:true" style="top:30px;height:450px;">
        <a class="control prev"></a><a class="control next abs"></a><!--自定义按钮，移动端可不写-->
        <div id="picture" class="slider" style="width: 500px; height:470px;"><!--主体结构，请用此类名调用插件，此类名可自定义-->
            <ul id="ulClass"></ul>
        </div>
    </div>
	
	<!-- 订单详情 -->
	<div id="prebuyOrderDetail" class="easyui-dialog" title="订单明细"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 900px; height: 300px;">
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/appPrebuyParkrecord.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/YuxiSlider.jQuery.min.js"></script>
</body>
</html>
