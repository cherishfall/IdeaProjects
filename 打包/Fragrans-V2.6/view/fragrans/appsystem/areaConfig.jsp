<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
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
            <label class="ui-label">参数关键字:</label><input name="paraName" class="easyui-box ui-text" style="width: 100px;">
            <label class="ui-label">区域:</label><input name="areaId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
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

<!-- Edit Form -->
<div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true"
     style="width:400px;height:300px;">
    <form id="editForm" class="ui-form" method="post">
        <input class="hidden" type="text" name="id">
        <!-- <input class="hidden" name="deleted"> -->

        <table cellpadding="5px;">
            <tr>
                <tr>
                    <td style="text-align: right;">区域：</td>
                    <td>
                        <input id="areaCode" name="areaId" class="easyui-combotree"
                               data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
                            idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true"/>
                        <img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
                             onclick="$('#areaCode').combotree('clear');" />
                    </td>
                </tr>
            </tr>
            <tr>
                <td style="text-align: right;"> 参数关键字:</td>
                <td>
                    <input class="easyui-validatebox" type="text" name="paraName" missingMessage="请输入参数关键字"
                           data-options="required:true,validType:'length[1,32]'"/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;"> 参数值:</td>
                <td>
                    <input class="easyui-validatebox" type="text" name="paraValue" missingMessage="请输入参数值"
                           data-options="required:true,validType:'length[1,512]'"/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;"> 是否通用:</td>
                <td>
                    <mytag:dictionary codeType="ISCOMMON" id="paraType" name="paraType" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;"> 参数状态:</td>
                <td>
                    <mytag:dictionary codeType="STATE" id="state" name="state" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right;"> 参数描述:</td>
                <td>
                    <input class="easyui-validatebox" type="text" name="paraDesc" missingMessage="请输入参数描述"
                           data-options="required:false,validType:'length[1,256]'"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- js -->
<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/areaConfig.js"></script>
</body>
</html>
