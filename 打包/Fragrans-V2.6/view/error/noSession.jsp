<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.innotek.common.util.StringUtil"%>
<%@include file="/view/inc.jsp"%>

<%
cookies = request.getCookies();
if (null != cookies) {
	for (Cookie cookie : cookies) {
		cookieMap.put(cookie.getName(), cookie);
	}
}
String shortName = "";//指定如果用户未选择样式，那么初始化一个默认样式
if (cookieMap.containsKey("shortName")) {
	Cookie cookie = (Cookie) cookieMap.get("shortName");
	shortName = cookie.getValue();
}
%>

<script type="text/javascript">
	window.top.location= urls['msUrl']+'/index.jsp';
</script>
