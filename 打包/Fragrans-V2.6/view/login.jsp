
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
	
.login_but {
	border: medium none;cursor: pointer;color:white;font-size: 20px;height: 45px;line-height: 34px;text-align: center;width: 326px;
	background-image: url(assets/plug-in/login/images/login_btn_bg1.png);background-repeat: no-repeat;display: block;
}

.login_but_over {
	border: medium none;color:white;cursor: pointer;font-size: 20px;height: 45px;line-height: 34px;text-align: center;width: 326px;
	background-image: url(assets/plug-in/login/images/login_btn_bg2.png);background-repeat: no-repeat;display: block;
}

#login_but_ing {
	border: medium none;color:white;cursor: pointer;font-size: 20px;height: 45px;line-height: 34px;text-align: center;width: 326px;
	background-image: url(assets/plug-in/login/images/login_btn_bg3.png);background-repeat: no-repeat;display: block;
}

	
	</style>
	
<script type="text/javascript">
	function userLogin() {
		var param = $('#loginForm').serializeObject();
		var account = $("#account").val();
		var password = $("#password").val();
		if(account==null || account.length<1){
			showError('用户名不能为空！');
			$("#account").focus();
			return false;
		}
		if(password==null || password.length<1){
			showError('密码不能为空！');
			$("#password").focus();
			return false;
		}
		$('#login_but').hide();
		$('#login_but_ing').show();
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			url : 'checkuser.do',// 请求的action路径
			data : param,
			error : function() {// 请求失败处理函数
				alert('错误');
				 $('#login_but_ing').hide();
				 $('#login_but').show();
			},
			success : function(data) {
				if (data.success) {
					if(data.toupdatepwd){
						$.messager.alert('', '密码强度不符合，请修改密码','warning', function() {
								setTimeout("window.location.href='toUpdatePwd.action'", 100);
						});
					} else {
						showSuccess('登录成功，正在跳转...');
						setTimeout("window.location.href='main.action'", 100);
					}
					
				} else {
					 $('#login_but_ing').hide();
					 $('#login_but').show();
					showError(data.msg);
				}
			}
		});
	}
	//回车登陆
	$(document).keydown(function(e){
	if(e.keyCode == 13) {
		userLogin();
	}
		});
	//显示错误提示
	function showError(str) {
		$('#alertMessage').removeClass().addClass('error').html(str).stop(true, true).show()
				.animate({
					opacity :'hide',
					right : '0'
				},4000);
	}
	//显示成功提示
	function showSuccess(str) {
		$('#alertMessage').addClass('success').html(str).stop(true, true).show()
				.animate({
					opacity : 'hide',
					right : '0'
				}, 4000);
	}
 
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
				style="text-align: center; margin: 0 auto; width: 100%; height: 80%; background-repeat: no-repeat; background-position: 50%, 50%; background-image: url(assets/plug-in/login/images/background2.jpg);">
				<div id="loginFormDiv"
					style="position: absolute; width: 520px; height: 309px; left: 50%; top: 50%; background-position: 50%, 50%; background-image: url(assets/plug-in/login/images/loginBG.png); margin-top: -100px; margin-left: -260px;">
					<div id="sysLogo"
						style="margin: 0 auto; position: absolute; width: 415px; height: 48px; left: 60px;top :5px;">
						<div align="center">
							<img src="assets/images/logo.png" width="280"
								height="53" />
						</div>
					</div>
					<form id='loginForm' action="" check="checkuser.do">
							<div id="userAccount"
								style="margin: 0 auto; position: absolute; width: 326px; height: 43px; z-index: 2; left: 110px; top: 23%; background-color: #FFFFFF; layer-background-color: #FFFFFF; border: 1px none #000000;">
									<table width="326" height="45" border="0">
										<tr>
											<td width="63"><div align="center">
													<img src="assets/plug-in/login/images/user_new.png"
														width="18" height="20" />
												</div></td>
											<td width="253"><input id="account" name="account" type="text" class="userName"
												style="width: 260px; height: 30px;" value="" /></td>
										</tr>
									</table>
							</div>
							<div id="passWord" style="margin: 0 auto; position: absolute; width: 326px; height: 45px; z-index: 5; left: 110px; top: 40%; background-color: #FFFFFF;">
								<table width="100%" height="45" border="0">
									<tr>
										<td width="63">
											<div align="center">
												<img src="assets/plug-in/login/images/pw_new.png" width="15px"
													height="20" />
											</div>
										</td>
										<td width="253" style="margin-top: 0px;"><input class="password"
											id="password" name="password" type="password"
											style="width: 260px; height: 30px;" align="middle"
											value="" /></td>
									</tr>
								</table>
							</div>
					</form>
					<div id="buttonLogin"
						style="margin: 0 auto; position: absolute; width: 326px; height: 45px; z-index: 5; left: 110px; top: 62%;">
						<div align="center" classs="login_but_cls">
<!-- 							<img src="assets/plug-in/login/images/login_btn.png" width="326" height="45" onclick="userLogin()" /> -->
							
							<input type="button" id="login_but" class="login_but" onmouseout="this.className='login_but'" onmouseover="this.className='login_but_over'"  value="登 录" onclick="userLogin();" /> 
							<input id="login_but_ing" value="正在登录..." style="display:none;" disabled="true" /> 
						
						</div>
						
					</div>
				</div>
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