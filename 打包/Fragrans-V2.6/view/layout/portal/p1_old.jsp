<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp"%>
<html>
<head>
<title></title>
</head>
<body>
	<div class="easyui-panel" style="border-style: none;overflow-y:none;width: 1154px;" id = "tabs">
	<div style="float:left;font-weight:bold;margin: 30px 0 0 10px;" id = "today">今天</div>
		<div data-options="title:'今天',iconCls:'iconImg ext-icon-report'"
			align="left" style="float:left;margin: 40px 0 0 10px; border-style:none;" >
			<form id="propertyForm1">
				<table>
					<tr>
						<td>总停车点数</td>
						<td><input type="text" disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="totalParkNumber"></td>
						<td>总泊位数</td>
						<td><input type="text" disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="totalBerthNumber"></td>
					</tr>
					<tr>
						<td>总成功缴费次数</td>
						<td><input type="text" disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="totalSuccessPayTimes"></td>
						<td>缴费总金额</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="totalSuccessPayFee"></td>
					</tr>
					<tr>
						<td>支付宝支付笔数</td>
						<td><input type="text" disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;"  name="alipayOrderPayCount"></td>
						<td>微信支付笔数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="wxpayOrderPayCount"></td>
					</tr>
					<tr>
						<td>支付宝支付金额</td>
						<td><input type="text" disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="alipayOrderPayAmount"></td>
						<td>微信支付金额</td>
						<td><input type="text" disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="wxpayOrderPayAmount"></td>
					</tr>
					<tr>
						<td>今日注册用户数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="registerUserCount"></td>
						<td>今日缴费用户数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="payOrderUserCount"></td>
					</tr>
					<tr>
						<td>订单投诉个数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="orderComplainCount"></td>
						<td>上线城市个数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="onlineCityCount"></td>
					</tr>
				</table>
			</form>
		</div>
	<div style="float:left;font-weight:bold;margin: 30px 0 0 10px;" id = "yesterday">昨天</div>
		<div data-options="title:'昨天',iconCls:'iconImg ext-icon-report'"
			align="left" style="float:left;margin: 40px 0 0 10px;border-style:none;" >
			<form id="propertyForm2">
				<table>
					<tr>
						<td>总停车点数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="totalParkNumber"></td>
						<td>总泊位数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="totalBerthNumber"></td>
					</tr>
					<tr>
						<td>总成功缴费次数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="totalSuccessPayTimes"></td>
						<td>缴费总金额</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="totalSuccessPayFee"></td>
					</tr>
					<tr>
						<td>支付宝支付笔数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="alipayOrderPayCount"></td>
						<td>微信支付笔数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="wxpayOrderPayCount"></td>
					</tr>
					<tr>
						<td>支付宝支付金额</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="alipayOrderPayAmount"></td>
						<td>微信支付金额</td>
						<td><input type="text" disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="wxpayOrderPayAmount"></td>
					</tr>
					<tr>
						<td>今日注册用户数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="registerUserCount"></td>
						<td>今日缴费用户数</td>
						<td><input type="text" disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="payOrderUserCount"></td>
					</tr>
					<tr>
						<td>订单投诉个数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="orderComplainCount"></td>
						<td>上线城市个数</td>
						<td><input type="text"  disabled="disabled" style="background-color:white;font-size:14px;color:#000;text-align:center;border:0px;" name="onlineCityCount"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			var table1  = document.getElementById('tabs');
			table1.style.borderBottomColor = 'transparent';
			//当天
			requestData('propertyForm1',
					'${pageContext.request.contextPath}/homeStat/refreshData.do');
			//昨天
			requestData('propertyForm2',
					'${pageContext.request.contextPath}/homeStat/refreshYesterdayData.do');
		})

		function requestData(form, requestUrl) {
			var formid = '#' + form;
			$.ajax({
				url : requestUrl,
				type : 'get',
				success : function(result) {
					$(formid).form('load', result);
				}
			})
		}
	</script>
</body>
</html>
