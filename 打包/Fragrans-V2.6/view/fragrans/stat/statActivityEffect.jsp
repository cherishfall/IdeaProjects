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
			<label class="ui-label">区域名称:</label><input id="areaCode" name="areaCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
			<label class="ui-label">开始时间:</label>
				 <input id="startDate" name="startDate" class="easyui-datebox" data-options="width:150" />
			<label class="ui-label">结束时间:</label>
				 <input id="endDate" name="endDate" class="easyui-datebox" data-options="width:150" />
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search" onclick="searchForm()">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
      </form>  
     </div> 
     <!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

	 <div id="generateActivityEffect" class="easyui-dialog" title="生成活动效果统计报表"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 240px;" singleSelect:false>
		<form id="generateActivityEffectForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem" style="position: relative;top: 40px;">
					<label>生成日期:</label> &nbsp;
					<input id="dayTime" name="dayTime" class="easyui-datebox" data-options="width:150" />
				</div>
				<div class="fitem" style="position: relative;top: 55px;">
					<label class="ui-label">活动主题:</label>
					<input id="activityTopicId" name="activityTopicId" class="easyui-combotree ui-text" style="width:150px;" data-options="required:true" />
				</div>
			</div>
		</form>
	</div>
	
	<div id="exportActivityEffect" class="easyui-dialog" title="导出活动效果统计报表"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 260px;" singleSelect:false>
		<form id="exportActivityEffectForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
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
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/stat/statActivityEffect.js"></script>
  </body>
</html>
