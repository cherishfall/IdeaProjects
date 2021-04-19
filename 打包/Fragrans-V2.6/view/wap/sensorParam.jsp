<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%@include file="inc.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>传感器参数查询</title>
</head>

<body>
	<h3><a href="<%=basePath%>/wap/index.action">返回首页</a></h3>
	<form action="<%=basePath%>/wap/checkSensorParam.action" method="post">
		<p>
			泊位号：<input type="text" id="berthCode" name="berthCode"
				value="${model.berthCode}" style="width:80px;"/> <input type="submit" value="查询" />
		</p>
	</form>
	<hr />
<c:if test="${addr != null}">
	<h4>${addr}&nbsp;&nbsp;当前第${model.page}页</h4>
</c:if>
<c:forEach var="sensorParam" items="${dataList}" varStatus="status">
<pre>
${status.index+1}.Type:<font color='red'>${sensorParam.eventType}</font>, Hp:<font color='red'>${sensorParam.hop}</font>, Ri:<font color='red'>${sensorParam.rssi}</font>, Seq:<font color='red'>${sensorParam.sequenceNumber}</font>
RiAd:${sensorParam.rssiaddr}, isAv:${sensorParam.isArrival}, isDp:${sensorParam.isDeparture}, isOp:${sensorParam.isOccupied}, isMG:${sensorParam.isMagGood}
<font color="blue">Mag:${sensorParam.magvalue}</font>
<fmt:formatDate value="${sensorParam.sendTime}" type="both" dateStyle="default" pattern="yyyy-MM-dd HH:mm:ss"/> GW:<font color="red">${sensorParam.gatewayName}</font>
</pre>
	</c:forEach>
	<c:if test="${not empty dataList}">
		<p>
			<c:if test="${model.page > 1}">
				<a
					href="<%=basePath%>/wap/checkSensorParam.action?berthCode=${model.berthCode}&page=1">首页</a>
				&nbsp;&nbsp;
				<a
					href="<%=basePath%>/wap/checkSensorParam.action?berthCode=${model.berthCode}&page=${model.page-1}">上一页</a>
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
					href="<%=basePath%>/wap/checkSensorParam.action?berthCode=${model.berthCode}&page=${model.page+1}">下一页</a>
				&nbsp;&nbsp;
				<a
					href="<%=basePath%>/wap/checkSensorParam.action?berthCode=${model.berthCode}&page=${model.pager.pageCount}">尾页</a>
			</c:if>

		</p>
	</c:if>
</body>

</html>


