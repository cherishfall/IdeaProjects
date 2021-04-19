$package('app.park');
app.park = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'parkCode',title:'停车点编码',sortable:true},
			 					{field:'parkName',title:'停车点名称',sortable:true},
			 					{field:'accessId',title:'接入商编号',sortable:true},
			 					{field:'accessName',title:'接入商名称',sortable:true},
			 					{field:'region',title:'所属区域 ',sortable:true},
			 					{field:'parkType',title:'停车点类型',sortable:true,formatter:sys.dicts.text('PARK_TYPE')},
			 					{field:'parkLocation',title:'停车点位置',sortable:true ,formatter:sys.dicts.text('PARK_LOCATION')},
			 					{field:'address',title:'停车点地址',sortable:true},
			 					{field:'longitudeGaode',title:'经度（高德地图）',sortable:true},
			 					{field:'latitudeGaode',title:'纬度（高德地图）',sortable:true},
			 					{field:'longitudeBaidu',title:'经度（百度地图）',sortable:true},
			 					{field:'latitudeBaidu',title:'纬度（百度地图）',sortable:true},
			 					{field:'berthNumTotal',title:'总泊位数',sortable:true},
			 					{field:'dayRate',title:'白天费率',sortable:true},
			 					{field:'nightRate',title:'晚上费率',sortable:true},
			 					{field:'openFlag',title:'是否开放标识',sortable:true,formatter:sys.dicts.text('OPEN_FLAG')},
			 					{field:'manager',title:'停车场管理员',sortable:true},
			 					{field:'passageNum',title:'通道数',sortable:true},
			 					{field:'phone',title:'联系电话',sortable:true},
			 					{field:'creator',title:'创建人',hidden:true},
			 					{field:'createTime',title:'创建时间',hidden:true},
			 					{field:'updateTime',title:'更新时间',sortable:true},
			 					{field:'remark',title:'备注',hidden:true},
			 					{field:'deleted',title:'是否删除',hidden:true}
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
		},
		dialog_map : function() {
			$('#map').dialog({
				title : '点击选择坐标',
				buttons : [ {
					text : '确认选点',
					iconCls : 'icon-ok',
					handler : function() {
						$('#editFormLongitude').val(globLon);
						$('#editFormlatitude').val(globLat);
						$('#map').dialog('close');
					}
				}, {
					text : '关闭',
					iconCls : 'icon-remove',
					handler : function() {
						$('#map').dialog('close');
					}
				} ]
			})
		},
	}
	return _this;
}();

$(function(){
	app.park.init();
	app.park.dialog_map();
});


function openMap() {
	$('#map').dialog('open');
	var map = new BMap.Map("allMap");
	globLon = $('#editFormLongitude').val();
	globLat = $('#editFormlatitude').val();
	if (globLon != '' || globLat != '') {
		map.centerAndZoom(new BMap.Point(120.150216, 30.299022), 14); // 初始化地图,设置中心点坐标和地图级别
		var marker = new BMap.Marker(new BMap.Point(globLon, globLat));
		map.addOverlay(marker);
	} else {
		map.centerAndZoom(new BMap.Point(120.150216, 30.299022), 14);
	}
	map.enableScrollWheelZoom(); // 启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom();

	var top_left_control = new BMap.ScaleControl({
		anchor : BMAP_ANCHOR_TOP_LEFT
	});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl(); // 左上角，添加默认缩放平移控件
	map.addControl(top_left_control);
	map.addControl(top_left_navigation);
	// 点击事件
	map.addEventListener("click", function(e) {
		map.clearOverlays();
		globLon = e.point.lng;
		globLat = e.point.lat;
		var marker = new BMap.Marker(new BMap.Point(globLon, globLat));
		map.addOverlay(marker);
	});
}