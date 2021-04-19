<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp"%>
<html>
<head>
<title></title>
</head>
<body>

	<div class="easyui-tabs">
		<div align="center" data-options="title:'今天',iconCls:'iconImg ext-icon-report'">
			<chart:rosepie id="today_char" title="按支付方式统计" urls="/charts/RosePie.do?days=0"
				width="100%" height="85%"></chart:rosepie>
		</div>
		<div align="center" data-options="title:'昨天',iconCls:'iconImg ext-icon-report'">
			<chart:rosepie id="yesterday_char" title="按地区统计" urls="/charts/RosePie.do?days=1"
				width="1050" height="320"></chart:rosepie>
		</div>
	</div>

</body>
</html>
