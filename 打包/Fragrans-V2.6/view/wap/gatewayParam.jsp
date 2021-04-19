<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@include file="inc.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>网关参数查询</title>
</head>
<body>
	<h3>
		<a href="<%=basePath%>/wap/index.action">返回首页</a>
	</h3>
	<form action="<%=basePath%>/wap/checkGatewayParam.action" method="post">
		<p>
			网关地址：<input type="text" id="address" name="address"
				value="${model.address}" style="width: 80px;" /> <input
				type="submit" value="查询" />
		</p>
	</form>
	<hr />
	<c:if test="${addr != null}">
		<h4>${name}&nbsp;&nbsp;当前第${model.page}页</h4>
	</c:if>
	<c:forEach var="gatewayParam" items="${dataList}" varStatus="status">
 			${status.index+1}.<fmt:formatDate value="${gatewayParam.sentTime}" type="both" dateStyle="default" />
 			Ve:<font color='red'>${gatewayParam.version}</font>,
 			<font color='blue'>Bat:${gatewayParam.voltageBattery}, Chg:${gatewayParam.voltageCharge}</font>,
		    netId:<font color="red">${gatewayParam.netId}</font>,netIn:<font color="red">${gatewayParam.netIn}</font><br/><br/>
	</c:forEach>
	<c:if test="${not empty dataList}">
		<p>
			<c:if test="${model.page > 1}">
				<a
					href="<%=basePath%>/wap/checkGatewayParam.action?address=${model.address}&page=1">首页</a>
				&nbsp;&nbsp;
				<a
					href="<%=basePath%>/wap/checkGatewayParam.action?address=${model.address}&page=${model.page-1}">上一页</a>
				&nbsp;&nbsp;
			</c:if>
			<c:if test="${model.page == 1}">
				<a href="#">首页</a>
				&nbsp;&nbsp;
				<a href="#">上一页</a>
				&nbsp;&nbsp;
			</c:if>

			<c:if test="${model.page == model.pager.pageCount}">
				<a href="#">下一页</a>
				&nbsp;&nbsp;
				<a href="#">尾页</a>
			</c:if>
			<c:if test="${model.page != model.pager.pageCount}">
				<a
					href="<%=basePath%>/wap/checkGatewayParam.action?address=${model.address}&page=${model.page+1}">下一页</a>
				&nbsp;&nbsp;
				<a
					href="<%=basePath%>/wap/checkGatewayParam.action?address=${model.address}&page=${model.pager.pageCount}">尾页</a>
			</c:if>

		</p>
	</c:if>
</body>
</html>