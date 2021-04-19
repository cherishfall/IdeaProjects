<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.innotek.common.util.UtilDate"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="ui-search-panel" region="north" style="height: 80px;" title="过滤条件" data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">应用编号:</label><input name="appId" class="easyui-box ui-text" style="width:100px;">
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
      </form>  
     </div> 
     <!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

     <!-- Edit Form -->
     <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:500px;height:350px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		 <div class="ui-edit">
	     	   <div class="ftitle">信息</div> 
	   	       <div class="fitem">  
               <label>应用编号:</label>  
               <input class="easyui-validatebox" type="text" name="appId" readonly="readonly"
                    missingMessage="请输入应用编号"  value="<%=UtilDate.getAppId()%>"
	                data-options="required:true,validType:'length[1,50]'">
	           </div> 
	   	       <div class="fitem">  
               <label>应用密钥值:</label>  
               <input class="easyui-validatebox" type="text" name="appKey" 
                     missingMessage="请输入应用密钥值"  value="<%=UtilDate.getAppKey()%>"
	                data-options="required:true,validType:'length[1,64]'">
	           </div> 
	   	       <div class="fitem">  
               <label>应用名称:</label>  
               <input class="easyui-validatebox" type="text" name="appName" missingMessage="请输入应用名称"
	                data-options="required:true,validType:'length[1,50]'">
	           </div> 
	   	       <div class="fitem">  
               <label>应用描述:</label>  
               <input class="easyui-validatebox" type="text" name="appDesc" missingMessage="请输入应用描述"
	                data-options="required:true,validType:'length[1,200]'">
	           </div> 
	   	        <div class="fitem">  
	               <label>状态:</label>
	               <mytag:dictionary codeType="STATE" id="state" name="state"/>  
	           </div>  
	            </div>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/sys/appkey.js"></script>
  </body>
</html>
