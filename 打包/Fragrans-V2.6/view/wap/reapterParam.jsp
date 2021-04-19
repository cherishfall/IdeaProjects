<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@include file="inc.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>转发器参数查询</title>
</head>
<body>
	<h3>
		<a href="<%=basePath%>/wap/index.action">返回首页</a>
	</h3>
	<form action="<%=basePath%>/wap/checkReapterParam.action" method="post">
		<p>
			转发器地址：<input type="text" id="address" name="address"
				value="${model.address}" style="width: 80px;" /> <input
				type="submit" value="查询" />
		</p>
	</form>
	<hr />
	<c:if test="${addr != null}">
		<h4>${name}&nbsp;&nbsp;当前第${model.page}页</h4>
	</c:if>
	<c:forEach var="reapterParam" items="${dataList}" varStatus="status">
 			${status.index+1}.<fmt:formatDate value="${reapterParam.sentTime}" type="both" dateStyle="default" /> Ve:<font color='red'>${reapterParam.version}</font>, Hp:${reapterParam.hop},Ri:<font color="red">${reapterParam.rssi}</font>, RiAd:${reapterParam.rssiAddr}, 
 			<font color='blue'>Bat:${reapterParam.voltageBattery}, Chg:${reapterParam.voltageCharge}</font>, 
		    netId:<font color="red">${reapterParam.netId}</font>, netIn:<font color="red">${reapterParam.netIn}</font><br/><br/>
	</c:forEach>
	<c:if test="${not empty dataList}">
		<p>
			<c:if test="${model.page > 1}">
				<a
					href="<%=basePath%>/wap/checkReapterParam.action?address=${model.address}&page=1">首页</a>
				&nbsp;&nbsp;
				<a
					href="<%=basePath%>/wap/checkReapterParam.action?address=${model.address}&page=${model.page-1}">上一页</a>
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
					href="<%=basePath%>/wap/checkReapterParam.action?address=${model.address}&page=${model.page+1}">下一页</a>
				&nbsp;&nbsp;
				<a
					href="<%=basePath%>/wap/checkReapterParam.action?address=${model.address}&page=${model.pager.pageCount}">尾页</a>
			</c:if>

		</p>
	</c:if>
</body>
</html>