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
				<label class="ui-label">用户账号:</label><input name="userAccount"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">买家账号:</label><input name="buyerAccount"
					class="easyui-box ui-text" style="width: 130px;">
				<label class="ui-label">充值订单编号:</label><input name="orderNo"
					class="easyui-box ui-text" style="width: 180px;">
				<label class="ui-label">充值卡号:</label><input name="rechargeCardNo"
					type="text" class="easyui-box ui-text" data-options="min:0,precision:0" style="width: 140px;"> 
				<label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/> 
			</p>
			<p class="ui-fields">
				<label class="ui-label">订单状态:</label>
					<mytag:dictionary name="orderStatus" id="orderStatus" codeType="ORDER_STATUS"
						isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">支付方式:</label>
					<mytag:dictionary name="payType" id="payment" codeType="MEMBER_RECHARGE_TYPE"
						isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">开始时间:</label>
				<input name="startTime" id="searchStartTime" class="easyui-datetimebox" style="width: 180px;"> 
				<label class="ui-label">结束时间:</label>
				<input name="endTime" id="searchEndTime" class="easyui-datetimebox" style="width: 180px;"> 
				<a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a> 
				<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
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
							<td style="text-align: right;"> 城市代码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="cityCode" missingMessage="请输入城市代码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 区级代码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="areaCode" missingMessage="请输入区级代码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 用户ID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="userId" missingMessage="请输入用户ID"
			                		    data-options="required:true,validType:'length[1,36]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 用户账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="userAccount" missingMessage="请输入用户账号"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 充值订单编号(唯一):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderNo" missingMessage="请输入充值订单编号(唯一)"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 充值卡编码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="rechargeCardNo" missingMessage="请输入充值卡编码"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 招行订单编号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="billNo" missingMessage="请输入招行订单编号"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 支付方式；1 支付宝 2 微信 5一网通 17 充值卡:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="payType" missingMessage="请输入支付方式；1 支付宝 2 微信 5一网通 17 充值卡"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 充值金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="price" missingMessage="请输入充值金额"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 手续费:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="counterFee" missingMessage="请输入手续费"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单标题:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="subject" missingMessage="请输入订单标题"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单描述:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderBody" missingMessage="请输入订单描述"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单状态码(200支付成功;100未支付;400订单作废):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderStatus" missingMessage="请输入订单状态码(200支付成功;100未支付;400订单作废)"
			                		    data-options="required:true,validType:'length[1,10]'" />
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
							<td style="text-align: right;"> 买家账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="buyerAccount" missingMessage="请输入买家账号"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 操作标示 ADD：增加 UPDATE:修改 DELETE:删除:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="flag" missingMessage="请输入操作标示 ADD：增加 UPDATE:修改 DELETE:删除"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createdBy" missingMessage="请输入创建人"
			                		    data-options="required:true,validType:'length[1,36]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 修改人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updatedBy" missingMessage="请输入修改人"
			                		    data-options="required:true,validType:'length[1,36]'" />
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
							<td style="text-align: right;"> 更新时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updateTime" missingMessage="请输入更新时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/membercard/memberCardOrder.js"></script>
  </body>
</html>
