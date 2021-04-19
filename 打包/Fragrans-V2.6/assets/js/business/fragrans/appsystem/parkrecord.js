$package('app.orderParkrecord');
app.orderParkrecord = function(){
	var _box = null;
	var _this = {
		detail : function(rows) {
			$('#detail').dialog({    
				maximizable:true,
			    href: '../view/fragrans/appsystem/parkrecordDetail.jsp?parkrecordId='+rows[0].parkrecordId+'&cityCode='+rows[0].cityCode,    
			});
			$('#detail').dialog("open");
		},
		config:{
			event : {
				search : function() { //条件查询验证
					var startEventTime = $('#startTime').datetimebox('getValue');
					var endEventTime = $('#endTime').datetimebox('getValue');
					if (startEventTime > endEventTime) {
						sys.alert('警告', '起始时间大于结束时间.', 'warning');
						return;
					}
					var start  = new Date(startEventTime.replace(/-/g,"/")).getTime();
					var end = new Date(endEventTime.replace(/-/g,"/")).getTime();
					var endDate = new Date(end);
					var startLon = endDate.setMonth(endDate.getMonth()-3);
					//alert(formatDateToStr(startLon));
					if(start < startLon){
						sys.alert('警告', '起始时间和结束时间之差大于3个月.', 'warning');
						return;
					}
                    var param = $("#searchForm").serializeObject();
                    var opts = $("#data-list").datagrid("options");
                    opts.url = "dataList.do";
                    $('#data-list').datagrid('reload',param);

					/*var Grid = $('#data-list');
					var Form = {
					  search: $("#searchForm")
					};
					var param = Form.search.serializeObject();
					Grid.datagrid('reload',param);*/
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'',
	   			fitColumns:true,
	   			queryParams:{
	            	startTime :getMonthFirstDatetime() ,
	            	endTime : new Date().pattern("yyyy-MM-dd HH:mm:ss"),
	   			},
                onLoadSuccess: function(data){
                    if(data.rows.length==0){
                        var body = $(this).data().datagrid.dc.body2;
                        body.find('table tbody').append('<tr><td width="'+body.width()+'" style="height: 25px; padding:10px;text-align: left;"  colspan='+5+'>没有任何结果数据显示！</td></tr>');
                    }
                },
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						//{field:'id',checkbox:true},
	   			        {field:'parkName',title:'停车点名称',sortable:true,width:140},
	   			        {field:'parkrecordId',title:'停车记录id',sortable:true,width:140},
	 					{field:'areaName',title:'区域名称',sortable:true,width:70},
			 			{field:'plateNo',title:'车牌号',sortable:true,width:100},
			 			{field:'arrivalTime',title:'驶入时间',sortable:true,width:140}
			 	]],
				toolbar:[
					{id:'btndetail',text:'停车记录详情',btnType:'detail',iconCls : 'ext-icon-report_add',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								_this.detail(rows);
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
					}},
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
            $("#data-list").datagrid('appendRow', { parkName: '<div style="text-align:center;">页面首次加载不执行查询操作！</div>' }).datagrid('mergeCells', { index:0, field: 'parkName', colspan: 5 })
		}
	}
	return _this;
}();

function getMonthFirstDatetime() {
    var date = new Date();
    date.setTime(date.getTime());
    return date.pattern("yyyy-MM") + "-01 00:00:00";
}

$(function(){
	app.orderParkrecord.init();
	var date = new Date();
	$('#endTime').datetimebox('setValue',date.pattern("yyyy-MM-dd HH:mm:ss"));
	$('#startTime').datetimebox('setValue',getMonthFirstDatetime());
	
	$('#data-list').datagrid({
	    view: detailview,
	    detailFormatter:function(index,row){
	        return '<div style="padding:2px"><table class="ddv"></table></div>';
	    }, 
	    onExpandRow: function(index,row){
	        var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
	        ddv.datagrid({
	            url:'../order/queryByParkrecordId.do',
	            queryParams: {  
	            	parkrecordId : row.parkrecordId,
	            	cityCode : row.cityCode
	            },
	            fitColumns:true,
	            rownumbers:true,
	            singleSelect:true,
	            height:'auto',
	            onDblClickRow : function(index, data) {
	            	var orderNo = data.orderNo;
	            	$('#paylog').dialog({    
	    				maximizable:true,
	    				href: '../view/fragrans/appsystem/orderDetail.jsp?orderNo='+orderNo,    
	    			});
	    			$('#paylog').dialog("open");
				},
	            columns:[[
	                {field:'id',title:'id',hidden:'true'},
	               	{field:'userAccount',title:'用户账号',width:90},
	                {field:'cityName',title:'城市名称',width:60},
	                {field:'areaName',title:'区域名称',width:60},
	                {field:'orderNo',title:'交易订单编号',width:150},
	                {field:'payType',title:'支付方式',width:70,formatter:sys.dicts.text('PAY_METHOD')},
	                {field:'price',title:'订单金额',width:70,
	                	formatter:function(value,row,index){
 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
 						}
	                },
	                {field:'payTime',title:'支付时间',width:150},
	                {field:'orderStatus',title:'订单状态码',width:80,formatter:sys.dicts.text('ORDER_STATUS')},
	                {field:'notifyStatus',title:'通知状态',width:70,formatter:sys.dicts.text('NOTIFY_STATUS'),
	                	formatter:function(value,row,index){
	 						if (row.orderStatus==200){
	 							return sys.dicts.text('NOTIFY_STATUS',value);
	 						} else {
	 							return "";
	 						}
 						}
	                },
	                {field:'isComplate',hidden : true},
	                //{field:'isComplate',title:'退款状态',width:80,formatter:sys.dicts.text('IS_REFUND')},
	                {field : 'sucRefund',title:'退款金额',width:80,
	                	formatter:function(value,row,index){
	                		if(row.orderStatus==200){
								if(row.count>0&row.sucRefund>0){
			                		if(value>0){
			                			return "<font style='color:#37d03f;font-weight:bold;'>￥"+value/100+"</font>";
			                		}else{
			                			return "";
			                		}
								}
	                		}
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

function toDecimal(x) { 
    var f = parseFloat(x); 
    if (isNaN(f)) { 
      return 0; 
    } 
    f = Math.round(x*100)/100/100; 
    return f; 
  }