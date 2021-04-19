<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				 <label class="ui-label">卖家收款账号:</label><input name="sellerAccount" class="easyui-box ui-text" style="width:100px;">
				 <label class="ui-label">支付方式:</label><mytag:dictionary codeType="PAY_ACCOUNT_TYPE" id="payment" name="payment" isDefaultLine='1' dataOptions="required:false"/>
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="商户支付信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 600px; height: 520px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">商户编号:</td>
					<td><input class="easyui-combobox" type="text" id="providerNo"
						name="providerNo" missingMessage="请输入商户编号"
						data-options="required:true,validType:'length[1,36]'" style="width:160px;"/></td>
					<td style="text-align: right;">商户号:</td>
					<td><input class="easyui-validatebox" type="text" name="appid"
						missingMessage="请输入商户号"
						data-options="required:true,validType:'length[1,64]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">支付宝appid:</td>
					<td><input class="easyui-validatebox" type="text" name="applyid"
							   missingMessage="请输入支付宝appid"
							   data-options="required:true,validType:'length[1,64]'" /></td>
					<td style="text-align: right;">支付方式:</td>
					<td><mytag:dictionary name="payment" id="payment"
							codeType="PAY_ACCOUNT_TYPE" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">卖家收款账号:</td>
					<td><input class="easyui-validatebox" type="text"
							   name="sellerAccount"
							   missingMessage="请输入卖家收款账号(支付宝：Seller_email，微信：mch_id)"
							   data-options="required:true,validType:'length[1,64]'" /></td>
					<td style="text-align: right;">是否启用:</td>
					<td><mytag:dictionary name="isUsed" id="isUsed" codeType="YESORNO"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">接入有效期:</td>
					<td><input class="easyui-datetimebox" type="text"
							   name="validityDate"
							   data-options="required:false,editable:false" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">通知地址:</td>
					<td colspan="3"><textarea name="notifyUrl" id="notifyUrl" 
						style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
				</tr>
				<tr>
					<td style="text-align: right;">商户秘钥:</td>
					<td colspan="3"><textarea name="providerKey" id="providerKey"
						style="height: 50px; width: 390px;" maxlength="512"></textarea></td>
				</tr>
				<tr>
					<td style="text-align: right;">支付宝商户公钥:</td>
					<td colspan="3"><textarea name="alipayPublic" id="alipayPublic"
						style="height: 80px; width: 390px;" maxlength="1000"></textarea></td>
				</tr>
				<tr>
					<td style="text-align: right;">支付宝商户私钥:</td>
					<td colspan="3"><textarea name="alipayPrivate" id="alipayPrivate" 
						style="height: 80px; width: 390px;" maxlength="2048"></textarea></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/provider/providerConnect.js"></script>
</body>
</html>
