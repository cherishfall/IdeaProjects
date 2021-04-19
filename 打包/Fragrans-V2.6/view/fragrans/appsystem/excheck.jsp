<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- ztree -->
	<div>
		<form id="ztreeForm" class="ui-form" method="post">
			<input class="hidden" type="text" id="param" name="param" value="<%=request.getParameter("param") %>" />
			<input class="hidden" type="text" id="objId" name="objId" value="<%=request.getParameter("objId") %>" />
			<input class="hidden" type="text" id="codeEditId" name="codeEditId" value="<%=request.getParameter("codeEditId") %>" />
			<input class="hidden" type="text" id="nameEditId" name="nameEditId" value="<%=request.getParameter("nameEditId") %>" />
			<div style="margin:5px 0 10px 50px;width:140px;">
			<ul id="cityTree" class="ztree"></ul>
			</div>
			<!-- <div style="float:right;text-align: right;margin:10px 10px;">
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'"
				onclick="$('#ztree').dialog('close');">取消</a>
			</div>
			<div style="float:right;text-align: right;margin:10px 10px;">
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'"
    						 onclick="VerificateSendMessage(this);">确定</a>
    		</div> -->
		</form>
	</div>
	<link rel="stylesheet" href="<%=basePath%>/assets/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" media="screen"/>
	<!-- ztree -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/ztree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="<%=basePath%>/assets/js/ztree/js/jquery.ztree.excheck-3.5.js"></script>
	 <!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/excheck.js"></script>
</body>
</html>