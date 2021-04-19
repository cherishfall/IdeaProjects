$package('appsystem.activity');
appsystem.activity = function(){
	var _box = null;
	var _this = {
		activityEdit:function(rows){
			//修改时，根据活动主题加载活动区域树的数据
			$('#ztree').dialog({    
				maximizable:true,
			    href: '../view/fragrans/appsystem/excheck.jsp?param='+rows[0].activityTopicId+'&objId='+rows[0].id,    
			});
			_box.handler.edit();
		},
		config:{
			event:{
				save:function(){
					var param = $('#editForm').serializeObject();
					var startTime = param.startTime;
					var endTime = param.endTime;
					if (endTime < startTime) {
						$.messager.show({
							title : '提示',
							msg : "开始时间不能大于结束时间"
						});
						return;
					}
					_box.handler.save();
				},
				add:function(){
					//点击添加时，显示关联主题和活动城市输入框
					_box.handler.add();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						//{field:'cityCode',hidden:true},
//	 					{field:'areaName',title:'城市名称',sortable:true},
						{field:'activityName',title:'活动标题',sortable:true},
	 					{field:'areaCodes',title:'活动城市',sortable:true,
							formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
	 					{field:'topicName',title:'活动主题',sortable:true},
			 					{field:'content',title:'活动内容',sortable:true},
			 					{field:'startTime',title:'活动开始时间',sortable:true,
			 						formatter:function(value,row,index){
										return value.split(" ")[0];
									}},
			 					{field:'endTime',title:'活动结束时间',sortable:true,
										formatter:function(value,row,index){
											return value.split(" ")[0];
										}},
			 					{field:'status',title:'活动状态',sortable:true,
			 						formatter : sys.dicts.text('ACTIVITY_STATUS')},
		 						{field:'dayTicketCount',title:'每日发券上限',sortable:true},
			 					{field:'allTicketCount',title:'发券上限',sortable:true},
			 					{field:'activityType',title:'活动类型',sortable:true,
			 						formatter : sys.dicts.text('ACTIVITY_TYPE')	},
			 					{field:'activityUrl',title:'活动URL外连接',sortable:true,
			 							formatter: function(value,row,index){
						     				if (value!=null&&value.length > 15){
						     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
						     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
						     				}else{
						     					return value;
						     				}
						     		    }},
			 					{field:'activityCodeName',title:'活动代码名称',sortable:true},
			 					{field:'activityCode',title:'活动代码',sortable:true},
			 					{field:'activityPreferentialType',title:'优惠类型',sortable:true,
			 						formatter : sys.dicts.text('PREFERENTIAL_TYPE')}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add'},
					{id:'btnedit',text:'修改',btnType:'edit',
						handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								_this.activityEdit(rows);
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
						}
					},
					{id:'btndelete',text:'删除',btnType:'remove'}
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#ztree').dialog({
				buttons : [ {
					text : '确定',
					handler : function() {
						$('#ztree').dialog('close');
					}
				}
				]
			});
		}
	}
	return _this;
}();

//改变活动主题时，活动区域下拉框显示的是该活动主题所属的全部区域
$('#topicNameAdd').combobox({
	title:'列表',
	url:'getTopic.do',
	valueField : 'id',
	textField : 'text',
	onChange:function(newValue, oldValue){
		$('#ztree').dialog({    
			maximizable:true,
		    href: '../view/fragrans/appsystem/excheck.jsp?param='+newValue+'&objId=""',    
		});
	}
});

//加载所有的活动代码
$('#activityCode').combobox({
	title:'列表',
	url:'getActivityCode.do',
	fit : true,
	valueField : 'id',
	textField : 'text',
});
function ztreeAdd(){
	//先判断有无选择关联主题
	var topicNameAdd = $('#topicNameAdd').combobox('getValue');
	if(topicNameAdd==''||topicNameAdd==null){
		 $.messager.alert('提示','请先选择关联主题');  
		 return;
	}
	$('#ztree').dialog("open");
}

//获取停车场，待修改
$('#parkName').combobox({
	url:'loadPark.do',
	fit : true,
	panelHeight : '200',
	valueField:'id',    
    textField:'text'
});

$(function(){
	appsystem.activity.init();
});		

