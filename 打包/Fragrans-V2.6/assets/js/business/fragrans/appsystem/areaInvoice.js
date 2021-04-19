$package('app.areaInvoice');
app.areaInvoice = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				add : function() {
					$('#editForm').form('reset');
					_box.handler.add();
				},
				edit : function() {
					$('#editForm').form('reset');
					editReload();
					_box.handler.edit();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'cityName',title:'城市名称',sortable:true},
			 					{field:'areaName',title:'区域名称',sortable:true},
			 					{field:'longitude',title:'精度',sortable:true},
			 					{field:'latitude',title:'纬度',sortable:true},
			 					{field:'address',title:'具体地址',sortable:true},
			 					{field:'title',title:'标题',sortable:true},
			 					{field:'telphone',title:'电话号码',sortable:true},
			 					{field:'orderNum',title:'排序号',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true},
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
	app.areaInvoice.init();
	$('#cityCode').combotree({
	    onChange:function(newValue,oldValue){
	    	//console.log(newValue);
	    	$('#areaCode').combotree({    
	    	    url: '../area/getArea.do?parentId='+newValue,
	    	    fit : true,
	    	    idField : 'id',
	    	    treeField : 'areaName',
	    	    parentField : 'parentId',
	    	    required: true   
	    	}); 
	    }
	});
});	
function editReload() { // 修改时在Form表单load数据之前，根据父级标签的值（parentId）将级联的标签的值请求到
	var rows = $('#data-list').datagrid('getChecked');
	console.log("row:"+rows[0].cityCode);
		if (rows.length == 1) {
			var row = rows[0];
			$('#areaCode').combotree({    
	    	    url: '../area/getArea.do?cityCode='+row.cityCode,
	    	    fit : true,
	    	    idField : 'id',
	    	    treeField : 'areaName',
	    	    parentField : 'parentId',
	    	    required: true   
	    	}); 
		} 
}