$package('base.quartzDetail');
base.quartz = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
	   			            {field:'id',hidden:true},
							{field:'quartzId',title:'任务编号',sortable:true},
							{field:'name',title:'任务名称（类名）',sortable:true},
							{field:'excuteTime',title:'定时执行时间'},
							{field:'result',title:'执行结果',sortable:true,styler:function(value,row,index){
								if(value == 1){
									return 'color:red;';  
								}
							},formatter:sys.dicts.text('JOB_RESULT')},
							{field:'mission',title:'执行内容',hidden:true},
							{field:'note',title:'备注',sortable:true},
							{field:'handle',title:'查看',sortable:true,formatter:function handleDetail(value,row,index){
								var _val = ""; 
								_val = " &nbsp;<a href='javascript:void(0);' onclick=\"openResultDialog('"+row.mission+"')\" >查看详情</a> ";
								return _val;
							}}
			 	]] 
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
	base.quartz.init();
	
	//时间格式 化
	$('#startExecuteTime').datebox().datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var c_date = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return c_date>=date;
		}
	});
	
	$('#endExecuteTime').datebox().datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var c_date = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return c_date>=date;
		}
	});
	// 默认时间
	formatterDate = function(date) {
		var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
		var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
		+ (date.getMonth() + 1);
		return date.getFullYear() + '-' + month + '-' + day;
	};
	$('#startExecuteTime').datebox('setValue', formatterDate(new Date()));
	$('#endExecuteTime').datebox('setValue', formatterDate(new Date()));
	
});	

function openResultDialog(resultStr){
	  var missionDetailWin = $('#missionDetailWin').window({
		    title: '执行详情',
		    width: 650,
		    height: 400,
//		    top: ($(window).height() - 650) * 0.5,
//		    left: ($(window).width() - 400) * 0.5,
		    shadow: true,
		    modal: true,
		    iconCls: 'icon-search',
		    closed: true,
		    minimizable: false,
		    maximizable: false,
		    collapsible: false
		});
	  missionDetailWin.empty();
	  missionDetailWin.text(resultStr);
	  missionDetailWin.window('open');
}
 
