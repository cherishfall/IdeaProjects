$package('app.statMonth');
app.statMonth = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
                pageSize:100,
                pageList: [100,2000],
                pagination: true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',hidden:true},
	 					{field:'dayTime',title:'日期',sortable:true,align:'center'},
	 					{field:'cityName',title:'城市',sortable:true},
	 					{field:'areaName',title:'区域',sortable:true},
	 					{field:'tranCount',title:'交易总笔数',sortable:true},
	 					{field:'tranAmount',title:'交易实收总金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'counterAmount',title:'手续费总额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'refundCount',title:'退款总笔数',sortable:true},
	 					{field:'refundAmount',title:'退款总金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
                    	{field:'refundCounterAmount',title:'退款手续费总金额',sortable:true,
                        	formatter:function(value,row,index){
                            	return "<font font-weight:bold;'>￥"+value/100+"</font>";
                        }},
	 					{field:'totalTranAmount',title:'总利润（实收-退款-手续费+退款手续费）',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'alipayCount',title:'支付宝实收笔数',sortable:true},
	 					{field:'alipayAmount',title:'支付宝实收金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'alipayCounterAmount',title:'支付宝手续费',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'wxpayCount',title:'微信实收笔数',sortable:true},
	 					{field:'wxpayAmount',title:'微信实收金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'wxpayCounterAmount',title:'微信手续费',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'cmbpayCount',title:'一网通实收笔数',sortable:true},
	 					{field:'cmbpayAmount',title:'一网通实收金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'cmbpayCounterAmount',title:'一网通手续费',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'mcpaySuccessCount',title:'会员卡支付成功笔数',sortable:true},
	 					{field:'mcpaySuccessAmount',title:'会员卡支付成功金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
							{field:'monthlySuccessCount',title:'包月支付成功笔数',sortable:true},
							{field:'monthlySuccessAmount',title:'包月支付成功金额',sortable:true,
								formatter:function(value,row,index){
									return "<font font-weight:bold;'>￥"+value/100+"</font>";
								}},
							{field:'innopaySuccessCount',title:'收费宝支付成功笔数',sortable:true},
							{field:'innopaySuccessAmount',title:'收费宝支付成功金额',sortable:true,
								formatter:function(value,row,index){
									return "<font font-weight:bold;'>￥"+value/100+"</font>";
								}},
	 					{field:'balancepayCount',title:'余额实收笔数',sortable:true},
	 					{field:'balancepayAmount',title:'余额实收金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
	 					{field:'ticketpayCount',title:'停车券支付笔数',sortable:true},
	 					{field:'ticketpayAmount',title:'停车券抵扣金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
	 					}},
						{field:'alipayRefundSucCount',title:'支付宝退费成功笔数',sortable:true},
						{field:'alipayRefundSucAmount',title:'支付宝退费成功金额',sortable:true,
							formatter:function(value,row,index){
								return "<font font-weight:bold;'>￥"+value/100+"</font>";
                        }},
						{field:'wxpayRefundSucCount',title:'微信退费成功笔数',sortable:true},
						{field:'wxpayRefundSucAmount',title:'微信退费成功金额',sortable:true,
							formatter:function(value,row,index){
								return "<font font-weight:bold;'>￥"+value/100+"</font>";
                        }},
						{field:'cmbpayRefundSucCount',title:'一网通退费成功笔数',sortable:true},
						{field:'cmbpayRefundSucAmount',title:'一网通退费成功金额',sortable:true,
							formatter:function(value,row,index){
								return "<font font-weight:bold;'>￥"+value/100+"</font>";
                        }},
						{field:'mcpayRefundSucCount',title:'会员卡退费成功笔数',sortable:true},
						{field:'mcpayRefundSucAmount',title:'会员卡退费成功金额',sortable:true,
							formatter:function(value,row,index){
								return "<font font-weight:bold;'>￥"+value/100+"</font>";
                        }},
	 					{field:'createTime',title:'创建时间',sortable:true}
			 	]],
                onLoadSuccess: function(data){
                    //添加“合计”列
                    $('#data-list').datagrid('appendRow', {
                        dayTime: '<span style="font-weight: bold;">总计</span>',
                        tranCount: compute("tranCount"),
                        tranAmount: compute("tranAmount"),
                        counterAmount: compute("counterAmount"),
                        refundCounterAmount: compute("refundCounterAmount"),
                        refundCount: compute("refundCount"),
                        refundAmount: compute("refundAmount"),
                        totalTranAmount: compute("totalTranAmount"),
                        alipayCount: compute("alipayCount"),
                        alipayAmount: compute("alipayAmount"),
                        alipayCounterAmount: compute("alipayCounterAmount"),
                        wxpayCount: compute("wxpayCount"),
                        wxpayAmount: compute("wxpayAmount"),
                        wxpayCounterAmount: compute("wxpayCounterAmount"),
                        cmbpayCount: compute("cmbpayCount"),
                        cmbpayAmount: compute("cmbpayAmount"),
                        cmbpayCounterAmount: compute("cmbpayCounterAmount"),
                        mcpaySuccessCount: compute("mcpaySuccessCount"),
                        mcpaySuccessAmount: compute("mcpaySuccessAmount"),
                        monthlySuccessCount: compute("monthlySuccessCount"),
                        monthlySuccessAmount: compute("monthlySuccessAmount"),
                        innopaySuccessCount: compute("innopaySuccessCount"),
                        innopaySuccessAmount: compute("innopaySuccessAmount"),
                        balancepayCount: compute("balancepayCount"),
                        balancepayAmount: compute("balancepayAmount"),
                        ticketpayCount: compute("ticketpayCount"),
                        ticketpayAmount: compute("ticketpayAmount"),
                        alipayRefundSucCount: compute("alipayRefundSucCount"),
                        alipayRefundSucAmount: compute("alipayRefundSucAmount"),
                        wxpayRefundSucCount: compute("wxpayRefundSucCount"),
                        wxpayRefundSucAmount: compute("wxpayRefundSucAmount"),
                        cmbpayRefundSucCount: compute("cmbpayRefundSucCount"),
                        cmbpayRefundSucAmount: compute("cmbpayRefundSucAmount"),
                        mcpayRefundSucCount: compute("mcpayRefundSucCount"),
                        mcpayRefundSucAmount: compute("mcpayRefundSucAmount")
                    });
                }
			}},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

//指定列求和
function compute(colName) {
    var rows = $('#data-list').datagrid('getRows');
    var total = 0;
    for (var i = 0; i < rows.length; i++) {
        total += parseFloat(rows[i][colName]);
    }
    return total;
}

$(function(){
	app.statMonth.init();
});

function generateStatMonth() {
	var param = $('#searchForm').serializeObject();
	console.log(param);
	var dayTime = param.dayTime;
	//验证生成月报时间
	if(dayTime == null || dayTime == '' || dayTime == undefined){
		$.messager.show({
			title : '提示',
			msg : '请选择月份'
		});
		return;
	}
	$.messager.confirm("提示", "确认根据查询条件生成月报表?", function(r) {
		if (r) {
			$.messager.progress({
	            title:'请稍后',
	            msg:'正在生成月报表...'
			});
			$('#searchForm').form('submit', {
				url : 'generateStatMonth.do',
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

function exportStatMonth(){
	var param = $('#searchForm').serializeObject();
	var dayTime = param.dayTime;
	var areaCode = param.areaCode;
	//验证月份
	var month = /^(\d{4})-(\d{2})$/;
	if(dayTime!=''&&dayTime!=null&&dayTime!=undefined&&!month.test(dayTime)){
		$.messager.show({
			title : '提示',
			msg : '请输入合理的月份（格式为2016-07）'
		});
		return;
	}
	//导出月报表
	$.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
		if (r) {
			window.open('exportStatMonth.do?dayTime='+dayTime+
					'&areaCode='+areaCode);
		}
	});
}
