<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@page import="com.innotek.system.util.SessionUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript" charset="utf-8">
	function logoutFun(b) {
		window.location = basePath + "/logout.action";
	}
	$(function() {
		$('#currentCity').combobox(
			{
				url : basePath +'/tag/getCtiyItems.do',
				valueField : 'cityCode',
				textField : 'cityName',
				onSelect : function(record) {
					if (record) {
						$.ajax({
							url : basePath +'/changeCity.do',
							type : 'post',
							data : {
								cityCode : record.cityCode
							},
							success : function(result) {
								if (result.success) {
									window.location = basePath + "/main.action";
								}
							}
						});
					}
				},
				onLoadSuccess:function(){
<%-- 					$('#currentCity').combobox('setValue', '<%=SessionUtils.getCityName(request)%>');   --%>
					$('#currentCity').combobox('setValue', '002');  
				}
			});
		
	});
</script>
<div>
	<img
		src="<%=request.getContextPath()%>/assets/images/logo.png">
</div>
<div id="sessionInfoDiv" style="position: absolute; right: 5px; top: 10px;">
	<c:if test="${session_user != null}">
<%-- 	  <c:if test="${session_user.superAdmin == 1}"> --%>
<!-- 	       切换城市&nbsp;<input id="currentCity" class="easyui-combobox" name="currentCity" panelHeight="auto" style="width:70px;" /> -->
<%-- 	  </c:if> --%>
	   &nbsp;&nbsp; 欢迎 <span class="orange">${session_user.nickname}</span> 第[<span class="orange">${session_user.loginCount}</span>]次登录
	 </c:if>
	<fmt:formatDate value="<%=new Date()%>" pattern="yyyy-MM-dd EEEE" />
</div>
<div style="position: absolute; right: 0px; bottom: 0px; border: 0px">
	<a href="javascript:void(0);" class="easyui-menubutton"
		style="border: 0px"
		data-options="menu:'#layout_north_pfMenu',iconCls:'ext-icon-rainbow'">更换皮肤</a>
	<a href="javascript:void(0);" class="easyui-menubutton"
		data-options="menu:'#layout_north_kzmbMenu',iconCls:'ext-icon-cog'">控制面板</a>
	<a href="javascript:void(0);" class="easyui-menubutton"
		data-options="menu:'#layout_north_zxMenu',iconCls:'ext-icon-disconnect'">注销</a>
</div>
<div id="layout_north_pfMenu" style="width: 120px; display: none;">
	<div onclick="sy.changeTheme('default');" title="default"
		style="border: 0px">default</div>
	<div onclick="sy.changeTheme('gray');" title="gray" style="border: 0px">gray</div>
	<div onclick="sy.changeTheme('metro');" title="metro"
		style="border: 0px">metro</div>
	<div onclick="sy.changeTheme('bootstrap');" title="bootstrap"
		style="border: 0px">bootstrap</div>
	<div onclick="sy.changeTheme('black');" title="black"
		style="border: 0px">black</div>
</div>
<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-user_edit'"
		onclick="$('#passwordDialog').dialog('open');$('#passwordForm').form('reset');" style="border: 0px">修改密码</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-user'" onclick="showMyInfoFun();"
		style="border: 0px">我的信息</div>
</div>
<div id="layout_north_zxMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-lock'" onclick="lockWindowFun();"
		style="border: 0px">锁定窗口</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-door_out'" onclick="logoutFun();"
		style="border: 0px">退出系统</div>
</div>