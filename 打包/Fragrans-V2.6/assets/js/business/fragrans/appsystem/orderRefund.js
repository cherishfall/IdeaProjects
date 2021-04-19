$package('app.orderRefund');
app.orderRefund = function(){
	var _box = null;
	var _this = {
		config:{
            event : {
                search : function() { //条件查询验证
                    var startEventTime = $('#startTime').datetimebox('getValue');
                    var endEventTime = $('#endTime').datetimebox('getValue');
                    if (startEventTime > endEventTime) {
                        sys.alert('警告', '起始时间大于结束时间.', 'warning');
                        return;
                    }
					var Grid = $('#data-list');
				    var Form = {
				     	search: $("#searchForm")
				 	};
					var param = Form.search.serializeObject();
					Grid.datagrid('reload',param);
                }
            },
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
                queryParams:{
                    startTime :getMonthFirstDatetime() ,
                    endTime : new Date().pattern("yyyy-MM-dd HH:mm:ss"),
                },
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'cityName',title:'城市名称',sortable:true},
						{field:'areaName',title:'区域名称',sortable:true},
	 					{field:'parkrecordId',title:'停车记录id',sortable:true},
			 					{field:'orderNo',title:'订单编号',sortable:true},
			 					{field:'payTime',title:'支付时间',sortable:true},
			 					{field:'refundNo',title:'退款编号',sortable:true},
			 					{field:'refundFee',title:'退款金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
		 						{field:'counterFee',title:'手续费',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'refundTime',title:'退款时间',sortable:true},
			 					{field:'createBy',title:'操作人',sortable:true},
			 					{field:'notifyStatus',title:'通知状态',sortable:true,formatter:sys.dicts.text('NOTIFY_STATUS')},
			 					{field:'reason',title:'退款原因',sortable:true},
			 					{field:'isComplate',title:'退款状态',sortable:true,formatter:sys.dicts.text('IS_REFUND')},
			 					{field:'note',title:'备注',sortable:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
                    {id:'btnExport',text:'导出退款记录',btnType:'export',iconCls:"ext-icon-page_excel",
                        handler : function() {
                            $('#exportForm').form('reset');
                            exportRecord();
  				    }}
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
	app.orderRefund.init();
    var date = new Date();
    $('#endTime').datetimebox('setValue',date.pattern("yyyy-MM-dd HH:mm:ss"));
    $('#startTime').datetimebox('setValue',getMonthFirstDatetime());

    // 导出
    $('#export-win').dialog({
        buttons : [ {
            text : '导出',
            handler : function() {
                var param = $('#exportForm').serializeObject();
                var startDate = param.startDate;
                var endDate = param.endDate;
                var cityId = param.cityId;
                //验证导出日报时间
                if(isEmpty(cityId) && isEmpty(startDate) && isEmpty(endDate)){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择一个有效的查询条件'
                    });
                    return;
                }
                if(isEmpty(cityId) && !(!isEmpty(startDate) && !isEmpty(endDate))){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择一个有效的查询时间段'
                    });
                    return;
				}
                if (endDate < startDate) {
                    $.messager.show({
                        title : '提示',
                        msg : "开始时间必须小于结束时间"
                    });
                    return;
                }
                $.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
                    if (r) {
                        window.open('export.do?startDate=' + startDate
                            + '&endDate=' + endDate + '&cityId=' + cityId);
                    }
                });
                $('#export-win').dialog('close');
            }
        }, {
            text : '关闭',
            handler : function() {
                $('#export-win').dialog('close');
            }
        } ]
    });
});

function exportRecord(){
    $('#export-win').dialog('open');
}