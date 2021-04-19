$package('app.activityShareUser');
app.activityShareUser = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ 
						{field:'id',checkbox:true},
						{field:'activityShareId',title:'分享活动ID',sortable:true,width:130},
	 					{field:'activityShareName',title:'分享活动名称',sortable:true,width:70},
			 					{field:'userAccount',title:'用户账号',sortable:true,width:70},
			 					{field:'source',title:'分享介质',sortable:true,width:50,
			 						formatter:sys.dicts.text('SHARE_SOURCE')},
			 					{field:'parkrecordId',title:'停车记录编号',sortable:true,width:50},
			 					{field:'orderNo',title:'订单编号',sortable:true,width:50},
			 					{field:'status',title:'通知类型',sortable:true,width:50,
			 						formatter:sys.dicts.text('SHARE_NOTIFY_TYPE')},
			 					{field:'createTime',title:'创建时间',sortable:true,width:70},
			 	]],
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
	app.activityShareUser.init();
	$('#data-list').datagrid({
		view: detailview,
		detailFormatter: function(index,row){
			return '<div style="padding:2px"><table class="ddv"></table></div>'
		},
	    onExpandRow: function(index,row){
	        var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
	        ddv.datagrid({
	    	 fitColumns:true,  
             singleSelect:true,  
             height:'auto',
	            url:'getReceiveRecords.do',
	            queryParams: {  
	            	shareUserId : row.id
	            },
	            columns:[[
						{field:'fromUserAccount',title:'来源用户账号',sortable:true,width:80},
						{field:'source',title:'分享介质',sortable:true,width:80,
							formatter:sys.dicts.text('SHARE_SOURCE')},
						{field:'toUseraccount',title:'领取用户号码',sortable:true,width:80},
						{field:'isReg',title:'是否注册',sortable:true,width:80,
							formatter:sys.dicts.text('YESORNO')},
						{field:'regTime',title:'注册时间',sortable:true,width:80},
						{field:'isGetticket',title:'是否领券',sortable:true,width:80,
							formatter:sys.dicts.text('YESORNO')},
						{field:'ticketName',title:'领取优惠券名称',sortable:true,width:80},
						{field:'getticketTime',title:'领券时间',sortable:true,width:80},
						{field:'isHistoryUser',title:'是否历史用户',sortable:true,width:80,
							formatter:sys.dicts.text('YESORNO')},
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

$('#activityShareId').combotree({
	title:'列表',
	url:'getActivityShareTree.do',
	fit : true,
	panelHeight : '100',
	treeField : 'activityShareName',
	idField : 'id',
});