$package('app.flowDataCollection');
app.flowDataCollection = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'accessId',title:'接入商ID',sortable:true},
			 					{field:'parkCode',title:'停车点编码',sortable:true},
			 					{field:'berthNumIdle',title:'空闲泊位数 ',sortable:true},
			 					{field:'inOutFlag',title:'车辆进出标识 -1：进车，1：出车 ',sortable:true},
			 					{field:'plateNo',title:'车牌号',sortable:true},
			 					{field:'passageNo',title:'通道号',sortable:true},
			 					{field:'syncStatus',title:'同步状态 0：未同步 1：正在同步 2：同步完成',sortable:true},
			 					{field:'eventTime',title:'事件发生时间',sortable:true},
			 					{field:'createTime',title:'记录创建时间',sortable:true}
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
	app.flowDataCollection.init();
});		