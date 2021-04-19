$package('app.orderMiddle');
app.orderMiddle = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			queryParams:{
	   				statdate : getYesterDayMorning(),
	   			},
	   			columns:[[
	   			          		{field:'dayTime',title:'日期',sortable:true,width:90},
			 					{field:'areaName',title:'区域',sortable:true,width:140},
			 					{field:'tranCount',title:'交易总笔数',sortable:true,width:90},
			 					{field:'tranAmount',title:'交易总金额',sortable:true,width:90,
			 						formatter:function(value,row,index){
		 							return "<font>￥"+value/100+"</font>";
		 						}},
			 					{field:'totalTranAmount',title:'实付总金额',sortable:true,width:90,
			 						formatter:function(value,row,index){
			 							return "<font>￥"+value/100+"</font>";
			 						}},
		 						{field:'ticketpayAmount',title:'优惠券抵扣总金额',width:90,
			 						formatter:function(value,row,index){
			 							return "<font>￥"+value/100+"</font>";
			 						}},
			 	]],
				toolbar:[
					{id:'btnExport',text:'导出账单',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#orderMiddleListForm').form('reset');
							orderMiddleList();
						}},
				]
			}
		},
		init:function(){
			$('#statdate').datebox('setValue', getYesterDayMorning());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	app.orderMiddle.init();
	$('#data-list').datagrid({
	    view: detailview, 
	    detailFormatter:function(index,row){
	        return '<div style="padding:2px"><table class="ddv"></table></div>';
	    }, 
	    onExpandRow: function(index,row){
	        var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
	        ddv.datagrid({
	            url:'../orderMiddle/queryByDateTimeAndAreaName.do',
	            queryParams: {  
	            	areaCode : row.areaCode,
	            	dayTime: row.dayTime
	            },
	            fitColumns:true,
	            rownumbers:true,
	            singleSelect:true,
	            height:'auto',
	            /*鼠标双击事件*/
	            /*onDblClickRow : function(index, data) {
	            	var orderNo = data.orderNo;
	            	$('#paylog').dialog({    
	    				maximizable:true,
	    				href: '../view/fragrans/appsystem/orderDetail.jsp?orderNo='+orderNo,    
	    			});
	    			$('#paylog').dialog("open");
				},*/
				columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
				        {field:'id',title:'id',hidden:'true'},
	 					{field:'areaName',title:'区域',width:90},
	 					{field:'payType',title:'支付方式',width:90,formatter:sys.dicts.text('payType')},
	 					{field:'payCount',title:'交易笔数',width:90},
	 					{field:'parkSum',title:'应付金额',width:90,
	 						formatter:function(value,row,index){
	 							return "<font>￥"+value/100+"</font>";
	 						}},
	 					{field:'priceSum',title:'实付金额',width:90,
	 						formatter:function(value,row,index){
	 							return "<font>￥"+value/100+"</font>";
	 						}},
 						{field:'ticketSum',title:'优惠券抵扣金额',width:90,
	 						formatter:function(value,row,index){
	 							return "<font>￥"+value/100+"</font>";
	 						}},
				 	]],
	            onResize:function(){
	                $('#data-list').datagrid('fixDetailRowHeight',index);
	            },
	            onLoadSuccess:function(){
	                setTimeout(function(){
	                    $('#data-list').datagrid('fixDetailRowHeight',index);
	                },0);
	            }
	        });
	        $('#data-list').datagrid('fixDetailRowHeight',index);
	    }
	});
});	

$(function(){
	app.orderMiddle.init();
	// 导出账单
	$('#orderMiddleList').dialog({
		buttons : [{
			text : '导出',
			handler : function() {
				var param = $('#orderMiddleListForm').serializeObject();
				var dayTime = param.dayTime;
				var cityId = param.cityId;
				//验证导出账单的时间和地点
				if(dayTime == null || dayTime == '' || dayTime == undefined
						|| cityId == null || cityId == '' || cityId == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择要导出的时间和区域'
					});
					return;
				}
				$.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r){
					if (r) {
						window.open('orderMiddle.do?dayTime=' + dayTime
								+ '&cityId=' + cityId);
					}
				});
				$('#orderMiddleList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#orderMiddleList').dialog('close');
			}
		}]
	});
});

function orderMiddleList() {
	$('#orderMiddleList').dialog('open');
}