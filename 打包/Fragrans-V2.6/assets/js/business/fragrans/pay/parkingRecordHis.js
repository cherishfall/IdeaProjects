$package('app.parkingRecordHis');
app.parkingRecordHis = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'parkingId',title:'停车记录ID',sortable:true},
			 					{field:'cityCode',title:'城市编码',sortable:true},
			 					{field:'parkCode',title:'停车点编号',sortable:true},
			 					{field:'berthCode',title:'泊位编号',sortable:true},
			 					{field:'address',title:'停车点地址',sortable:true},
			 					{field:'plateNo',title:'车牌号',sortable:true},
			 					{field:'arrivalTime',title:'到达时间',sortable:true},
			 					{field:'departureTime',title:'离开时间',sortable:true},
			 					{field:'parkFee',title:'停车应收费用(分)',sortable:true},
			 					{field:'unpaidFee',title:'未付金额(分)',sortable:true},
			 					{field:'beyondFee',title:'超出金额(分)',sortable:true},
			 					{field:'discountFee',title:'折扣金额（分，省多少钱）',sortable:true},
			 					{field:'feeState',title:'收费状态（00免费01预付费02未交费03预付费超时04特殊停车05包月停车06部分缴费07正常缴费08预缴超额）',sortable:true},
			 					{field:'status',title:'停车状态, 1:未驶离 2:处理中 3：欠费',sortable:true},
			 					{field:'flag',title:'操作标示 ADD：增加 UPDATE:修改 DELETE:删除',sortable:true},
			 					{field:'createdBy',title:'创建人',sortable:true},
			 					{field:'updatedBy',title:'修改人',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true},
			 					{field:'updateTime',title:'更新时间,默认SYSDATE',sortable:true}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add'},
					{id:'btnedit',text:'修改',btnType:'edit'},
					{id:'btndelete',text:'删除',btnType:'remove'}
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
	app.parkingRecordHis.init();
});		