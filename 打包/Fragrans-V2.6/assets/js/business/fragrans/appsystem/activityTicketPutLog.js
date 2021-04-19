$package('app.activityTicketPutLog');
app.activityTicketPutLog = function(){
    var _box = null;
    var _this = {
        ticket:function(){
            var userAccount = $('#userAccount').val();
            if (userAccount=="") {
                $.messager.show({
                    title : '提示',
                    msg : '请输入用户账号~'
                });
            }
            else {
                $('#sendTicket').dialog('open');
                $('#sendTicketForm').form('reset');
                $('#userAccountForTicket').val(userAccount);
            }
        },
        config:{
            event : {
                save : function(){
                    var ticketDescEdit = $('#ticketDescEdit').val();
                    if($.trim(ticketDescEdit)==''){
                        $.messager.alert('提示','券使用描述不能为空');
                        return;
                    }
                    _box.handler.save();
                }
            },
            dataGrid:{
                title:'列表',
                url:'dataList.do',
                pageSize:1000,
                pageList: [100,2000],
                pagination: true,
                fitColumns:true,
                rowStyler:function(index,row){
                    if(row.used==1){
                        return 'background-color:#faf2cc;';
                    }else{
                        if (formatDateLong(row.validDate)<getNowDay()){
                            return 'background-color:#ebcccc;';
                        }
                    }
                },
                onDblClickRow : function(index, data) {
                    if(data.used == 0){
                        $.messager.alert('提示','该停车券未产生交易订单~');
                        return;
                    }
                    $.messager.progress({
                        title:'请稍后',
                        msg:'正在查询交易详情...'
                    });
                    $.ajax({
                        url : 'getOrderPayDetail.do',
                        type : 'post',
                        async : 'false',
                        data : {
                            ticketNo : data.ticketNo
                        },
                        success : function(result){
                            $.messager.progress('close');
                            if(result == null || result == ''){
                                $.messager.alert('提示','未查询到优惠券产生的交易记录~');
                                return;
                            }
                            var orderNo = result.orderNo;
                            $('#paylog').dialog({
                                maximizable:true,
                                href: '../view/fragrans/appsystem/orderDetail.jsp?orderNo='+orderNo,
                            });
                            $('#paylog').dialog("open");
                        }
                    });
                },
                columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
                    {field:'userAccount',title:'用户账号',sortable:true},
                    {field:'activityName',title:'活动名称',sortable:true},
                    {field:'ticketName',title:'停车券名称',sortable:true},
                    {field:'ticketNo',title:'停车券编号',sortable:true},
                    {field:'getTicketTime',title:'停车券获取时间',sortable:true},
                    {field:'validDate',title:'停车券过期时间',sortable:true},
                    {field:'isOvertime',title:'是否已过期',sortable:true,
                        formatter:function(value,row,index){
                            console.log(value);
                            if(value==1){
                                return "<font style='color:red'>已过期</font>";
                            }else{
                                return "<font>未过期</font>";
                            }
                        }},
                    {field:'used',title:'是否已使用',sortable:true,
                        formatter:function(value,row,index){
                            if(value==1){
                                return "<font style='color:blue'>已使用</font>";
                            }else{
                                return "<font>未使用</font>";
                            }
                        }},
                    {field:'createdBy',title:'发券人',sortable:true},
                    {field:'ticketUseTime',title:'使用时间',sortable:true},
					/*{field:'parkrecordId',title:'使用停车记录',sortable:true},
					 {field:'orderNo',title:'使用订单编号',sortable:true}*/
                ]] ,
                toolbar:[
                    {id:'btnticket',text:'补偿券',iconCls : 'ext-icon-rss',btnType:'ticket',handler:function(){
                        _this.ticket();
                    }}
                ]
            }
        },
        init:function(){
            _box = new YDataGrid(_this.config);
            _box.init();

            $('#sendTicket').dialog({
                buttons:[
                    {
                        text:'发券',
                        handler:function(){
                            var activityId = $('#activityId').combobox('getValue');
                            var userAccount=$('#userAccountForTicket').val();
                            if(activityId==''){
                                $.messager.alert('提示','请先选择补偿券');
                                return;
                            }
                            $.messager.confirm('确认', '确认发券？', function(r) {
                                if (r) {
                                    $('#sendTicketForm').form('submit',{
                                        url:'sendTicket.do',
                                        type : 'post',
                                        success:function(result){
                                            var mes = eval('('+result+')');
                                            $.messager.show({
                                                title : '提示',
                                                msg : mes.msg
                                            });
                                            $('#sendTicket').dialog('close');
                                            $('#data-list').datagrid('reload');
                                        }
                                    });
                                }
                            });
                        }
                    },{
                        text:'关闭',
                        handler:function(){
                            $('#sendTicket').dialog('close');
                        }
                    }
                ]
            });
        }
    }
    return _this;
}();

$(function(){
    app.activityTicketPutLog.init();
});

$(".datagrid-toolbar").keydown(
    function(e) {
        if (e.keyCode == 13) {
            var param = $("#searchForm").serializeObject();
            if(param.userAccount == ''){
                $.messager.show({
                    msg : '请至少选择一个查询条件',
                    title : '提示'
                });
                return;
            }
            var opts = $("#data-list").datagrid("options");
            opts.url = "dataList.do";
            $('#data-list').datagrid('reload',param);
            return false;
        }
    });

function getNowDay() {
    var date = new Date();
    return date.getTime();
}

function formatDateLong(validDate){
    var date = new Date(validDate);
    return date.getTime()+1 * 16 * 60 * 60 * 1000-1000;
}


//获取补偿券
$('#activityId').combobox({
    title:'列表',
    url:'getTicket.do',
    fit : true,
    editable:false,
    valueField : 'id',
    textField : 'text',
});
