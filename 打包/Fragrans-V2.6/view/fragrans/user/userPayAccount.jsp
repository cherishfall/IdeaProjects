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
 	 	    <label class="ui-label">支付账号:</label><input name="payAccount" class="easyui-box ui-text" style="width:100px;">
 	 	    <label class="ui-label">支付账号类型:</label><mytag:dictionary codeType="PAY_ACCOUNT_TYPE" id="payAccountType" name="payAccountType"
													isDefaultLine='1' dataOptions="required:false" /> 
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

     <!-- Edit Form -->
     <div id="edit-win" class="easyui-dialog" title="用户支付信息" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		<table cellpadding="5px;">	
				   		<tr>
							<td style="text-align: right;"> 支付账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="payAccount" missingMessage="请输入支付账号"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   		<tr>
							<td style="text-align: right;"> 支付账号类型:</td>
							<td> 
								 <mytag:dictionary codeType="PAY_ACCOUNT_TYPE" id="payAccountType" name="payAccountType"/> 
							</td>					 
						</tr>
			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/user/userPayAccount.js"></script>
  </body>
</html>
