$package('app.parkAggregation');
app.parkAggregation = function(){
	var _box = null;
	var _this = {
		generation:function(){
			//$('#data-list').datagrid('reload');
			$.ajax({
				url : 'generation.do',
				type : 'post',
				success : function(result) {
					// var res = $.paresJSON(result);
					$.messager.progress('close');
					$.messager.show({
						title : '提示',
						msg : result.msg
					});
					if (result.success) {
						$('#data-list').datagrid('reload');
					}
				}
			});
		},
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'cityName',title:'所在城市',sortable:true},
			 					{field:'zoomLevel',title:'缩放级别',sortable:true},
			 					{field:'longitudeGaode',title:'高德经度',sortable:true},
			 					{field:'latitudeGaode',title:'高德纬度',sortable:true},
			 					{field:'longitudeBaidu',title:'百度经度',sortable:true},
			 					{field:'latitudeBaidu',title:'百度纬度',sortable:true},
			 					{field:'extendCenterLongitudeGaode',title:'高德中心点经度',sortable:true},
			 					{field:'extendCenterLatitudeGaode',title:'高德中心点纬度',sortable:true},
			 					{field:'extendCenterLongitudeBaidu',title:'百度中心点经度',sortable:true},
			 					{field:'extendCenterLatitudeBaidu',title:'百度中心点纬度',sortable:true},
			 					{field:'parkCount',title:'停车场个数',sortable:true},
			 					{field:'parkType',title:'停车场类型',sortable:true},
			 					{field:'totalBerthNum',title:'停车点总泊位数',sortable:true}
			 					
			 	]],
				toolbar:[
					{
						id : 'btnGeneration',
						iconCls : 'ext-icon-arrow_refresh',
						text : '实时生成',
						btnType : 'generation',
						handler : function() {
								//_this.generation(rows);
							$.messager.confirm('提示', '确认实时生成数据？', function(r){
						        if (r){
						        	 $.messager.progress({
							                title:'请稍后',
							                msg:'正在生成...'
							          });
						        	_this.generation();
						        }
						    });
						}
					},
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
	app.parkAggregation.init();
});		