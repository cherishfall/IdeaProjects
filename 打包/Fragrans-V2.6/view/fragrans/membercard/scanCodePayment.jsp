<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<%@include file="/view/inc.jsp"%>
	<style type="text/css">
		.ts_mask{ width:100%;height:100%; background:rgba(0,0,0,0.7); position:absolute; z-index:99; top:0px;}
		.codeDiv{
			text-align: center;
			position: relative;
			top: 12%;
		}
		#code{
			margin-bottom:30px;
		}
		.title{
			font-size: 15px;
			color:#D8D8D8;
		}
		.desc{
			font-size: 15px;
			color: #00ee00;
			letter-spacing:2px;
		}
		.panel-tool{
			display: none;
		}
		.sucTips {
			margin-top: 45px;
			font-size:18px;
			text-align: center;
		}
		#sucAmount{
			font-size:18px;
			font-weight: bold;
		}
	</style>
</head>
<body class="easyui-layout">
	<div class="ts_mask">
		<div id="rechargeInfoDiv" class="easyui-dialog" data-options="draggable:true,title:'会员卡充值',iconCls:'icon-save',closed:true,modal:true "
			style="width: 400px; height: 350px; padding: 10px;">
				<form id="rechargeForm" class="ui-form" method="post" style="width: 340px; height: 120px;">
					<table cellpadding="15px 0;" style="padding-top: 20px;">
						<tr>
							<td style="text-align: right;">手机号码：</td>
							<td>
								<input class="easyui-validatebox" type="text"
									   name="phone" id="phone" data-options="required:true,validType:'mobile'" placeholder="请输入手机号码"
									   style="width: 170px;height:30px;"/>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;">手机号码确认：</td>
							<td>
								<input class="easyui-validatebox" type="text" data-options="required:true"
									   id="phoneSure" validType="sameMobile['phone']" placeholder="请确认手机号码"
									   style="width: 170px;height:30px;" onpaste="return false;"/>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;">充值金额：</td>
							<td>
								<input class="easyui-numberbox" type="text"
									   id="price" name="price" data-options="required:true,precision:2" placeholder="请输入充值金额(单位：元)"
									   style="width: 170px;height:30px;"/>
							</td>
						</tr>
					</table>
				</form>
		</div>

		<div class="codeDiv">
			<p class="title">支付宝二维码扫码充值</p>
			<div id="code"></div>
			<p class="title">手机号码 ： <span id="phoneDesc" class="desc"></span></p>
			<p class="title">充值金额 ： <span id="priceDesc" class="desc"></span></p>
			<button onclick="reset();">关闭</button>
		</div>
	</div>

	<div id="successDiv" class="easyui-dialog" data-options="draggable:true,title:'温馨提示',iconCls:'icon-save',closed:true,modal:true "
		 style="width: 400px; height: 250px; padding: 10px;">
		<div class="sucTips">
			<img src="<%=basePath%>/assets/images/pay_suc.jpg" style="width: 70px;vertical-align: middle;">
			充值成功！充值金额为 <span id="sucAmount"></span> 元
		</div>
	</div>
<!-- js -->
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/membercard/scanCodePayment.js"></script>
</body>
</html>
