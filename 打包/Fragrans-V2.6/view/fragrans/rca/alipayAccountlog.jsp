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
 	 	   <label class="ui-label">商户订单号:</label>
		   <input class="easyui-validatebox" type="text" name="merchantOutOrderNo" style="width:200px;"/>
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
							<td style="text-align: right;"> 余额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="balance" missingMessage="请输入余额"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 收入金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="income" missingMessage="请输入收入金额"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 支出金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="outcome" missingMessage="请输入支出金额"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单付款时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="transDate" missingMessage="请输入订单付款时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 子业务类型:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="subTransCodeMsg" missingMessage="请输入子业务类型"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 业务类型:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="transCodeMsg" missingMessage="请输入业务类型"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 商户订单号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="merchantOutOrderNo" missingMessage="请输入商户订单号"
			                		    data-options="required:true,validType:'length[1,30]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="transOutOrderNo" missingMessage="请输入订单号"
			                		    data-options="required:true,validType:'length[1,30]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 银行名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="bankName" missingMessage="请输入银行名称"
			                		    data-options="required:true,validType:'length[1,40]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 银行账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="bankAccountNo" missingMessage="请输入银行账号"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 银行账户名字:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="bankAccountName" missingMessage="请输入银行账户名字"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 备注:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="memo" missingMessage="请输入备注"
			                		    data-options="required:true,validType:'length[1,200]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 买家支付宝人民币资金账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="buyerAccount" missingMessage="请输入买家支付宝人民币资金账号"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 卖家支付宝人民币资金账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="sellerAccount" missingMessage="请输入卖家支付宝人民币资金账号"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 卖家姓名:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="sellerFullname" missingMessage="请输入卖家姓名"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 货币代码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="currency" missingMessage="请输入货币代码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 充值流水号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="depositBankNo" missingMessage="请输入充值流水号"
			                		    data-options="required:true,validType:'length[1,40]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 商品名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="goodsTitle" missingMessage="请输入商品名称"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 账务序列号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="iwAccountLogId" missingMessage="请输入账务序列号"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 账务本方支付宝人民币资金账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="transAccount" missingMessage="请输入账务本方支付宝人民币资金账号"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 账务对方邮箱:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="otherAccountEmail" missingMessage="请输入账务对方邮箱"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 账务对方全称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="otherAccountFullname" missingMessage="请输入账务对方全称"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 账务对方支付宝用户号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="otherUserId" missingMessage="请输入账务对方支付宝用户号"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 合作者身份ID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="partnerId" missingMessage="请输入合作者身份ID"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易服务费:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="serviceFee" missingMessage="请输入交易服务费"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易服务费率:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="serviceFeeRatio" missingMessage="请输入交易服务费率"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易总金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="totalFee" missingMessage="请输入交易总金额"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 支付宝交易号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="tradeNo" missingMessage="请输入支付宝交易号"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 累积退款金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="tradeRefundAmount" missingMessage="请输入累积退款金额"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 签约产品，如：高级即时到账:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="signProductName" missingMessage="请输入签约产品，如：高级即时到账"
			                		    data-options="required:true,validType:'length[1,50]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 费率:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="rate" missingMessage="请输入费率"
			                		    data-options="required:true,validType:'length[1,50]'" />
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
  	 
  	 <div id="exportAliPayList" class="easyui-dialog" title="导出记录"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 260px;" singleSelect:false>
		<form id="exportAliPayListForm" class="ui-form" method="post">
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
				</div>
			</div>
		</form>
	</div>
	
	<div id="orderAliPayList" class="easyui-dialog" title="获取账单"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 150px;" singleSelect:false>
		<form id="orderAliPayListForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
					<label>账单日期:</label> 
					<input id="statdate" name="statdate" class="easyui-datebox" data-options="width:150" />
				</div>
				</div>
			</div>
		</form>
	</div>
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/rca/alipayAccountlog.js"></script>
  </body>
</html>
