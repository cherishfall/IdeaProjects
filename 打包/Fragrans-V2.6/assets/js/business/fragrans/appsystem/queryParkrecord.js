$package('app.queryParkrecord');
app.queryParkrecord = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'queryParkrecord.do',
                pagination: false,
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						// {field:'id',checkbox:true},
                    	{field:'cityName',title:'区域',sortable:true},
	   			        {field:'parkName',title:'停车点名称',sortable:true},
	   			        {field:'parkRecordId',title:'停车记录id',sortable:true},
                    	{field:'parkDuration',title:'停车时长',sortable:true},
			 			{field:'arriveTime',title:'驶入时间',sortable:true},
                    	{field:'departureTime',title:'驶离时间（未驶离的按当前时间显示）',sortable:true},
                    	{field:'parkFee',title:'停车费用',sortable:true,
                            formatter:function(value,row,index){
                                return "<font style='font-weight:bold;'>￥"+value/100+"</font>";
                            }},
                    	{field:'paidFee',title:'已付金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font style='font-weight:bold;'>￥"+value/100+"</font>";
                            }},
                    	{field:'unpaidFee',title:'未付金额',sortable:true,
                            formatter:function(value,row,index){
                                return "<font style='font-weight:bold;'>￥"+value/100+"</font>";
                            }}
			 	]],
				toolbar:[
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
	app.queryParkrecord.init();
});

function searchClear() {
    $('#searchForm').form('clear');
    $('#plateColor').combobox('setValue', '0');
    $('#pageIndex').numberspinner('setValue', 1);
}
