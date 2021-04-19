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
 	 	   <!-- <label class="ui-label">信息名称:</label><input name="codeName" class="easyui-box ui-text" style="width:100px;"> -->
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
     <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
				   			     	 <tr>
							<td style="text-align: right;"> 停车支付记录ID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkingRecordId" missingMessage="请输入停车支付记录ID"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 用户ID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="userId" missingMessage="请输入用户ID"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 是否支付 1：未支付 2：支付过 3：已结清:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="isPaid" missingMessage="请输入是否支付 1：未支付 2：支付过 3：已结清"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createdBy" missingMessage="请输入创建人"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 修改人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updatedBy" missingMessage="请输入修改人"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 更新时间,默认SYSDATE:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updateTime" missingMessage="请输入更新时间,默认SYSDATE"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/pay/userParkingRecord.js"></script>
  </body>
</html>
