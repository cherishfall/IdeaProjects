<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout" style="overflow-y: scroll;">
    <form id="editForm" class="ui-form" method="post">
        <div class="pageFormContent">
            <table cellpadding="25px;" style="width:700px;">
                <tr>
                    <td style="text-align: right;">订单编号：</td>
                    <td colspan="2">
                        <input class="easyui-validatebox" id="batchpayNo" name="batchpayNo" type="text"
                               style="width:300px;" missingMessage="该项为必输项" data-options="required:true"/>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;position:relative;left:20px;">
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'"
                           onclick="sendNotify(this);">发送通知</a>
                    </td>
                    <td style="text-align: right;width:0px;">
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'"
                           onclick="$(editForm).form('reset');">重置</a>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <!-- js -->
    <script type="text/javascript">
        function sendNotify(form) {
            var batchpayNo = $('#batchpayNo').val();
            $.messager.confirm('确认', '确定要执行此操作吗？', function(r) {
                if(r){
                    $.messager.progress({
                        title:'请稍后',
                        msg:'正在发送通知...'
                    });
                    $.ajax({
                        url : 'sendNotify.do',
                        type : 'post',
                        data : {
                            batchpayNo : batchpayNo
                        },
                        success : function(result){
                            $.messager.progress('close');
                            console.log(result);
                            $.messager.show({
                                msg : result.msg,
                                title : '提示'
                            });
                            if (result.success) {
                                $('#data-list').datagrid('reload');
                            }
                        }
                    });
                }
            });
        }
    </script>
</body>
</html>
