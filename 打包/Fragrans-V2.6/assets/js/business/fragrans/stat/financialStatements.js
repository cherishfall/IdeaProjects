$package('app.financialStatements');
app.financialStatements = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'dayTime',title:'日期',sortable:true},
						{field:'cityName',title:'城市',sortable:true},
						{field:'areaName',title:'区域',sortable:true},
						{field:'tranAmount',title:'应收总金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }},
						{field:'tranPaidAmount',title:'实收总金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }},
						{field:'discountAmount',title:'折扣总金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }},
						{field:'ticketAmount',title:'停车券总金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }},
						{field:'alipayAmount',title:'支付宝实收金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }},
						{field:'wxpayAmount',title:'微信实收金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }},
						{field:'cmbpayAmount',title:'一网通实收金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }},
						{field:'memberPayAmount',title:'会员卡实收金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }},
						{field:'pccPayAmount',title:'丰收互联实收金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font font-weight:bold;'>￥"+value/100+"</font>";
                            }}
			 	]],
				toolbar:[
					// {id:'btnadd',text:'添加',btnType:'add'},
					// {id:'btnedit',text:'修改',btnType:'edit'},
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
	app.financialStatements.init();
});

function generateFinancialStatements() {
    var param = $('#searchForm').serializeObject();
    var dayTime = param.dayTime;
    //验证生成财务报表时间
    if(dayTime == null || dayTime == '' || dayTime == undefined){
        $.messager.show({
            title : '提示',
            msg : '请选择日期'
        });
        return;
    }
    $.messager.confirm("提示", "确认根据查询条件生成财务报表?", function(r) {
        if (r) {
            $.messager.progress({
                title:'请稍后',
                msg:'正在生成财务报表...'
            });
            $('#searchForm').form('submit', {
                url : 'generateFinancialStatements.do',
                type : "post",
                onSubmit : function() {
                    return $(this).form('validate');
                },
                success : function(result) {
                    $.messager.progress('close');
                    var res = $.parseJSON(result);
                    $.messager.show({
                        title : '提示',
                        msg : res.msg
                    });
                    if (res.success) {
                        $('#data-list').datagrid('reload');
                    }
                }
            });
        }
    });
}

function exportFinancialStatements(){
    var param = $('#searchForm').serializeObject();
    var dayTime = param.dayTime;
    var areaCode = param.areaCode;
    //验证月份
    var dateReg = /^(\d{4})-(\d{2})-(\d{2})$/;
    if(dayTime!=''&&dayTime!=null&&dayTime!=undefined&&!dateReg.test(dayTime)){
        $.messager.show({
            title : '提示',
            msg : '请输入合理的日期（格式为2018-03-14）'
        });
        return;
    }
    //导出月报表
    $.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
        if (r) {
            window.open('exportFinancialStatements.do?dayTime='+dayTime+
                '&areaCode='+areaCode);
        }
    });
}