<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- paylog -->
	<div id="paylog" title="支付明细"
		data-options="closed:true,iconCls:'icon-save',modal:true,maximizable:true"
		style="width: 860px; height: 260px;">
		<form id="paylogForm" class="ui-form" method="post">
		<input class="hidden" type="text" id="orderNo" name="orderNo" value="<%=request.getParameter("orderNo") %>" />
		<table cellpadding="5px;" style="margin:10px 0px 0px 40px">
			<tr>
				<td style="text-align: right;">总停车费用：</td>
				<td><p id="parkFee" style="width:300px;"></p></td>
				<td style="text-align: right;">是否有活动：</td>
				<td><p id="isActivity" style="width:180px;"></p></td>
			</tr>
			<tr>
				<td style="text-align: right;">优惠类型：</td>
				<td><p id="activityType" ></p></td>
				<td style="text-align: right;">活动名称：</td>
				<td><p id="activityName" ></p></td>
			</tr>
			<tr>
				<td style="text-align: right;">优惠券：</td>
				<td><p id="ticketName" ></p></td>
				<td style="text-align: right;">优惠券编号：</td>
				<td><p id="ticketNo" ></p></td>
			</tr>
			<tr>
				<td style="text-align: right;">券面额：</td>
				<td><p id="ticketMoney" ></p></td>
				<td style="text-align: right;">折扣比例：</td>
				<td><p id="ticketDiscount" ></p></td>
			</tr>
			<tr>
				<td style="text-align: right;">支付方式折扣比例：</td>
				<td><p id="paymentDiscount" ></p></td>
				<td style="text-align: right;">红包实际抵扣金额：</td>
				<td><p id="redboxFee" ></p></td>
			</tr>
			<tr>
				<td style="text-align: right;">券实际抵扣金额：</td>
				<td><p id="ticketFee" ></p></td>
				<td style="text-align: right;">折扣实际抵扣金额：</td>
				<td><p id="discountFee" ></p></td>
			</tr>
			<tr>
				<td style="text-align: right;">第三方实际支付金额：</td>
				<td><p id="payFee" ></p></td>
				<td style="text-align: right;">是否支付成功：</td>
				<td><p id="isPaid" ></p></td>
			</tr>
			<tr>
				<td style="text-align: right;">批量缴费订单编号：</td>
				<td><p id="batchpayNo" ></p></td>
				<td style="text-align: right;">会员卡优惠金额：</td>
				<td><p id="memberCardFee" ></p></td>
			</tr>
		</table>
		</form>
	</div>	
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/orderDetail.js"></script>
</body>
</html>