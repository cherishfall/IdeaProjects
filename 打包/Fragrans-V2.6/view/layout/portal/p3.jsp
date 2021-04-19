<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp"%>
<html>
<head>
    <title></title>
</head>
<body>
	<div id="middle" style="display：block">
		<div id="left" style=" width:560px;height:335px; float:left;">
		 	<chart:standardringpie id="registerUserCompare" title="当日IOS和Android注册用户占比" urls="/charts/StandardRingPie.do" displaylabel="true" displaytitle="false" width="100%" height="95%"></chart:standardringpie>
		</div>
		<div id="main" style="width:560px;height:335px; float:left;">
			<chart:ringpie id="dayStat" title="当日注册用户情况" urls="/charts/RingPie.do?days=0" displaylabel="true" displaytitle="false" width="100%" height="95%"></chart:ringpie>
		</div>
	</div> 
	
</body>
</html>
