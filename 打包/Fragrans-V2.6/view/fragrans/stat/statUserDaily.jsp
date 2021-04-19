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
 	 	   <label class="ui-label">查询日期:</label>
				 <input id="dayTimeStart" name="dayTimeStart" class="easyui-datebox" data-options="width:150" /> 至
				 <input id="dayTimeEnd" name="dayTimeEnd" class="easyui-datebox" data-options="width:150" />
			<label class="ui-label">区域名称:</label><input name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
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

	<div id="exportStatUserDailyList" class="easyui-dialog" title="汇总导出"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 200px;" singleSelect:false>
		<form id="exportStatUserDailyListForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
					<label>开始日期:</label> 
					<input id="dayTimeStart" name="dayTimeStart" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
					<label>结束日期:</label> 
					<input id="dayTimeEnd" name="dayTimeEnd" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
				<label class="ui-label">导出城市:</label>
					<input id="cityId" name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
				</div>
				</div>
			</div>
		</form>
	</div>
	
  	 <div id="statUserDailyList" class="easyui-dialog" title="汇总生成"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 150px;" singleSelect:false>
		<form id="statUserDailyListForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
					<label>汇总日期:</label> 
					<input id="dayTime" name="dayTime" class="easyui-datebox" data-options="width:150" />
				</div>
				</div>
			</div>
		</form>
	</div>  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/stat/statUserDaily.js"></script>
  </body>
</html>
