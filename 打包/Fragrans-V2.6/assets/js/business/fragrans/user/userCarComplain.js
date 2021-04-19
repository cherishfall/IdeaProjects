$package('app.userCarComplain');
app.userCarComplain = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'cityCode',title:'',sortable:true},
			 					{field:'userId',title:'用户ID',sortable:true},
			 					{field:'plateNo',title:'车牌号',sortable:true},
			 					{field:'plateColor',title:'车牌颜色（单个）（默认蓝色0 ；黄1；白2；黑3）',sortable:true},
			 					{field:'driverId',title:'车辆行驶证号',sortable:true},
			 					{field:'remark',title:'申诉备注',sortable:true},
			 					{field:'drivingImage',title:'车辆行驶证照片',sortable:true},
			 					{field:'status',title:'处理状态（0未受理1受理中2已完成）',sortable:true},
			 					{field:'processUser',title:'处理人',sortable:true},
			 					{field:'processSuggestion',title:'处理意见',sortable:true},
			 					{field:'flag',title:'操作标示 ADD：增加 UPDATE:修改 DELETE:删除',sortable:true},
			 					{field:'updatedBy',title:'修改人',sortable:true},
			 					{field:'createTime',title:'创建时间,默认SYSDATE',sortable:true},
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
	app.userCarComplain.init();
});		