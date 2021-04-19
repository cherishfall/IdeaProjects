<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="mytag" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="chart" tagdir="/WEB-INF/tags/charts" %>
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<%
Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
Cookie[] cookies = request.getCookies();
if (null != cookies) {
	for (Cookie cookie : cookies) {
		cookieMap.put(cookie.getName(), cookie);
	}
}
String easyuiTheme = "metro";//指定如果用户未选择样式，那么初始化一个默认样式
if (cookieMap.containsKey("easyuiTheme")) {
	Cookie cookie = (Cookie) cookieMap.get("easyuiTheme");
	easyuiTheme = cookie.getValue();
}
%>
<script type="text/javascript"> 
	var sy = sy || {};
	var basePath = '<%=basePath%>';//js中存放当前页面的root路径方便调用
	sy.pixel_0 = '<%=basePath%>/assets/images/pixel_0.gif';//0像素的背景，一般用于占位
</script>
<!-- 公共资源CSS,JS  -->
<!--Css -->
<link id="easyuiTheme" rel="stylesheet" href="<%=basePath%>/assets/js/jquery-easyui-1.3.6/themes/<%=easyuiTheme%>/easyui.css" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/assets/js/jquery-easyui-1.3.6/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/assets/css/syExtCss.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/assets/css/syExtIcon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/assets/css/base.css">
<!-- ** Javascript ** -->
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/jquery.cookie.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/package.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/urls.js?v=11"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/base.js?v=11"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/YDataGrid.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
<%-- 引入EasyUI Portal插件 --%>
<link rel="stylesheet" href="<%=basePath%>/assets/js/jquery-easyui-portal/portal.css" type="text/css">
<script type="text/javascript" src="<%=basePath%>/assets/js/jquery-easyui-portal/jquery.portal.js" charset="utf-8"></script>
<%-- 引入easyui扩展 --%>
<script src="<%=basePath%>/assets/js/commons/syExtEasyUI.js" type="text/javascript" charset="utf-8"></script>
<%--引入echart图表插件--%>
<script type="text/javascript" src="<%=basePath%>/assets/js/echarts-2.1.8/build/dist/echarts.js" charset="utf-8"></script>

<script type="text/javascript">
	//根据字典类型和代码获取名称
	//sys.dicts['STATE0']
  	sys.dicts = sys.paserJson('${dictionaryJson}');
	sys.dicts = $.extend(sys.dicts, {
		text: function(codeType, codeValue) {
			if(codeValue != undefined && codeValue != null) {
				codeValue = codeValue + '';
				if(codeValue.indexOf(',') != -1) {
					var arr = codeValue.split(',');
					var str = '';
					for(var i = 0; i < arr.length; i++) {
						str += sys.dicts.text(codeType, arr[i]) + '、';
					}
					return str.length > 0 ? str.substring(0, str.length -1) : str;
				} else {
					return sys.dicts[codeType + codeValue];
				}
			} else {
				return function(value) {
					return sys.dicts[codeType + value];
				}
			}
		}
	});
</script>
