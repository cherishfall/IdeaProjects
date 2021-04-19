<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<style type="text/css">
	#pic{
		margin:0 auto;
		width:480px;
		padding:0;
		text-align:center;
	}
	#pic img{
		max-width:480px;
		width:expression(document.body.clientWidth>document.getElementById("pic").scrollWidth*9/10? "480px": "auto" );
	}
</style>
 
</head>
<body class="easyui-layout">
	<!-- detail -->
	<div id="detail" title="停车记录详情"
		data-options="closed:true,iconCls:'icon-save',modal:true">
		<form id="detailForm" class="ui-form" method="post">
			<input class="hidden" type="text" id="detailParkrecordId" name="detailParkrecordId" value="<%=request.getParameter("parkrecordId") %>" />
			<input class="hidden" type="text" id="detailCityCode" name="detailCityCode" value="<%=request.getParameter("cityCode") %>" />
			<input class="hidden" type="text" name="id">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">停车点名称：</td>
					<td><p id="parkName" style="width:300px;"></p></td>
					<td style="text-align: right;">停车点类型：</td>
					<td><p id="parkModel" style="width:180px;"></p></td>
				</tr>
				<tr>
					<td style="text-align: right;">泊位编号：</td>
					<td><p id="berthCode" ></p></td>
					<td style="text-align: right;">车牌号：</td>
					<td><p id="plateNo" ></p></td>
				</tr>
				<tr>
					<td style="text-align: right;">停车状态：</td>
					<td><p id="feeState" ></p></td>
					<td style="text-align: right;">停车总费：</td>
					<td><p id="parkFee" ></p></td>
				</tr>
				<tr>
					<td style="text-align: right;">已付费用：</td>
					<td><p id="paidFee" ></p></td>
					<td style="text-align: right;">未付费用：</td>
					<td><p id="unpaidFee" ></p></td>
				</tr>
				<tr>
					<td style="text-align: right;">折扣费用：</td>
					<td><p id="disCountFee" ></p></td>
					<td style="text-align: right;">超缴费用：</td>
					<td><p id="overFlowFee" ></p></td>
				</tr>
				<tr>
					<td style="text-align: right;">是否自动停车：</td>
					<td><p id="isAutoHandle" ></p></td>
					<td style="text-align: right;">停车时长：</td>
					<td><p id="parkLongDesc" ></p></td>
				</tr>
				<tr>
					<td style="text-align: right;">驶入时间：</td>
					<td><p id="arriveTime" ></p></td>
					<td style="text-align: right;">驶离时间：</td>
					<td><p id="departureTime" ></p></td>
				</tr>
			</table>
			<!-- 操作详情 -->
			<table id="handleRecord"></table>
		</form>
	</div>
	
	<!--照片-->
	<div id="photo" class="easyui-dialog" title="照片" 
		data-options="closed:true,iconCls:'ext-icon-picture',modal:true"  
		style="width: 490px; height: 400px;">
		<div id="pic"></div>
	</div>
	
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/parkrecordDetail.js"></script>
</body>
</html>