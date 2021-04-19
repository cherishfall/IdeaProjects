<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp"%>
<html>
<head>
    <title></title>
</head>
<body>
<chart:line id="weekStat" title="最近七天收入统计" urls="/charts/line.do?days=7" height="100%" width="100%" ></chart:line>
</body>
</html>
