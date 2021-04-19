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
			<label class="ui-label">账单日期:</label>
				 <input id="statdate" name="statdate" class="easyui-datebox" data-options="width:150" />
 	 	   <label class="ui-label">支付方式:</label><mytag:dictionary name="payType" id="payType" codeType="payType" isDefaultLine="1" dataOptions="required:false"/>
 	 	   <label class="ui-label">交易订单编号:</label><input name="orderNo" class="easyui-box ui-text" style="width:200px;">
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

  	 <div id="exportOrderMiddlewareList" class="easyui-dialog" title="导出账单"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 200px;" singleSelect:false>
		<form id="exportOrderMiddlewareListForm" class="ui-form" method="post">
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
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/swap/orderMiddleware.js"></script>
  </body>
</html>
