<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:110px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">账单日期:</label> <input id="statDate" name="statDate" class="easyui-datebox" data-options="width:150" />
 	 	   <label class="ui-label">订单类型:</label><mytag:dictionary codeType="ORDER_TYPE" id="orderType" isDefaultLine="1" name="orderType" dataOptions="required:false"/>
 	 	   <label class="ui-label">是否平账:</label>
			<input id="exceptionType" name="exceptionType" class="easyui-combobox" data-options="textField:  'label',valueField: 'value',data: [{label: '否',value: '1',selected:true},{label: '是',value: '0'},{label: '==全部==',value: ''}]" />
 	 	   <label class="ui-label">异常类型:</label><mytag:dictionary codeType="ERROR_TYPE" id="errorType" isDefaultLine="1" name="errorType" dataOptions="required:false"/>
 	 	   <label class="ui-label">订单编号:</label><input name="orderNo" class="easyui-box ui-text" style="width:100px;">
        </p>
        <p class="ui-fields">
 	 	   <label class="ui-label">停车点类型:</label><mytag:dictionary codeType="PARK_MODEL" id="parkType" name="parkType" isDefaultLine="1" dataOptions="required:false"/>
 	 	   <label class="ui-label">是否白名单:</label><mytag:dictionary codeType="IS_WHITE" id="isWhite" isDefaultLine="1" name="isWhite" dataOptions="required:false"/>
 	 	   <label class="ui-label">区域名称:</label><input name="cityId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
 	 	   <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
        </p>
      </form>  
     </div> 
     <!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

  	 <div id="exportOrderSpmsList" class="easyui-dialog" title="导出账单"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 200px;" singleSelect:false>
		<form id="exportOrderSpmsListForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
					<label>开始日期:</label> 
					<input id="startDate" name="startDate" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
					<label>结束日期:</label> 
					<input id="endDate" name="endDate" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
				<label class="ui-label">城市名称:</label>
					<input id="cityId" name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
				</div>
				</div>
			</div>
		</form>
	</div>
	
  	 <div id="orderSpmsList" class="easyui-dialog" title="账单比对"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 150px;" singleSelect:false>
		<form id="orderSpmsListForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
					<label>账单日期:</label> 
					<input id="statdate" name="statDate" class="easyui-datebox" data-options="width:150" />
				</div>
				</div>
			</div>
		</form>
	</div>
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/fanc/fancOrderSpms.js"></script>
  </body>
</html>
