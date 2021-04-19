
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp"%>
<link href="assets/plug-in/login/css/zice.style.css" rel="stylesheet"
	type="text/css" />
<link href="assets/plug-in/login/css/buttons.css" rel="stylesheet"
	type="text/css" />
<link href="assets/plug-in/login/css/icon.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="assets/plug-in/login/css/tipsy.css" media="all" />
<script type="text/javascript">
	function userLogin() {

		var param = $('#loginForm').serializeObject();
		console.log(param);
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			url : 'checkuser.do',// 请求的action路径
			data : param,
			error : function() {// 请求失败处理函数
				alert('错误');
			},
			success : function(data) {
				if (data.success) {
					loginsuccess();
					setTimeout("window.location.href='main.action'", 100);
				} else {
					showError(data.msg);
				}
			}
		});
	}
	//显示错误提示
	function showError(str) {
		$('#alertMessage').addClass('error').html(str).stop(true, true).show()
				.animate({
					opacity : 1,
					right : '0'
				}, 500);

	}
	//验证通过加载动画
	function loginsuccess() {
		$("#login").animate({
			opacity : 1,
			top : '49%'
		}, 200, function() {
			$('.userbox').show().animate({
				opacity : 1
			}, 500);
			$("#login").animate({
				opacity : 0,
				top : '60%'
			}, 500, function() {
				$(this).fadeOut(200, function() {
					$(".text_success").slideDown();
					$("#successLogin").animate({
						opacity : 1,
						height : "200px"
					}, 1000);
				});
			});
		});
	}
</script>
</head>
<body style="text-align: center; width: 100%; height: 100%; margin: 0;">
	<div id="alertMessage"></div>
	<div style="margin: 0 auto;">
		<div id="topLogo"
			style="margin: 0 auto; position: absolute; width: 183px; height: 5%;top: 10px;">
			<img src="assets/plug-in/login/spms/top_logo.png" width="160"
				height="42" />
		</div>
		<div id="baseDiv"
			style="text-align: center; position: absolute; width: 100%; height: 80%; top: 50px;">
			<div id="baseBackImg"
				style="text-align: center; margin: 0 auto; width: 100%; height: 80%; background-repeat: no-repeat; background-position: 50%, 50%; background-image: url(assets/plug-in/login/spms/background2.jpg);">
				<div id="loginFormDiv"
					style="position: absolute; width: 520px; height: 309px; left: 50%; top: 50%; background-position: 50%, 50%; background-image: url(assets/plug-in/login/spms/loginBG.png); margin-top: -100px; margin-left: -260px;">
					<div id="sysLogo"
						style="margin: 0 auto; position: absolute; width: 415px; height: 48px; left: 60px;top :5px;">
						<div align="center">
							<img src="assets/plug-in/login/spms/title1.png" width="277"
								height="46" />
						</div>
					</div>
					<form id='loginForm' action="" check="checkuser.do">
						<input type="hidden" name="cityCode" id="cityCode" value="0">
							<div id="userAccount"
								style="margin: 0 auto; position: absolute; width: 326px; height: 43px; z-index: 2; left: 110px; top: 23%; background-color: #FFFFFF; layer-background-color: #FFFFFF; border: 1px none #000000;">
								<form id="loginForm">
									<table width="326" height="45" border="0">
										<tr>
											<td width="63"><div align="center">
													<img src="assets/plug-in/login/spms/user_new.png"
														width="18" height="20" />
												</div></td>
											<td width="253"><input name="account" type="text" class="userName"
												style="width: 260px; height: 30px;" value="admin" /></td>
										</tr>
									</table>
							</div>
							<div id="passWord"
								style="margin: 0 auto; position: absolute; width: 326px; height: 45px; z-index: 5; left: 110px; top: 40%; background-color: #FFFFFF;">
								<table width="100%" height="45" border="0">
									<tr>
										<td width="63">
											<div align="center">
												<img src="assets/plug-in/login/spms/pw_new.png" width="15px"
													height="20" />
											</div>
										</td>
										<td width="253" style="margin-top: 0px;"><input class="password"
											name="password" type="password"
											style="width: 260px; height: 30px;" align="middle"
											value="666666" /></td>
									</tr>
								</table>
							</div>
					</form>
					<div id="buttonLogin"
						style="margin: 0 auto; position: absolute; width: 326px; height: 45px; z-index: 5; left: 110px; top: 62%;">
						<div align="center">
							<img src="assets/plug-in/login/spms/denglu.png" width="326"
								height="45" onclick="userLogin()" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="foot"
			style="margin: 0 auto; position: absolute; width: 100%; height: 15%; top: 85%; background-position: 50%, 50%; background-repeat: no-repeat; background-image: url(assets/plug-in/login/spms/bottom_bg.jpg);">
			<span>浙江创泰科技有限公司</span>
			<!-- 			<img src="assets/plug-in/login/spms/bottom_bg.jpg" style="width: 100%; height: 95%"/> -->
		</div>
	</div>
	<script type="text/javascript"
		src="assets/plug-in/login/js/jquery-jrumble.js"></script>
	<script type="text/javascript"
		src="assets/plug-in/login/js/jquery.tipsy.js"></script>
	<script type="text/javascript"
		src="assets/plug-in/login/js/iphone.check.js"></script>
	<script type="text/javascript" src="assets/plug-in/login/js/login.js"></script>
</body>
</html>
