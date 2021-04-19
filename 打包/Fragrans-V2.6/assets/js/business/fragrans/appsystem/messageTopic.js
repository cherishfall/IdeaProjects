$package('app.messageTopic');
app.messageTopic = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'messageTopicName',title:'消息分类名称',sortable:true},
	 					{field:'areaCodes',title:'城市名称',sortable:true,
							formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
	 					{field:'topicType',title:'消息分类类型',sortable:true,formatter:sys.dicts.text('TOPIC_TYPE')},
	 					{field:'displayconf',title:'显示策略',sortable:true,formatter:sys.dicts.text('DISPLAYCONF')},
	 					{field:'isCommon',title:'是否通用',sortable:true,formatter:sys.dicts.text('YESORNO')},
	 					{field:'orderNum',title:'排序号',sortable:true}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',
						handler:function(){
							$('#cityCode').combobox('reload'); 
							_box.handler.add();
						}
					},
					{id:'btnedit',text:'修改',btnType:'edit',
						handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							$('#cityCode').combobox('reload');
							if (rows.length == 1) {
								_box.handler.edit(function(result) {
									$('#editForm').form('load', result.data);
									var cityCodeArr = result.data.cityCodeArr;
									if (cityCodeArr!=null&&cityCodeArr.length == 0) {
										$('#cityCode').combobox('reload');
									} else {
										//遍历数组勾选下拉框
										$.each(cityCodeArr, function(i, cityCode) {
										$("#selectId_" + cityCode).attr("checked", true);
									});
									}
								});
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
						}},
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

$('#cityCode').combobox({
	url:'../area/getCity.do',
	valueField : 'id',
	textField : 'text',
	multiple : true,
	width : 200,
	formatter : function(row) {
		var s = "<span><input type='checkbox' class='selectId' style='vertical-align: middle' id='selectId_"
				+ row.id
				+ "'>"
				+ row.text
				+ "<span>";
		return s;
	},
	onSelect : function(record) {
		$("#selectId_" + record.id).attr(
				"checked", true);
	},
	onUnselect : function(record) {
		$("#selectId_" + record.id).attr(
				"checked", false);
	}
});

$(function(){
	app.messageTopic.init();
});		