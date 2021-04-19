
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> 好停车管理平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp"%>
<link href="assets/plug-in/login/css/zice.style.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="assets/plug-in/login/css/tipsy.css" media="all" />
	<style>
input[type=password] {
	background-position: 100% 50%;
}	
.yes_but {
	border: medium none;cursor: pointer;color:white;font-size: 20px;height: 40px;line-height: 34px;text-align: center;width: 140px;
	background-image: url(assets/plug-in/login/images/yes_btn.png);background-repeat: no-repeat;display: block;
}
.reset_but {
	border: medium none;cursor: pointer;color:white;font-size: 20px;height: 40px;line-height: 34px;text-align: center;width: 140px;
	background-image: url(assets/plug-in/login/images/reset_btn.png);background-repeat: no-repeat;display: block;
}
tr{height:32px;pading:10 10 10 10 }
/*密码强度*/
.pw-strength {clear: both;position: relative;top: 8px;width: 180px;}
.pw-bar{background: url(assets/plug-in/login/images/pwd-1.png) no-repeat;height: 14px;overflow: hidden;width: 179px;}
.pw-bar-on{background:  url(assets/plug-in/login/images/pwd-2.png) no-repeat; width:0px; height:14px;position: absolute;top: 1px;left: 2px;transition: width .5s ease-in;-moz-transition: width .5s ease-in;-webkit-transition: width .5s ease-in;-o-transition: width .5s ease-in;}
.pw-weak .pw-defule{ width:0px;}
.pw-weak .pw-bar-on {width: 60px;}
.pw-medium .pw-bar-on {width: 120px;}
.pw-strong .pw-bar-on {width: 179px;}
.pw-txt {padding-top: 2px;width: 180px;overflow: hidden;}
.pw-txt span {color: #707070;float: left;font-size: 12px;text-align: center;width: 58px;}
	</style>
	
<script type="text/javascript">
	var pwdStrong = 0;
	function modifyPwd() {
		var oldpwd = $("#oldpwd").val();
		var newpwd = $("#newpwd").val();
		var yespwd = $("#yespwd").val();
		if(oldpwd==null || oldpwd.length<1){
			showError('原始密码不能为空！');
			$("#oldpwd").focus();
			return false;
		}
		if(newpwd==null || newpwd.length<1){
			showError('新密码不能为空！');
			$("#newpwd").focus();
			return false;
		}
		if(yespwd==null || yespwd!=newpwd){
			showError('两次输入密码不一致！');
			$("#yespwd").focus();
			return false;
		}
		var minPwdStrong = '${minPwdStrong }';
		if(pwdStrong < minPwdStrong){
			showError('密码过于简单，请重新输入！');
			$("#newpwd").focus();
			return false;
		}
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			url : 'modifyPwd.do',// 请求的action路径
			data : {
				'account':'${account }',
				'oldPwd':oldpwd,
				'newPwd':newpwd,
				'pwdStrong':pwdStrong
			},
			error : function() {// 请求失败处理函数
				alert('错误');
			},
			success : function(data) {
				$("#login_but").disabled = 'disabled';
				if (data.success) {
					showSuccess('密码修改成功，请重新登录，正在跳转...');
					setTimeout("window.location.href='login.action'", 3000);
				} else {
					showError(data.msg);
				}
			}
		});
	}
	
	function reset(){
		$("input[type=password]").attr("value","");
	}
	//回车登陆
	$(document).keydown(function(e){
	if(e.keyCode == 13) {
		toModifyPwd();
	}
		});
	//显示错误提示
	function showError(str) {
		$('#alertMessage').removeClass().addClass('error').html(str).stop(true, true).show()
				.animate({
					opacity :'hide',
					right : '0'
				},5000);
	}
	//显示成功提示
	function showSuccess(str) {
		$('#alertMessage').addClass('success').html(str).stop(true, true).show()
				.animate({
					opacity : 'hide',
					right : '0'
				}, 4000);
	}
	$(function(){ 
	$('#newpwd').keyup(function () { 
		var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
		var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
		var enoughRegex = new RegExp("(?=.{6,}).*", "g"); 
	
		if (false == enoughRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass(' pw-defule'); 
			pwdStrong = 1;
			 //密码小于六位的时候，密码强度图片都为灰色 
		} 
		else if (strongRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass(' pw-strong'); 
			pwdStrong = 3;
			 //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
		} 
		else if (mediumRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass(' pw-medium'); 
			pwdStrong = 2;
			 //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
		} 
		else { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-weak'); 
			pwdStrong = 1;
			 //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
		} 
		return true; 
	}); 
})
</script>
</head>
<body style="text-align: center; width: 100%; height: 100%; margin: 0;">
	<div id="alertMessage"></div>
	<div style="margin: 0 auto;">
		 
		<div id="topLogo" style="margin: 0 auto; position: absolute; width: 183px; height: 5%;top: 10px;">
		    <img width="160" height="42" src="assets/plug-in/login/images/top_logo.png"></img>
		</div>
		
		<div id="baseDiv"
			style="text-align: center; position: absolute; width: 100%; height: 80%; top: 50px;">
			<div id="baseBackImg"
				style="text-align: center; margin: 0 auto; width: 100%; height: 80%; background-repeat: no-repeat; background-position: 50%, 50%; ">
				<div id="loginFormDiv"
					style="position: absolute; width: 660px; height: 290px; left: 45%; top: 45%; background-position: 50%, 50%; background-image: url(assets/plug-in/login/images/modifyPwd.png); margin-top: -100px; margin-left: -260px;">
					<div id="sysLogo"
						style="margin: 0 auto; position: absolute; width: 415px; height: 48px; left: 60px;top :5px;">
					</div>
					<form id='loginForm' action="" check="checkuser.do">
							<div id="passWord" style="margin: 0 auto; position: absolute;-moz-border-radius: 15px; -webkit-border-radius: 15px; border-radius:15px;  
							width: 500px; height:240px; z-index: 5; left:60px; top: 10%; background-color: #FFFFFF;">
								<table width="100%" height="160" border="0">
									<tr>
										<td width="63">
											<div align="right" style="font: normal;font-size: 12px;color: gray;">
												登录账号：
											</div>
										</td>
										<td width="253" style="margin-top: 0px;" align="center">
										${account}</td>
									</tr>
									<tr>
										<td width="63">
											<div align="right" style="font: normal;font-size: 12px;color: gray;">
												原始密码：
											</div>
										</td>
										<td width="253" style="margin-top: 0px;"><input class="easyui-validatebox"
											id="oldpwd" name="oldpwd" type="password" data-options="required:true"
											style="width: 260px; height: 30px;" align="middle" /></td>
									</tr>
									<tr>
										<td width="63">
											<div align="right" style="font: normal;font-size: 12px;color: gray;">
												新密码：
											</div>
										</td>
										<td width="253" style="margin-top: 0px;"><input class="easyui-validatebox"
											id="newpwd" name="newpwd" type="password" data-options="required:true"
											style="width: 260px; height: 30px;" align="middle" /></td>
									</tr>
									<tr>
										<td width="63" style="font: normal;font-size: 12px;color: gray;">
											<div align="right">
												确认密码：
											</div>
										</td>
										<td width="253" style="margin-top: 0px;"><input class="easyui-validatebox"
											id="yespwd" name="yespwd" type="password" data-options="required:true"
											style="width: 260px; height: 30px;" align="middle" validType="same['newpwd']"/></td>
									</tr>
									<tr>    
									<td width="63" style="font: normal;font-size: 12px;color: gray;">
										<div align="right">
											密码强度：
										</div>
									</td>    
									<td id="level" class="pw-strength">           	
										<div class="pw-bar"></div>
										<div class="pw-bar-on"></div>
										<div class="pw-txt">
										<span>弱</span>
										<span>中</span>
										<span>强</span>
										</div>
									</td>	
								</tr>
								</table>
							</div>
							<div id="buttonYes"
								style="margin: 0 auto; position: absolute; width: 150px; height: 45px; z-index: 5; left: 130px; top:76%;">
								<div align="center" classs="login_but_cls">
									<input type="button" id="login_but" class="yes_but" onclick="modifyPwd();" /> 
								</div>
							</div>
							<div id="buttonReset"
								style="margin: 0 auto; position: absolute; width: 150px; height: 45px; z-index: 5; left: 300px; top: 76%;">
								<div align="center" classs="login_but_cls">
									<input type="button" id="login_but" class="reset_but" onclick="reset();" /> 
								</div>
							</div>
							
					</form>
				</div>
			</div>
			
			<div style="margin: 0 auto; position: absolute; width: 80%; height: 45px; z-index: 5; left: 80px; top: 89%;" align="center">
				<label style="font: normal;font-size: 12px;color: gray;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提示：6位及以下的密码，强度为弱； 6位以上并且字母、数字、特殊字符三项中有两项的密码，强度为中；八位及以上并且字包含大小写字母、数字、特殊字符四项的密码,强度为强
				</label> 
			</div>
							
		</div>
		
		<div id="foot"
			style="margin: 0 auto; position: absolute; width: 100%;  top: 95%; background-position: 50%, 50%; ">
			<span> Copyright © 2015 浙江创泰科技有限公司 All Rights Reserved </span>
		</div>
	</div>
	<script type="text/javascript"
		src="assets/plug-in/login/js/jquery-jrumble.js"></script>
	<script type="text/javascript"
		src="assets/plug-in/login/js/jquery.tipsy.js"></script>
	<script type="text/javascript"
		src="assets/plug-in/login/js/iphone.check.js"></script>
</body>
</html>