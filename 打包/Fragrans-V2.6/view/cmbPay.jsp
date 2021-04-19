
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style> 
td{width:380px;}
td input{width:350px;}
</style>
<script type="text/javascript">
	 
 
</script>
<!--
测试联调环境支付命令格式如下</td><td>
http://61.144.248.29:801/netpayment/BaseHttp.dll?PrePayEUserP?BranchID=xxxx&CoNo=xxxxxx&BillNo=xxxxxx&Amount=xxxx.xx&Date=YYYYMMDD&ExpireTimeSpan=xx&MerchantUrl=xxxxxx&MerchantPara=xxxxxx&MerchantCode=xx&MerchantRetUrl=xxxxxx&MerchantRetPara=xxxxxx

参数名称	可空	参数说明
BranchID	N	支付商户开户分行号，4位，请咨询开户的招商银行分支机构；

CoNo	N	支付商户号，6位长数字，由银行在商户开户时确定；//收单商户号

BillNo	N	定单号，6位或10位长数字，由商户系统生成，一天内不能重复；

Amount	N	定单总金额，格式为</td><td>xxxx.xx元；

ExpireTimeSpan	Y	必须为大于零的整数，单位为分钟。该请求参数为可选参数，如果请求中不包含该参数，则默认为会话有效时间（目前是30分钟）(如果客户在商户端对同一笔订单重新发起支付请求，则以商户在后一次发起时指定的参数为准。)该参数指定当前支付请求必须在指定时间跨度内完成，否则按过期处理。该参数适用于航空客票等对交易完成时间敏感的支付请求；

MerchantUrl	N	支付结果通知命令中参数之前的部分，长度不能超过128个字节。例如</td><td> www.merchant.com/path/WAPProcResult.dll
注意</td><td>MerchantUrl自身不能带商户参数,且不可带“-”符号，否则收不到支付结果通知。
测试环境下url中不可带域名。

MerchantPara	Y	商户需要银行在支付结果通知中转发的商户参数；
注意</td><td>MerchantPara参数可为空，商户如果需要不止一个参数，可以自行把参数组合、拼装，但组合后的结果不能带有’&’字符，总长不能超过128个字节。例如</td><td>

MerchantPara=Ref1=12345678|Ref2=ABCDEFG|Ref3=HIJKLM

MerchantCode	N	详见“商户校验码.doc”说明。商户校验码文档</td><td>
注意以下为协议相关的字段</td><td>

PNo: 客户协议号。字符串，不超过30位。未签约客户，填写新增的协议号，用于协议开通；签约客户，填写客户协议号。非空。

TS</td><td>交易日期+时间，格式为YYYYMMDDHHMMSS。非空。

MchNo: 协议商户企业编号。由银行在商户开户时确定。非空。
以下字段开通协议时需填写</td><td>

Seq</td><td>协议开通请求流水号。字符串，不超过20位。协议开通时非空。

MUID</td><td>协议用户ID。字符串，不超过20位。

Mobile</td><td>协议手机号。11位数字。

URL:协议开通结果通知命令中参数之前的部分。参数规则同支付结果通知命令。字符串，长度不超过100位。协议开通时非空。

Para</td><td>商户需要银行在协议开通结果通知中转发的商户参数，参数规则同支付结果通知命令。字符串，长度不超过128位。

LBS:地理位置。格式为“经度|纬度”，经纬度两个参数之间用竖线分开。例如</td><td>18.23445|46.000033。可以填空。

RskLvl</td><td>客户风险等级。保留字段。填写商户端客户的风险等级，可以为空

MerchantRetUrl	N	支付完成后5秒后页面将自动跳转到MerchantRetUrl与MerchantRetPara所指定的地址。
例如</td><td>
MerchantRetUrl = http://www.merchant.com/path/BacktoMerchant.aspx 

MerchantRetPara = Para1=abc|Para2=123
则，点击“返回按钮”，客户浏览器将跳转到</td><td>
http://www.merchant.com/path/BacktoMerchant.aspx?Para1=abc|Para2=123 
注意</td><td>MerchantRetPara参数可为空，商户如果需要不止一个参数，可以自行把参数组合、拼装，但组合后的结果不能带有’&’字符，总长不能超过128个字节

MerchantRetPara	Y	详见MerchantRetUrl中的说明
 --> 
 
</head>
<body style="text-align: right; width: 100%; height: 100%; margin: 0;">
	 <form method="post" action="http://61.144.248.29:801/netpayment/BaseHttp.dll?PrePayEUserP" name="submitForm">
		<table>
		<!-- 支付商户开户分行号 -->
		<tr><td>支付商户开户分行号 </td><td> <input type="text" name="BranchID" id="BranchID" value="${strBranchID}" /></td></td>
		<!-- 支付商户号 -->
		<tr><td>支付商户号</td><td><input type="text" name="CoNo" id="CoNo" value="${strCono}" /></td></td>
		<!-- 定单号 -->
		<tr><td>定单号</td><td><input type="text" name="BillNo"  id="BillNo" value="${strBillNo}" /></td></td>
		<!-- 定单总金额 -->
		<tr><td>定单总金额</td><td><input type="text" name="Amount" id="Amount" value="${strAmount}" /></td></td>
		<!-- 定单日期 -->
		<tr><td>定单日期</td><td><input type="text" name="Date" id="Date" value="${strDate}" /></td></td>
		 <!-- 可选</td><td>会话有效时间（目前是30分钟） -->
		<tr><td>可选:会话有效时间（默认是30分钟）</td><td><input type="text" name="ExpireTimeSpan" id="ExpireTimeSpan" value="${ExpireTimeSpan}" /></td></td>
		<!-- 支付结果通知URL -->
		<tr><td>支付结果通知URL</td><td><input type="text" name="MerchantUrl" id="MerchantUrl" value="${strMerchantUrl}" /></td></td>
		<!-- 可选</td><td>转发的商户参数 -->
		<tr><td>可选:转发的商户参数</td><td><input type="text" name="MerchantPara" id="MerchantPara" value="${strMerchantPara}" /></td></td>
		<!-- 商户校验码 -->
		<tr><td>商户校验码</td><td><textarea rows="6" cols="40" name="MerchantCode" id="MerchantCode" >${MerchantCode}</textarea> </td></td>
		<!-- 自动回调跳转地址 -->
		<tr><td>自动回调跳转地址</td><td><input type="text" name="MerchantRetUrl" id="MerchantRetUrl" value="${MerchantRetUrl}" /></td></td>
		<!-- 可选</td><td>自动回调参数 -->
		<tr><td>可选:自动回调参数 </td><td><input type="text" name="MerchantRetPara" id="MerchantRetPara" value="${MerchantRetPara}" /></td></td>
	 
	 	<tr><td colspan="2"><input type="submit" value="提交支付" /></td></td> 
	 	</table>
	 </form>
</body>
</html>