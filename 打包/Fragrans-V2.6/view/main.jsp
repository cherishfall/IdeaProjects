<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>中国好停车客户端应用管理平台</title>
<%@include file="inc.jsp"%>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/assets/css/main.css">
<script type="text/javascript"
	src="<%=basePath%>/assets/js/business/main.js"></script>
<style>
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
</head>
<body class="easyui-layout">
	<div
		data-options="region:'north',href:'<%=basePath%>/view/layout/north.jsp'"
		style="height: 60px; overflow: hidden;"></div>
	<!-- 树形菜单 -->
	<div data-options="region:'west',split:true,title:'功能导航'"
		style="width: 200px;">
<%-- 			<jsp:include page="layout/west.jsp"></jsp:include> --%>
		<div id="tree-box" class="easyui-accordion"
			data-options="fit:true,border:false">
			<c:forEach var="node" items="${menuList}">
				<div title="${node.text}"  data-options="iconCls:'${node.iconCls}'">
					<ul id="tt" class="easyui-tree" >
						<c:forEach var="modules" items="${node.children}">
						    <c:if test="${!empty modules.children}">
						       <li data-options="iconCls:'${modules.iconCls}'"><span>${modules.text}</span>
								<ul>
									<c:forEach var="module" items="${modules.children}">
										<li  data-options="iconCls:'${module.iconCls}'">
											<a class="menu-item"
											href="<%=basePath%>${module.url}">${module.text}</a>
										</li>
									</c:forEach>
								</ul>
							  </li>
						    </c:if>
						    <c:if test="${empty modules.children}">
						       <li data-options="iconCls:'${modules.iconCls}'"><span><a class="menu-item"
										href="<%=basePath%>${modules.url}">${modules.text}</a></span>
							  </li>
						    </c:if>
						</c:forEach>
					</ul>
				</div>
			</c:forEach>
		</div>
	</div>
	<div
		data-options="region:'south',href:'<%=basePath%>/view/layout/south.jsp'"
		style="height: 27px; overflow: hidden;"></div>
	 <!-- 中间内容页面 -->
	<div data-options="region:'center'">
		<jsp:include page="layout/center.jsp"></jsp:include>
	</div>

	<div id="passwordDialog" title="修改密码" class="easyui-dialog"
		data-options="closed:true" style="width: 350px; height: 200px;">
		<form id="passwordForm">
			<div class="ui-edit">
				<div class="fitem">
					<label>原始密码:</label> <input class="easyui-validatebox"
						type="password" name="oldPwd" missingMessage="请输入原始密码"
						data-options="required:true">
				</div>
				<div class="fitem">
					<label>新密码:</label> <input id="pwd" class="easyui-validatebox"
						type="password" name="newPwd" missingMessage="请输入新密码"
						data-options="required:true">
				</div>
				<div class="fitem">
					<label>密码确认:</label> <input class="easyui-validatebox"
						type="password" missingMessage="请确认新密码"
						data-options="required:true" validType="same['pwd']">
				</div>
				<div class="fitem">
					<input type="hidden" name="pwdStrong" id="pwdStrong" />
					<div id="level" class="pw-strength" style="left: 80px;">
					<div class="pw-bar"></div>
					<div class="pw-bar-on"></div>
					<div class="pw-txt">
					<span>弱</span>
					<span>中</span>
					<span>强</span>
					</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div id="userInfo" title="用户信息" class="easyui-dialog"
		data-options="closed:true" style="width: 400px; height: 400px;">
		<form id="userInfoForm">
			<table align="center">
				<tr>
					<td>账户：</td>
					<td><input name="account" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input name="password" type="password" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>真实姓名：</td>
					<td><input name="name" type="text" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>别名：</td>
					<td><input name="nickname" type="text" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><mytag:dictionary codeType="GENDER" id="gender" name="gender" isDisabled="true" dataOptions="required:false"/>
					</td>
				</tr>
				<tr>
					<td>电话：</td>
					<td><input name="phone" type="text" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>邮箱：</td>
					<td><input name="email" type="text" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>创建人：</td>
					<td><input name="creator" type="text" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>创建时间：</td>
					<td><input name="createTime" type="text" readonly="readonly" /></td>
				</tr>
				<tr>
					<td>是否是超级管理员：</td>
					<td><select class="easyui-combobox" name="superAdmin" data-options="disabled:true"
						style="width: 140px;">
							<option value="0">否</option>
							<option value="1">是</option>
					</select></td>
				</tr>
				<tr>
					<td>登录次数：</td>
					<td><input name="loginCount" type="text" readonly="readonly" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="lockDialog" class="easyui-dialog" title="系统已锁定"
		style="width: 400px; height: 200px;"
		data-options="closed:true,closable:false,resizable:false,modal:true">
		<form id="lockForm">
		    <input name="cityCode" id="cityCode" value="${session_user.cityCode}" class="hidden" />
			<table align="center">
				<tr>
					<td colspan="2"><div class="loginlogo">
							<img src="assets/images/top_logo.png" />
						</div></td>
				</tr>
				<tr>
					<td>用户：</td>
					<td><input name="account" value="${session_user.account}"
						readonly="readonly" /></td>
				</tr>
				<tr>
					<td>密码：</td>
					<td><input type="password" name="password" /></td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>
