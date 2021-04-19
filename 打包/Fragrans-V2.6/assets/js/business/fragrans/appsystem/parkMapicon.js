$package('app.parkMapicon');
app.parkMapicon = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				add : function() {
					$('#editForm').form('reset');
					_box.handler.add();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			pageSize:20,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'zoomMin',title:'缩放比例最小',sortable:true},
			 					{field:'zoomMax',title:'缩放比例最大',sortable:true},
			 					{field:'countMin',title:'停车点个数最小',sortable:true},
			 					{field:'countMax',title:'停车点个数最大',sortable:true},
			 					{field:'parkPointIcon',title:'空闲停车点图标',sortable:true},
			 					{field:'parkLotIcon',title:'空闲停车场图标',sortable:true},
			 					{field:'subsParkLotIcon',title:'预约停车场图标',sortable:true},
			 					{field:'busyParkPointIcon',title:'繁忙停车点图标',sortable:true},
			 					{field:'busyParkLotIcon',title:'繁忙停车场图标',sortable:true},
			 					{field:'busySubsParkLotIcon',title:'繁忙预约停车场图标',sortable:true},
			 					{field:'staticParkLotIcon',title:'静态停车场图标',sortable:true},
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
	app.parkMapicon.init();
});		