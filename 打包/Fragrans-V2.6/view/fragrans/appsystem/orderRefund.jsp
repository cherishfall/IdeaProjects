<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:102px;" title="过滤条件"
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 		<label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" style="width:130px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
 	 	    <label class="ui-label">停车记录id:</label><input name="parkrecordId" class="easyui-box ui-text" style="width:100px;"> 
 	 	    <label class="ui-label">订单编号:</label><input name="orderNo" class="easyui-box ui-text" style="width:200px;">
 	 	    <label class="ui-label">用户账号:</label><input name="userAccount" class="easyui-box ui-text" style="width:100px;">
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

     <!-- Edit Form -->
     <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
				   			     	 <tr>
							<td style="text-align: right;"> 停车记录id:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkrecordId" missingMessage="请输入停车记录id"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单编号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderNo" missingMessage="请输入订单编号"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 支付时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="payTime" missingMessage="请输入支付时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 退款编号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="refundNo" missingMessage="请输入退款编号"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 退款金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="refundFee" missingMessage="请输入退款金额"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 退款时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="refundTime" missingMessage="请输入退款时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 操作人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createBy" missingMessage="请输入操作人"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 退款原因:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="reason" missingMessage="请输入退款原因"
			                		    data-options="required:true,validType:'length[1,256]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 退款状态（200成功；500失败）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="isComplate" missingMessage="请输入退款状态（200成功；500失败）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 备注:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="note" missingMessage="请输入备注"
			                		    data-options="required:true,validType:'length[1,256]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div>

	<div id="export-win" class="easyui-dialog" title="导出退款记录"
		 data-options="closed:true,iconCls:'icon-save',modal:true"
		 style="width: 350px; height: 260px;" singleSelect:false>
		<form id="exportForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem" style="position:absolute; top:50px;">
					<div style="padding:5px;">
						<label class="ui-label">城市名称:</label>
						<input id="cityId" name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
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
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/orderRefund.js"></script>
  </body>
</html>
