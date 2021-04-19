$package('app.userCarIdentify');
app.userCarIdentify = function () {
    var _box = null;
    var _this = {
        config: {
            event:{
                search : function() { //条件查询验证
                    var param = $("#searchForm").serializeObject();
                    if(param.userAccount == '' && param.plateNo == '' && param.isIdentify == ''){
                        $.messager.show({
                            msg : '请至少选择一个查询条件',
                            title : '提示'
                        });
                        return;
                    }
                    var opts = $("#data-list").datagrid("options");
                    opts.url = "dataList.do";
                    $('#data-list').datagrid('reload',param);
                }
            },
            dataGrid: {
                title: '用户车牌列表',
                url: '',
                fitColumns: true,
                onLoadSuccess: function(data){
                    if(data.rows.length==0){
                        var body = $(this).data().datagrid.dc.body2;
                        body.find('table tbody').append('<tr><td width="'+body.width()+'" style="height: 25px; padding:10px;text-align: left;"  colspan='+5+'>没有任何结果数据显示！（请确认查询条件是否正确）</td></tr>');
                    }
                },
                columns: [[ // ,formatter:sys.dicts.text('OPEN_FLAG')
                    {field: 'id', checkbox: true},
                    {field:'userAccount',title:'用户账号',width : 40,},
                    {field:'plateNo',title:'车牌号',width : 40,},
                    {field:'plateColor',title:'车牌颜色',width : 40,formatter : sys.dicts.text('PLATE_COLOR')},
                    {field:'isDefault',title:'是否默认',width : 40,formatter:sys.dicts.text('IS_DEFAULT')},
                    {field:'isIdentify',title:'是否认证',width : 40,
                        formatter:function(value,row,index){
                            if(value==1) {
                                return "<font style='color:blue;font-weight:bold;'>" + sys.dicts.text('YESORNO', value) + "</font>";
                            }else{
                                return sys.dicts.text('YESORNO', value);
                            }
                        }},
                    {field:'isCardAutopay',title:'是否开通代扣',width : 40,formatter : sys.dicts.text('YESORNO')},
                    {field:'createTime',title:'创建时间',width : 80},
                    {field:'updateTime',title:'更新时间',width : 80}
                ]],
                toolbar: [
                    {id: 'btnFamilyUserList', text: '亲情号列表', btnType: 'familyUserList',iconCls:'ext-icon-book_open',handler : function() {
                        var rows = $('#data-list').datagrid('getChecked');
                        if (rows.length == 1) {
                            if(rows[0].isIdentify==0){
                                $.messager.show({
                                    msg : '未认证用户，没有亲情号列表',
                                    title : '提示'
                                });
                                return;
                            }
                            getFamilyUserList(rows[0]);
                        } else {
                            $.messager.show({
                                msg : '请选择一个用户',
                                title : '提示'
                            });
                        }
                    }}
                    // {id: 'btnedit', text: '修改', btnType: 'edit'},
                    // {id: 'btndelete', text: '删除', btnType: 'remove'}
                ]
            }
        },
        init: function () {
            _box = new YDataGrid(_this.config);
            _box.init();
            $("#data-list").datagrid('appendRow', { userAccount: '<div style="text-align:center;">请输入查询条件！</div>' }).datagrid('mergeCells', { index:0, field: 'userAccount', colspan: 8 })
        }
    }
    return _this;
}();

$(function () {
    app.userCarIdentify.init();
});

function getFamilyUserList(data){
    $('#familyUser').dialog('open');
    $('#familyUserTable').datagrid(
        {
            rownumbers : true,
            title : '亲情号信息',
            fitColumns : true,
            singleSelect : true,
            url : 'getFamilyUserList.do?carId=' + data.id,
            width : 500,
            height : 300,
            columns : [ [
                {
                    field : 'id',
                    hidden : true
                },
                {
                    field : 'userAccount',
                    title : '亲情号',
                    width : 80,
                    align : 'center'
                },
                {
                    field : 'plateNo',
                    title : '车牌号',
                    width : 80,
                    align : 'center'
                },
                {
                    field : 'plateColor',
                    title : '车牌颜色',
                    width : 80,
                    align : 'center',
                    formatter : sys.dicts.text('PLATE_COLOR')
                },
                {
                    field : 'isIdentify',
                    title : '是否认证',
                    width : 80,
                    formatter : sys.dicts.text('YESORNO')
                }]],
            toolbar : []
        });
}