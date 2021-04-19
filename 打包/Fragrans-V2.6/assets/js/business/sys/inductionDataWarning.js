$package('inductionDataWarning');
//诱导同步管理
inductionSync = function() {
	var _box = null;
	var _this = {
		config : {
            event : {
                add : function() {
                    $.ajax({
                        url : '../key/getIdAndKey.do',
                        type : 'post',
                        success : function(result){
                            $('#editForm').form('clear');
                            $('#editForm').form('load',{appId:result[0].appId,appKey:result[0].appKey});
                        }
                    })
                    _box.handler.add();
                }
            },
			dataGrid : {
				title : '诱导同步管理',
				url : 'dataList.do',
				fitColumns : true,
				columns : [[
				{
					field:'id',
					checkbox:true
				},
				{
					field : 'areaCode',
					title : '区域编码',
					sortable : true
				}, {
					field : 'areaName',
					title : '区域名称',
					sortable : true
				}, {
					field : 'appId',
					title : '应用ID',
					sortable : true
				}, {
					field : 'appKey',
					title : '应用key',
					sortable : true
				},{
					field : 'appName',
					title : '应用名称',
					sortable : true
				}, {
					field : 'expiredTime',
					title : '有效期',
					sortable : true
				}, {
					field : 'appStatus',
					title : '应用状态',
					sortable : true,
					formatter : function(value, row, index) {
						if (value == 0) {
							return "停用";
						}
						if (value == 1) {
							return "正常";
						}
					}
				}, {
					field : 'authIp',
					title : '允许授权连接的IP',
					sortable : true
				},{
					field : 'appDesc',
					title : '应用描述',
					sortable : true
				}, {
					field : 'syncLastUpdateTime',
					title : '最近同步更新时间',
					sortable : true

				}]],
				toolbar:[
							{id:'btnadd',text:'添加',btnType:'add'},
							{id:'btnedit',text:'修改',btnType:'edit'},
							{id:'btndelete',text:'删除',btnType:'remove'}
						]
			}
		},
		init : function() {
			_box = new YDataGrid(_this.config);
			_box.init();
		}
	}
	return _this;
}();

// 流量数据预警
flowDataWarning = function() {
	var _box = null;
	var _this = {
		config : {
			dataGrid : {
				title : '流量数据同步预警',
				url : 'flowDataWarning/dataList.do',
				fitColumns : true,
				columns : [ [ {
					field : 'cityName',
					title : '城市名称',
					sortable : true
				}, {
					field : 'areaName',
					title : '区域名称',
					sortable : true,
					formatter : function(value, row, index) {
						if (value == null || value == "") {
							return "无";
						} else {
							return value;
						}
					}
				}, {
					field : 'parkCode',
					title : '停车点编码',
					sortable : true
				}, {
					field : 'name',
					title : '停车点名称',
					sortable : true
				}, {
					field : 'parkType',
					title : '停车点类型',
					sortable : true,
					formatter : function(value, row, index) {
						if (value == 1) {
							return "停车点";
						}
						if (value == 2) {
							return "停车场";
						}
					}
				}, {
					field : 'address',
					title : '停车点地址',
					sortable : true

				}, {
					field : 'totalBerthNum',
					title : '总泊位数',
					sortable : true
				}, {
					field : 'contacts',
					title : '联系人',
					sortable : true,
					formatter : function(value, row, index) {
						if (value == null || value == "") {
							return "无";
						} else {
							return value;
						}
					}
				}, {
					field : 'phone',
					title : '联系电话',
					width : 60,
					sortable : true,
					formatter : function(value, row, index) {
						if (value == null || value == "") {
							return "无";
						} else {
							return value;
						}
					}
				}, {
					field : 'isOpen',
					title : '状态',
					width : 60,
					sortable : true,
					formatter : function(value, row, index) {
						if (value == 0) {
							return "不开放";
						}
						if (value == 1) {
							return "开放";
						}
					}
				} ] ]
			}
		},
		init : function() {
			_box = new YDataGrid2(_this.config, 'data-list1');
			_box.init();
		}
	}
	return _this;
}();
// 流量延迟推送预警
flowDelayWarning = function() {
	var _box = null;
	var _this = {
		config : {
			dataGrid : {
				title : '流量延迟推送预警',
				url : 'flowDelayWarning/dataList.do',
				fitColumns : true,
				columns : [ [ {
					field : 'cityName',
					title : '城市名称',
					sortable : true
				}, {
					field : 'areaName',
					title : '区域名称',
					sortable : true
				}, {
					field : 'parkCode',
					title : '停车点编码',
					sortable : true
				}, {
					field : 'name',
					title : '停车点名称',
					sortable : true
				}, {
					field : 'parkType',
					title : '停车点类型',
					sortable : true,
					formatter : function(value, row, index) {
						if (value == 1) {
							return "停车点";
						}
						if (value == 2) {
							return "停车场";
						}
					}
				},{
					field : 'availableBerthNum',
					title : '空余泊位数',
					sortable : true
				}, {
					field : 'bookableNum',
					title : '可预约泊位数',
					sortable : true
				}, {
					field : 'remainBookableNum',
					title : '剩余可预约泊位数',
					sortable : true
				}, {
					field : 'updatedBy',
					title : '更新人',
					sortable : true

				}, {
					field : 'updateTime',
					title : '更新时间',
					sortable : true
				}, {
					field : 'duration',
					title : '延迟推送时间',
					sortable : true

				} ] ]
			}
		},
		init : function() {
			_box = new YDataGrid2(_this.config, 'data-list2');
			_box.init();
		}
	}
	return _this;
}();

// 诱导同步延迟预警
inductionSyncWarning = function() {
	var _box = null;
	var _this = {
		config : {
			dataGrid : {
				title : '诱导同步延迟预警',
				url : 'inductionSyncWarning/dataList.do',
				fitColumns : true,
				columns : [ [ {
					field : 'areaCode',
					title : '区域编码',
					sortable : true
				}, {
					field : 'areaName',
					title : '区域名称',
					sortable : true
				}, {
					field : 'appId',
					title : '设备ID',
					sortable : true
				}, {
					field : 'appName',
					title : '设备名称',
					sortable : true
				}, {
					field : 'appDesc',
					title : '设备描述',
					sortable : true
				}, {
					field : 'authIp',
					title : '允许授权连接的IP',
					sortable : true
				},{
					field : 'syncLastUpdateTime',
					title : '最近同步更新时间',
					sortable : true

				}, {
					field : 'duration',
					title : '诱导同步延迟时间',
					sortable : true

				} ] ]
			}
		},
		init : function() {
			_box = new YDataGrid2(_this.config, 'data-list3');
			_box.init();
		}
	}
	return _this;
}();
// 初始化
$(function() {
	flowDataWarning.init();
	flowDelayWarning.init();
	inductionSyncWarning.init();
	inductionSync.init();
});

function searchForm(){
	var param = $('#searchForm').serializeObject();
	var areaCode = param.areaCode;
	var name = param.name;
	var parkType = param.parkType;
	$.ajax({
		url : 'flowDataWarning/dataList.do',
		type : 'post',
		dataType : 'json',
		data : {
			areaCode : areaCode,
			name : name,
			parkType : parkType
		},
		success : function(result) {
			var data=new Object();
			data.total = result.total;
			data.rows = result.rows;
			$("#data-list1").datagrid("loadData",data);
		}
	});
}

function delaySearchForm(){
	var param = $('#delaySearchForm').serializeObject();
	var areaCode = param.areaCode;
	var name = param.name;
	var parkType = param.parkType;
	$.ajax({
		url : 'flowDelayWarning/dataList.do',
		type : 'post',
		dataType : 'json',
		data : {
			areaCode : areaCode,
			name : name,
			parkType : parkType
		},
		success : function(result) {
			var data=new Object();
			data.total = result.total;
			data.rows = result.rows;
			$("#data-list2").datagrid("loadData",data);
		}
	});
}

var YDataGrid2 = function(config,id) {
	config = config || {};
	var dataGrid = config.dataGrid || {}
	// Actions
	var actionUrl = config.action || {}

	// Grid DataList
	var Grid = $('#' + id);
	// 刷新Grid 数据
	var Handler = {
		refresh : function(callback) {
			var param = Form.search.serializeObject();
			Grid.datagrid('reload', param);
			// 回调函数
			if (jQuery.isFunction(callback)) {
				callback();
			}
		}
	};

	// 自定义事件
	var evt = config.event || {};

	// 初始化表格
	var initGrid = function() {
		var dataconfig = {
			title : '数据列表',
			iconCls : 'icon-save',
			fit : true,
			border : false,
			nowrap : true,
			autoRowHeight : false,
			striped : false,
			collapsible : false,
			remoteSort : false,
			pagination : true,
			rownumbers : true,
			singleSelect : false,
			checkOnSelect : false,
			selectOnCheck : false,
			url : dataGrid.url,
			idField : dataGrid.idFile,
			method : 'post',
			loadMsg : '正在加载数据...',
			onLoadSuccess : function(data) {
				if (dataGrid.keepChoice == null) {
					Grid.datagrid('unselectAll');
					Grid.datagrid('uncheckAll');
				}
				if (data.rows.length == 0) {
					var columnLength = Grid.datagrid('getColumnFields').length;
					var body = $(this).data().datagrid.dc.body2;
					body
							.find('table tbody')
							.append(
									'<tr><td width="'
											+ body.width()
											+ '" style="height: 25px; padding:10px;text-align: left;"  colspan='
											+ columnLength
											+ '>没有任何结果数据显示！</td></tr>');
				}
			},
			onSelect : function(rowIndex, rowData) {
				// 选择一行
				var rows = Grid.datagrid('getRows');
				$.each(rows, function(i) {
					if (i != rowIndex) {
						Grid.datagrid('uncheckRow', i);
						Grid.datagrid('unselectRow', i);
					}
				})
				Grid.datagrid('checkRow', rowIndex);
			}
		};

		Grid.datagrid($.extend(dataconfig, dataGrid));
	}

	// this 返回属性
	this.grid = Grid;
	this.handler = Handler;

	// 初始化方法
	this.init = function() {
		initGrid();
	}
	// 调用初始化
	return this;
};