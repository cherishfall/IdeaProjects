<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
			<label class="ui-label">区域名称:</label><input id="areaCode" name="areaCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
			<label class="ui-label">开始时间:</label>
				 <input id="startDateSel" name="startDate" class="easyui-datebox" data-options="width:150" />
			<label class="ui-label">结束时间:</label>
				 <input id="endDateSel" name="endDate" class="easyui-datebox" data-options="width:150" />
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search" onclick="searchForm()">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
      </form>  
     </div>
     <!--  Search panel end -->
     
	<div data-options="region:'center'" border="false">
			<table id="data-list" ></table>
	</div>
     
     <div id="generateStatDaily" class="easyui-dialog" title="生成日报表"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 240px;" singleSelect:false>
		<form id="generateStatDailyForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem"  style="position:absolute; top:80px;">
					<label>生成日期:</label> 
					<input id="dayTime" name="dayTime" class="easyui-datebox" data-options="width:150" />
				</div>
			</div>
		</form>
	</div>
	
	<div id="repairStatDaily" class="easyui-dialog" title="修复日报表"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 240px;" singleSelect:false>
		<form id="repairStatDailyForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem"  style="position:absolute; top:80px;">
					<label>开始日期:</label> 
					<input id="startTime" name="startTime" class="easyui-datebox" data-options="width:150" />
				</div>
				<div class="fitem"  style="position:absolute; top:110px;">
					<label>结束日期:</label> 
					<input id="endTime" name="endTime" class="easyui-datebox" data-options="width:150" />
				</div>
				<div class="fitem"  style="position:absolute; top:140px;">
					<p style="color: red;">仅做支付宝手续费问题修复</p>
				</div>
			</div>
		</form>
	</div>
	
	<div id="exportStatDaily" class="easyui-dialog" title="导出日报表"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 260px;" singleSelect:false>
		<form id="exportStatDailyForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem" style="position:absolute; top:50px;">
				<div style="padding:5px;">
				<label class="ui-label">城市名称:</label><input id="exp_cityCode" name="cityCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getCity.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
				</div>
				<div style="padding:5px;">
				<label class="ui-label">区域名称:</label><input id="exp_areaCode" name="areaCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getArea.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				</div>
				<div style="padding:5px;">
					<label>开始日期:</label> 
					<input id="startDate" name="startDate" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
					<label>结束日期:</label> 
					<input id="endDate" name="endDate" class="easyui-datebox" data-options="width:150" />
				</div>	
				</div>
			</div>
		</form>
	</div>
	
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/stat/statDaily.js"></script>
	
  
  </body>
</html>
