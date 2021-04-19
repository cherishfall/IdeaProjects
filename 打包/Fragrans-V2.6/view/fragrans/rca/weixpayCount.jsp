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
							<td style="text-align: right;"> 账单日期(YYYY-MM-DD):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="statdate" missingMessage="请输入账单日期(YYYY-MM-DD)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 总交易单数，支付宝原始账单数量:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="totalOrderCount" missingMessage="请输入总交易单数，支付宝原始账单数量"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 总交易额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="totalIncomeCount" missingMessage="请输入总交易额"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 总退款金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="totalOutcomeCount" missingMessage="请输入总退款金额"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 总企业红包退款金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="totalTradeRefundBmAmount" missingMessage="请输入总企业红包退款金额"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 手续费总金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="totalServiceFee" missingMessage="请输入手续费总金额"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/rca/weixpayCount.js"></script>
  </body>
</html>
