$package('app.memberCardPriceRel');
app.memberCardPriceRel = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
//	 					{field:'areaCode',title:'区域代码',sortable:true},
	 					{field:'areaName',title:'区域名称',sortable:true,width:100},
	 					{field:'rechargeAmount',title:'充值金额',sortable:true,width:100,
	 						formatter:function(value,row,index){
	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
	 					{field:'payAmount',title:'第三方支付金额',sortable:true,width:100,
	 							formatter:function(value,row,index){
		 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
		 						}},
	 					{field:'isCommon',title:'是否通用 ',sortable:true,width:100,formatter:sys.dicts.text('YESORNO')},
						{field:'startTime',title:'开始时间',sortable:true},
						{field:'endTime',title:'结束时间',sortable:true},
	 					{field:'isDefault',title:'是否默认',sortable:true,width:100,formatter:sys.dicts.text('YESORNO')},
	 					{field:'displayNo',title:'排序号',sortable:true,width:100},
	 					{field:'createTime',title:'创建时间',sortable:true,width:120},
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
	app.memberCardPriceRel.init();
});		

$('#isCommon').combobox({
	onChange : function(newValue,oldValue){
		if(newValue == 1){
			 $("#area_tr").hide();
		}else{
			 $("#area_tr").show();
		}
    } 
}); 