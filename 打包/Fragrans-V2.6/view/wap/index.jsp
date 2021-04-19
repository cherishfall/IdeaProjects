<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@include file="inc.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工程调试</title>
<SCRIPT type="text/javascript">
	function setCityCode(){
		var cityCode = document.getElementById("cityCode");
		cityCode.value = document.getElementById("cityList").value;
	}
	
	function requestForward(param){
		var cityCode = document.getElementById("cityCode");
		
		var form = document.getElementById("requestForm");
		form.action = "<%=basePath%>/wap/check" + param + "Param.do";
		form.submit();
	}
</SCRIPT>
</head>
<body align="center">
	<h1><FONT size="35">工程调试查询</FONT></h1>
	 更换城市：<select id="cityList" onchange="setCityCode()">
		<c:forEach items="${cityList}" var="city">
			<option value="${city.regionCode}">${city.regionName}</option>
		</c:forEach>
	</select>
	<BR />
	<BR />
	<h3><A href="#" onclick="requestForward('Sensor')">查看传感器参数</A></h3>
	<BR />
	<h3><A href="#" onclick="requestForward('Reapter')">查看转发器参数</A></h3>
	<BR />
	<h3><A href="#" onclick="requestForward('Gateway')">查看网关参数</A></h3>

	<FORM action="" id="requestForm" method="post">
		<INPUT type="hidden" id="cityCode" name="cityCode" value="${cityCode}" />
	</FORM>
</body>
</html>