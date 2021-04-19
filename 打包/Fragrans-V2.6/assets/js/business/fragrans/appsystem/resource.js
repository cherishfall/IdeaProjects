$package('app.resource');
app.resource = function(){
	var _box = null;
	var _this = {
		resourceEdit:function(rows){
			$.ajax({
				url : 'getId.do',
				type : 'post',
				dataType : 'json',
				data : {
					id : rows[0].id
				},
				success : function(result) {
					$('#editForm').form('clear');
					if(rows[0].resourceType==1){
						//资源类型为1，即为图片时，显示资源尺寸和资源下载路径输入框
						show();
					}else{
						//资源类型为2，即为文字时，隐藏资源尺寸和资源下载路径输入框
						hid();
					}
					$('#edit-win').dialog('open');
					var data = result.data;
					//修改时，根据多选框的内容自动勾选下拉框中的数据
					if (result.data.versionIds.length == 0) {
						$('#versionCode').combobox('reload');
					} else {
						$.each(result.data.versionIds, function(i, versionId) {
							$("#versionCode_" + versionId).attr("checked", true);
						});
					}
					if (result.data.resourceSizes.length == 0) {
						$('#resourceSize').combotree('reload');
					} else {
						$.each(result.data.resourceSizes, function(i, resourceSize) {
							$("#resourceSize_" + resourceSize).attr("checked", true);
						});
					}
					if (result.data.cityIds.length == 0) {
						$('#areaNameAdd').combotree('reload');
					} else {
						$.each(result.data.cityIds, function(i, cityId) {
							$("#areaName_" + cityId).attr("checked", true);
						});
					}
					$('#editForm').form('load',{id:data.id,resourceName:data.resourceName,appType:data.appType,resourceName:data.resourceName,resourceFilename:data.resourceFilename,
						resourceUrl:data.resourceUrl,resourceDesc:data.resourceDesc,resourceType:data.resourceType,
						versionCode:data.versionIds,areaName:data.cityIds,resourceSize:data.resourceSizes});
				}
			});
		},
		config:{
			event:{
				save:function(){
					 var resourceDesc = $('#resourceDesc').val();
					 if(resourceDesc==''){
						 $.messager.alert('提示','资源描述不能为空');  
						 return;
					 }
					_box.handler.save();
				},
				add:function(){
//					$("#versionCode").combobox('clear');
					//添加时，默认资源类型为图片
					show();
					_box.handler.add();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'cityNames',title:'城市名称',sortable:true,
							formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
			     				}else{
			     					return value;
			     				}
							}},
		 					{field:'appType',title:'应用类型',sortable:true,formatter:sys.dicts.text('resource_apptype')},
		 					{field:'versionCodes',title:'版本号',sortable:true,
		 						formatter: function(value,row,index){
				     				if (value!=null&&value.length > 15){
				     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
				     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
				     				}else{
				     					return value;
				     				}
				     		    }},
		 					{field:'resourceName',title:'资源名称',sortable:true},
		 					{field:'sizes',title:'资源尺寸',sortable:true},
		 					{field:'resourceType',title:'资源类型',sortable:true,formatter:sys.dicts.text('RESOURCE_TYPE')},
		 					{field:'resourceFilename',title:'资源文件名称',sortable:true},
		 					{field:'resourceUrl',title:'资源下载路径',sortable:true},
		 					{field:'resourceDesc',title:'资源描述',sortable:true},
//			 				{field:'createTime',title:'创建时间',sortable:true},
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add'},
					{id:'btnedit',text:'修改',btnType:'edit',
						handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								$('#versionCode').combobox({
									url:'getVersionCode.do?appType='+rows[0].appType,
									editable:false,
									panelHeight : '200',
									valueField:'id',    
								    textField:'versionCode',
								    multiple : true,
									formatter : function(row) {
										var s = "<span><input type='checkbox' class='selectId' style='vertical-align: middle' id='versionCode_"
												+ row.id
												+ "'>"
												+ row.versionCode
												+ "<span>";
										return s;
									},
									onSelect : function(record) {
										$("#versionCode_" + record.id).attr(
												"checked", true);
									},
									onUnselect : function(record) {
										$("#versionCode_" + record.id).attr(
												"checked", false);
									}
								});
								_this.resourceEdit(rows);
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

$(function(){
	app.resource.init();
	//加载城市复选框数据
	$('#areaNameAdd').combotree({
		url:'../area/getCity.do',
		fit : true,
		idField : 'id',
		panelHeight : '200',
		treeField : 'areaName',
		parentField : 'parentId',
		multiple : true
	});
});		

//根据选择应用类型匹配所属的版本号
$('#appType').combobox({
	onChange:function(newValue, oldValue){
		$('#versionCode').combobox({
			url:'getVersionCode.do?appType='+newValue,
			editable:false,
			panelHeight : '200',
			valueField:'id',    
		    textField:'versionCode',
		    multiple : true,
			formatter : function(row) {
				var s = "<span><input type='checkbox' class='selectId' style='vertical-align: middle' id='versionCode_"
						+ row.id
						+ "'>"
						+ row.versionCode
						+ "<span>";
				return s;
			},
			onSelect : function(record) {
				$("#versionCode_" + record.id).attr(
						"checked", true);
			},
			onUnselect : function(record) {
				$("#versionCode_" + record.id).attr(
						"checked", false);
			}
		});
	}
});

//加载资源尺寸复选框数据
$('#resourceSize').combotree({
	url:'getResourceSize.do',
	editable:false,
	panelHeight : '200',
	valueField:'id',    
    textField:'codeText',
    parentField : 'parentId',
    multiple : true,
});

//显示资源尺寸和资源下载路径输入框
function show(){
	$("#size").show();
	$("#loadUrl").show();
	$("#resourceSizeDiv").show();
	$("#resourceUrlDiv").show();
}

//隐藏资源尺寸和资源下载路径输入框
function hid(){
	$("#size").hide();
	$("#loadUrl").hide();
	$("#resourceSizeDiv").hide();
	$("#resourceUrlDiv").hide();
	//清空资源尺寸和资源下载路径输入框
	$("#resourceSize").combotree('clear');
	$("#resourceUrl").val('');
}