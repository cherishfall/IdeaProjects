$package('app.memberCardAutoPay');
app.memberCardAutoPay = function(){
    var _box = null;
    var _this = {
        config:{
            dataGrid:{
                title:'列表',
                url:'dataList.do',
                fitColumns:true,
                columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
                    {field:'id',checkbox:true},
                    {field:'userId',hidden:true},
                    {field:'userAccount',title:'手机号码',sortable:true},
                    {field:'plateNo',title:'车牌号',sortable:true},
                    {field:'plateColor',title:'车牌颜色',sortable:true,formatter:sys.dicts.text('PLATE_COLOR')},
                    // {field:'isDefault',title:'是否默认',sortable:true,formatter:sys.dicts.text('YESORNO')},
                    // {field:'isIdentify',title:'车牌是否认证',sortable:true,formatter:sys.dicts.text('YESORNO')},
                    {field:'isCardAutopay',title:'是否开启自动代扣',sortable:true,formatter:sys.dicts.text('YESORNO')},
                    {field:'isElectTag',title:'是否绑定电子标签',sortable:true,formatter:sys.dicts.text('YESORNO')},
                    {field:'electTagNo',title:'电子标签编号',sortable:true}
                ]],
                toolbar:[
                    {
                        id : 'btnProcessAutoPay',
                        iconCls : 'ext-icon-cog_edit',
                        text : '开通代扣',
                        btnType : 'processAutoPay',
                        handler : function() {
                            //清空表单
                            $('#cityCode').combotree('clear');
                            $('#phone').val('');
                            $('#plateNo').val('');
                            $('#electTagNo').val('');
                            $('#plateColor').combobox('setValue','');
                            processAutoPay();
                        }
                    },{id:'btneditElectTag',text:'修改电子标签编号',btnType:'editElectTag',iconCls : 'icon-edit',handler : function() {
                            edit();
                    }}
                    // {id:'btnadd',text:'添加',btnType:'add'},
                    // {id:'btndelete',text:'删除',btnType:'remove'}
                ]
            }
        },
        init:function(){
            _box = new YDataGrid(_this.config);
            _box.init();
        }
    }
    return _this;
}();

$(function(){
    app.memberCardAutoPay.init();
    $('#edit-win').dialog({
        buttons:[
            {
                text:'保存',
                handler:function(){
                    var electTagNo = $('#electTagNoEdit').val();
                    //验证消息摘要是否为空
                    if (electTagNo==null||electTagNo==''||electTagNo==undefined) {
                        $.messager.alert('提示','电子标签编号不能为空','info');
                        return;
                    }
                    var validElectTagNo =/^[0-9a-fA-F]{1,36}$/.test(electTagNo);
                    if(!validElectTagNo){
                        $.messager.show({
                            title : '提示',
                            msg : '电子标签格式不正确(应为0-9或A-F的字符组成)'
                        });
                        return;
                    }
                    var mes = '确定修改电子标签编号为'+electTagNo+'吗？';
                    $.messager.confirm('确认',mes , function(r) {
                        if (r) {
                            $('#editForm').form('submit', {
                                url: 'save.do',
                                type: 'post',
                                success: function (result) {
                                    var mes = eval('(' + result + ')');
                                    if (!mes.success) {
                                        $.messager.alert('提示', mes.msg, 'error');
                                    } else {
                                        $.messager.show({
                                            title: '提示',
                                            msg: mes.msg
                                        });
                                        $('#edit-win').dialog('close');
                                        $('#data-list').datagrid('reload');
                                    }
                                }
                            });
                        }
                    });
                }
            },{
                text:'关闭',
                handler:function(){
                    $('#edit-win').dialog('close');
                }
            }
        ]
    });
});

function processAutoPay(){
    // 打开开通代扣弹窗
    $('#processAutoPayDiv').dialog('open');
}

$('#processAutoPayDiv').dialog({
    buttons:[
        {
            text:'开通',
            iconCls : 'ext-icon-tick',
            handler:function(){
                var cityCode = $('#cityCode').combotree('getValue');
                var phone = $('#phone').val();
                var plateNo = $('#plateNo').val().toUpperCase();
                var plateColor = $('#plateColor').combobox('getValue');
                var electTagNo = $('#electTagNo').val();
                if(cityCode==null||cityCode==''||cityCode==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择区域'
                    });
                    return;
                }
                if(phone==null||phone==''||phone==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '手机号码不能为空'
                    });
                    return;
                }
                var validPhone = /^(13[0-9]|14[57]|15[012356789]|16[6]|17[035678]|18[0-9]|19[9])[0-9]{8}$/.test(phone);
                if(!validPhone){
                    $.messager.show({
                        title : '提示',
                        msg : '手机号码格式不正确'
                    });
                    return;
                }
                if(plateNo==null||plateNo==''||plateNo==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '车牌号不能为空'
                    });
                    return;
                }
                var validPlateNo = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4,5}[A-Z0-9挂学警港澳]{1}$/.test(plateNo);
                if(!validPlateNo){
                    $.messager.show({
                        title : '提示',
                        msg : '车牌号码格式不正确'
                    });
                    return;
                }
                if(plateColor==null||plateColor==''||plateColor==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择车牌颜色'
                    });
                    return;
                }
                if(electTagNo==null||electTagNo==''||electTagNo==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '电子标签编号不能为空'
                    });
                    return;
                }
                var validElectTagNo =/^[0-9a-fA-F]{1,36}$/.test(electTagNo);
                if(!validElectTagNo){
                    $.messager.show({
                        title : '提示',
                        msg : '电子标签格式不正确(应为0-9或A-F的字符组成)'
                    });
                    return;
                }
                var mes = '确认后将给手机号：<span style="color: #00B83F">'+phone+'</span>，车牌号：<span style="color: #CC2222;font-weight: bold;">'+plateNo+'</span> 开通代扣，确定吗？';
                $.messager.confirm('确认',mes , function(r) {
                    if (r) {
                        $.ajax({
                            url: 'processAutoPay.do',
                            type: 'post',
                            data : {
                                cityCode : cityCode,
                                phone : phone,
                                plateNo : plateNo,
                                plateColor : plateColor,
                                electTagNo : electTagNo
                            },
                            success: function (result) {
                                if (result.success) {
                                    var resp = result.data;
                                    if (resp=="SUCCESS"){
                                        $.messager.alert('提示',result.msg,'info');
                                        $('#processAutoPayDiv').dialog('close');
                                        $('#data-list').datagrid('reload');
                                    }else if(resp=="UNCONFIRMED"){
                                        //该用户该车牌已开通过代扣，二次确认，是否开通
                                        $.messager.confirm('确认', result.msg+"确认重新开通？", function(r) {
                                            if (r) {
                                                openAutoPay(phone,plateNo,plateColor,electTagNo);
                                            }
                                        });
                                    }
                                } else {
                                    $.messager.alert('提示',result.msg,'error');
                                }
                            },
                            error : function(e) {
                                $.messager.confirm('提示', '登录超时,点击确定重新登录.', function(r) {
                                    if(r){
                                        window.top.location = urls['msUrl'] + "/login.action";
                                    }
                                });
                            }
                        });
                    }
                });
            }
        },{
            text:'重置表单',
            iconCls:'ext-icon-arrow_undo',
            handler:function(){
                //清空表单
                $('#cityCode').combotree('clear');
                $('#phone').val('');
                $('#plateNo').val('');
                $('#electTagNo').val('');
                $('#plateColor').combobox('setValue','');
            }
        }
    ]
});

function openAutoPay(phone,plateNo,plateColor,electTagNo){
    $.ajax({
        url: 'openAutoPay.do',
        type: 'post',
        data: {
            phone: phone,
            plateNo: plateNo,
            plateColor: plateColor,
            electTagNo: electTagNo
        },
        success: function (result) {
            if (result.success) {
                $.messager.alert('提示',result.msg,'info');
                $('#processAutoPayDiv').dialog('close');
                $('#data-list').datagrid('reload');
            } else {
                $.messager.alert('提示',result.msg,'error');
            }
        },error : function(e) {
            $.messager.confirm('提示', '登录超时,点击确定重新登录.', function(r) {
                if(r){
                    window.top.location = urls['msUrl'] + "/login.action";
                }
            });
        }
    });
}

function edit(){
    var rows = $('#data-list').datagrid('getChecked');
    if(rows.length!=1){
        $.messager.show({
            title : '提示',
            msg : '请选择一条记录~'
        });
        return;
    }

    var id = rows[0].id;
    $('#id').val(id);
    $('#userId').val(rows[0].userId);
    $('#userAccount').text(rows[0].userAccount);
    $('#plateNoEdit').text(rows[0].plateNo);
    $('#plateColorEdit').text(sys.dicts.text('PLATE_COLOR',rows[0].plateColor));
    $('#electTagNoEdit').val('');

    $.ajax({
        url : 'getId.do',
        type : 'post',
        dataType : 'json',
        data : {
            id : id
        },
        success : function(result) {
            if (result.success) {
                var electTagNo = rows[0].electTagNo;
                if(result.data!=null){
                    electTagNo = result.data.electTagNo;
                }
                $('#electTagNoEdit').val(electTagNo);
            } else {
                $.messager.show({
                    msg : result.msg,
                    title : '提示'
                });
            }
        },error : function(e) {
            $.messager.confirm('提示', '登录超时,点击确定重新登录.', function(r) {
                if(r){
                    window.top.location = urls['msUrl'] + "/login.action";
                }
            });
        }
    });
    $('#edit-win').dialog('open');
}
