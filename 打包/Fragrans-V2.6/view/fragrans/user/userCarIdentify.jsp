<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="/view/inc.jsp" %>
</head>
<body class="easyui-layout">
<!-- Search panel start -->
<div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件"
     data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
    <form id="searchForm">
        <p class="ui-fields">
            <label class="ui-label">用户账号:</label><input name="userAccount" class="easyui-box ui-text" style="width:100px;">
            <label class="ui-label">车牌号:</label><input name="plateNo" class="easyui-box ui-text" style="width:100px;">
            <label class="ui-label">是否认证:</label><mytag:dictionary codeType="YESORNO" id="isIdentify" name="isIdentify"
                                                                  isDefaultLine='1' dataOptions="required:false" />
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
           style="margin-top:3px;" iconCls="ext-icon-application_reset">重置</a>
    </form>
</div>
<!--  Search panel end -->

<!-- DataList  -->
<div region="center" border="false">
    <table id="data-list"></table>
</div>

<!-- appUserCar -->
<div id="familyUser" class="easyui-dialog"
     data-options="draggable:true,title:'亲情号信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
     style="width:580px; height:400px; padding: 10px;">
    <form id="editFamilyUser" class="ui-form" method="post">
        <table id="familyUserTable"></table>
    </form>
</div>

<!-- Edit Form -->
<%--<div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true"--%>
     <%--style="width:400px;height:300px;">--%>
    <%--<form id="editForm" class="ui-form" method="post">--%>
        <%--<input class="hidden" type="text" name="id">--%>
        <%--<!-- <input class="hidden" name="deleted"> -->--%>

        <%--<table cellpadding="5px;">--%>
            <%--<tr>--%>
                <%--<td style="text-align: right;"> 关联车牌ID:</td>--%>
                <%--<td>--%>
                    <%--<input class="easyui-validatebox" type="text" name="carId" missingMessage="请输入关联车牌ID"--%>
                           <%--data-options="required:true,validType:'length[1,36]'"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td style="text-align: right;"> 认证用户ID:</td>--%>
                <%--<td>--%>
                    <%--<input class="easyui-validatebox" type="text" name="identifyUserId" missingMessage="请输入认证用户ID"--%>
                           <%--data-options="required:true,validType:'length[1,36]'"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td style="text-align: right;"> 认证车牌ID:</td>--%>
                <%--<td>--%>
                    <%--<input class="easyui-validatebox" type="text" name="identifyCarId" missingMessage="请输入认证车牌ID"--%>
                           <%--data-options="required:true,validType:'length[1,36]'"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--</form>--%>
<%--</div>--%>

<!-- js -->
<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/user/userCarIdentify.js"></script>
</body>
</html>
