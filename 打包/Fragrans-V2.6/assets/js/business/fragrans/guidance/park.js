$package('app.park');
app.park = function(){
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
						{field:'name',title:'停车点名称',width:80,sortable:true},
						{field:'cityName',title:'城市名称',width:30,sortable:true},
			 					{field:'areaName',title:'区域名称',width:30,sortable:true},
			 					{field:'parkType',title:'停车点类型',width:50,sortable:true,formatter:sys.dicts.text('PARK_MODEL')},
			 					{field:'parkCode',title:'停车点编码',width:80,sortable:true},
			 					{field:'address',title:'停车点地址',width:80,sortable:true},
			 					{field:'totalBerthNum',title:'总泊位数',width:50,sortable:true},
			 					{field:'filingBerthNum',title:'报备总泊位数',width:50,sortable:true},
			 					{field:'isAliPark',title:'是否支付宝认证停车点',sortable:true,formatter:sys.dicts.text('YESORNO')},
			 					{field:'isDynamic',title:'是否是动态数据',width:50,sortable:true,formatter:sys.dicts.text('YESORNO')},
			 					{field:'isOpen',title:'是否开放',width:30,sortable:true,formatter:sys.dicts.text('YESORNO')},
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
			//地图框
			$('#map').dialog({
				title : '点击选择坐标',
				buttons : [{
					text : '确认选点',
					iconCls : 'icon-ok',
					handler : function(){
						$('#longitudeBaidu').val(globLon);
						$('#latitudeBaidu').val(globLat);
						$('#map').dialog('close');
					}
				},{
					text : '关闭',
					iconCls : 'icon-remove',
					handler : function(){
						$('#map').dialog('close');
					}
				}]
			})
		}
	}
	return _this;
}();
$(function(){
	app.park.init();
	$('#cityId').combotree({
//		onSelect:function(node) {
//			  alert(node);  
//		  },
	    onChange:function(newValue,oldValue){
	    	//console.log(newValue);
	    	$('#areaId').combotree({    
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
function editReload() { // 修改时在Form表单load数据之前，根据父级标签的值（parkId）将级联的标签(berthCode)的值请求到
	var rows = $('#data-list').datagrid('getChecked');
	console.log("row:"+rows[0].cityCode);
		if (rows.length == 1) {
			var row = rows[0];
			$('#areaId').combotree({    
	    	    url: '../area/getArea.do?cityCode='+row.cityCode,
	    	    fit : true,
	    	    idField : 'id',
	    	    treeField : 'areaName',
	    	    parentField : 'parentId',
	    	    required: true   
	    	}); 
		} 
}

function openMap(longitudeCity,latitudeCity){
	$('#map').dialog('open');
	var map = new BMap.Map("allMap");
	
	globLon = $('#longitudeBaidu').val();
	globLat = $('#latitudeBaidu').val();
	var defaultPoint = new BMap.Point(120.162145,30.279001);
	if(globLon != '' || globLat != ''){
		longitudeCity = globLon;
		latitudeCity = globLat;
		defaultPoint = new BMap.Point(globLon,globLat);
	} 
	map.centerAndZoom(defaultPoint, 15);  // 初始化地图,设置中心点坐标和地图级别
	var marker = new BMap.Marker(defaultPoint);
	map.addOverlay(marker);
	
	map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom(); 
	
	var gc = new BMap.Geocoder();
	gc.getLocation(defaultPoint, function(rs) {
		var addComp = rs.addressComponents;
		var lc = addComp.province + " " + addComp.city
				+ " " + addComp.district + " "
				+ addComp.street + " "
				+ addComp.streetNumber;
		var infoWindow = new BMap.InfoWindow(
				"<p><b>经度：</b> " + defaultPoint.lng
						+ "　　<b>纬度：</b> " + defaultPoint.lat
						+ "</p><p><b>位置：</b> " + lc
						+ "</p>", {
					title : '当前位置信息',
					height : 80,
					width : 230
				});
		marker.addEventListener("click", function() {
			this.openInfoWindow(infoWindow);
		});
		marker.openInfoWindow(infoWindow);
	});
	
	
	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	
	map.addControl(top_left_control);        
	map.addControl(top_left_navigation); 
	//点击事件
	map.addEventListener("click",function(e){
		map.clearOverlays();
		globLon = e.point.lng;
		globLat = e.point.lat;
//		var marker = new BMap.Marker(new BMap.Point(globLon,globLat));
//		map.addOverlay(marker);
		
//		var marker = new BMap.Marker();
		var point = new BMap.Point(globLon, globLat);
		
		map.centerAndZoom(point, 15);
		var marker = new BMap.Marker(point, {
			icon : null
		});
		map.addOverlay(marker);
		
		var gc = new BMap.Geocoder();
		gc.getLocation(point, function(rs) {
			var addComp = rs.addressComponents;
			var lc = addComp.province + " " + addComp.city
					+ " " + addComp.district + " "
					+ addComp.street + " "
					+ addComp.streetNumber;
			var infoWindow = new BMap.InfoWindow(
					"<p><b>经度：</b> " + point.lng
							+ "　　<b>纬度：</b> " + point.lat
							+ "</p><p><b>位置：</b> " + lc
							+ "</p>", {
						title : '当前位置信息',
						height : 80,
						width : 230
					});
			marker.addEventListener("click", function() {
				this.openInfoWindow(infoWindow);
			});
			marker.openInfoWindow(infoWindow);
		});
		
		
		
	});
}