$package('sys.log');
sys.log = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				idField : 'id',
  				title:'日志列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			keepChoice : true,
	   			queryParams:{
	   				timeFrom : getNowDayMorning(),
	   				timeTo : getNextDay(getNowDayMorning()),
	   			},
	   			columns:[[
						{field:'ck',checkbox:true},
						{field:'id',hidden:true},
						{field:'level',title:'日志级别',width:70,sortable:true},
						{field:'opDesc',title:'操作描述',width:200,sortable:true},
						{field:'account',title:'操作用户',width:70,sortable:true},
						{field:'ipAddress',title:'操作者所在的IP地址',width:120,sortable:true},
						{field:'createTime',title:'创建时间',width:120,sortable:true}
						
				]],
				toolbar:[
					{id:'btndelete',text:'删除',btnType:'remove'}
				]
			}
		},
		init:function(){
			$('#timeFrom').datetimebox({
				onChange : function(nDate, oDate) {
					$('#timeTo').datetimebox('setValue', getNextDay(nDate));
				}
			});
			$('#timeFrom').datetimebox('setValue', getNowDayMorning());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	sys.log.init();
	
});		