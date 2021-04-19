$package('app.userParkingRecord');
app.userParkingRecord = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'parkingRecordId',title:'停车支付记录ID',sortable:true},
			 					{field:'userId',title:'用户ID',sortable:true},
			 					{field:'isPaid',title:'是否支付 1：未支付 2：支付过 3：已结清',sortable:true},
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
	app.userParkingRecord.init();
});		