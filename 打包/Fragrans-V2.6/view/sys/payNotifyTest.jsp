<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout" style="overflow-y: scroll;">
		<form id="editForm" class="ui-form" method="post">
			<div class="pageFormContent">
				<table cellpadding="5px;" style="width:700px;">
					<tr>
						<td style="text-align: right;">买家账号：</td>
						<td colspan="2">
						<input class="easyui-validatebox" id="buyerAccount" name="buyerAccount" type="text"
						style="width:300px;" missingMessage="该项为必输项" data-options="required:true"/>
	 					</td>
	 				</tr>
	 				
	 				<tr>
						<td style="text-align: right;">订单编号：</td>
						<td colspan="2">
						<input class="easyui-validatebox" id="orderNo" name="orderNo" type="text"
						style="width:300px;" missingMessage="该项为必输项" data-options="required:true"/>
	 					</td>
	 				</tr>
	 				
	 				<tr>
						<td style="text-align: right;">支付方式：</td>
						<td colspan="2">
						<mytag:dictionary name="payMent" id="payMent" codeType="PAY_METHOD" style="width:300px;"/>
	 					</td>
	 				</tr>
	 				
	 				<tr>
						<td style="text-align: right;">支付时间：</td>
						<td colspan="2">
						<input class="easyui-datetimebox" id="payTime" name="payTime" type="text"
						style="width:300px;" missingMessage="该项为必输项" data-options="required:true"/>
	 					</td>
	 				</tr>
	 				
					<tr>
						<td style="text-align: right;">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'"   
       						 onclick="sendNotify(this);">发送通知</a>
       					</td>
       					<td style="text-align: right;width:0px;">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'" 
							onclick="$(editForm).form('reset');">重置</a>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<script>
		</script>
		<!-- js -->
		<script type="text/javascript"
			src="<%=basePath%>/assets/js/business/sys/payNotifyTest.js"></script>
</body>
</html>
