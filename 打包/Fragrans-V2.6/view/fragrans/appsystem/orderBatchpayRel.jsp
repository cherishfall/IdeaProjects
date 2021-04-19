<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
   <script type="text/javascript" src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:100px;" title="过滤条件"
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
        	<label class="ui-label">用户账号:</label><input name="userAccount"
				class="easyui-box ui-text" style="width: 100px;">
			<label class="ui-label">交易订单编号:</label><input name="batchpayNo"
				class="easyui-box ui-text" style="width: 180px;">
            <label class="ui-label">订单状态:</label>
            <mytag:dictionary name="isPaid" id="isPaid" codeType="BATCHPAY_ORDER_STATUS"
                              isDefaultLine='1' dataOptions="required:false" />
            <label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
					idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
        </p>
        <p class="ui-fields">
            <label class="ui-label">开始时间:</label><input name="startTime" id="startTime"
                                                        class="easyui-datetimebox" style="width: 180px;">
            <label class="ui-label">结束时间:</label><input name="endTime" id="endTime"
                                                        class="easyui-datetimebox" style="width: 180px;">
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
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/orderBatchpayRel.js"></script>
  </body>
</html>
