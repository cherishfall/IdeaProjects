<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:132px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
				<label class="ui-label">用户账号:</label><input name="userAccount"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">买家账号:</label><input name="buyerAccount"
					class="easyui-box ui-text" style="width: 130px;">
				<label class="ui-label">交易订单编号:</label><input name="orderNo"
					class="easyui-box ui-text" style="width: 180px;"> 
				<label class="ui-label">通知状态:</label>
				<mytag:dictionary name="notifyStatus" id="notifyStatus" codeType="NOTIFY_STATUS"
					isDefaultLine='1' dataOptions="required:false" />
			</p>
			<p class="ui-fields">
				<label class="ui-label">订单状态:</label>
				<mytag:dictionary name="orderStatus" id="orderStatus" codeType="ORDER_STATUS"
					isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">支付方式:</label>
				<mytag:dictionary name="payment" id="payment" codeType="PAY_METHOD"
					isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">包月记录ID:</label><input name="monthlyId"
					type="text" class="easyui-numberbox" data-options="min:0,precision:0" style="width: 140px;"> 
			</p>
			<p class="ui-fields">
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
     
     <!-- refund -->
	<div id="refund" class="easyui-dialog" title="退款"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 500px; height: 500px;">
		<form id="refundForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">付款日期:</td>
						<td><input class="easyui-validatebox" type="text"
							name="payTime" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">订单编号:</td>
						<td><input class="easyui-validatebox" type="text"
							name="orderNo" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">实付款:</td>
						<td><input class="easyui-validatebox" type="text"
							name="price" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">支付方式:</td>
						<td><input class="easyui-validatebox" type="text"
							name="payType" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款成功金额:</td>
						<td><input class="easyui-validatebox" type="text"
							name="sucRefund" readonly="readonly" style="width:200px;background:#eee;color:blue;font-weight:bold"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款失败金额:</td>
						<td><input class="easyui-validatebox" type="text"
							name="failRefund" readonly="readonly" style="width:200px;background:#eee;color:red;font-weight:bold"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款金额（元）:</td>
					<td><input class="easyui-validatebox" type="text" id="realRefundFee"
						     name="refundFee" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款原因:</td>
					<td colspan="3"><textarea id="reason" name="reason"
					style="height: 100px; width: 350px;" maxlength="100"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
     
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/monthly/orderParkMonthly.js"></script>
  </body>
</html>
