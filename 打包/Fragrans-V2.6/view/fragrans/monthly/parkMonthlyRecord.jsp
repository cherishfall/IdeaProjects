<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
   <script type="text/javascript" src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:102px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">包月车辆ID:</label>
 	 	   	<input type="text" class="easyui-numberbox" name="monthlyCarId" style="width: 100px;"  data-options="min:0,precision:0">
<!--  	 	   	 <label class="ui-label">父级包月记录ID:</label> -->
<!--  	 	   	<input name="parentId" class="easyui-box ui-text" style="width: 100px;"> -->
 	 	   <label class="ui-label">包月记录ID:</label>
 	 	   	<input type="text" class="easyui-numberbox" name="monthlyId" style="width: 100px;"  data-options="min:0,precision:0">
 	 	   <label class="ui-label">包月手机号:</label>
 	 	   	<input name="phone" class="easyui-box ui-text" style="width: 100px;"> 
 	 	   <label class="ui-label">车牌号码:</label>
 	 	   	<input name="plateNo" class="easyui-box ui-text" style="width: 100px;">  
 	 	   <label class="ui-label">车牌颜色:</label>
 	 	    <mytag:dictionary name="plateColor" id="userPlateColor" codeType="PLATE_COLOR" isDefaultLine='1' dataOptions="required:false" />
 	 	    <label class="ui-label">包月状态:</label>
 	 	    <mytag:dictionary name="status" id="status" codeType="MONTHLY_RECORD_STATUS" isDefaultLine='1' dataOptions="required:false" />    
        </p>
        <p class="ui-fields">
           <label class="ui-label">区域名称:</label>
 	 	   <input name="areaId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
       	   <label class="ui-label">包月开始时间：</label>
	 	   	  <input id="searchStartTime" name="startTime" type="text" class="easyui-datebox" value="" style="width:168px"></input>
	       <label class="ui-label">包月结束时间：</label>
	   	      <input id="searchEndTime" name="endTime" type="text" class="easyui-datebox" value="" style="width:168px"></input>
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
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/monthly/parkMonthlyRecord.js"></script>
  </body>
</html>
