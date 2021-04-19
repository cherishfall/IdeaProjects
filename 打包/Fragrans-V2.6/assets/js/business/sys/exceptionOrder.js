$package('exceptionOrder');
exceptionOrder = function() {
	var _box = null;
	var _this = {
        detail : function(rows) {
            $('#detail').dialog({
                maximizable:true,
                href: '../view/fragrans/appsystem/parkrecordDetail.jsp?parkrecordId='+rows[0].parkrecordId+'&cityCode='+rows[0].cityCode,
            });
            $('#detail').dialog("open");
        },
		config : {
			event : {
				search : function() { // 条件查询验证
					var Grid = $('#data-list');
					var Form = {
						search : $("#searchForm")
					};
					var param = Form.search.serializeObject();
					Grid.datagrid('reload', param);
				}
			},
			dataGrid : {
				title : '列表',
				url : 'dataList.do',
				fitColumns : true,
				queryParams : {
					startTime :getMonthFirstDatetime() ,
					endTime : getNowDay(),
				},
				columns : [ [ // ,formatter:sys.dicts.text('OPEN_FLAG')
				{
					field : 'id',
					checkbox : true
				}, {
					field : 'cityCode',
					hidden : true
				}, {
					field : 'areaCode',
					hidden : true
				}, {
					field : 'orderNo',
					title : '交易订单编号',
					sortable : true
				}, {
					field : 'cityName',
					title : '城市名称',
					sortable : true
				}, {
					field : 'areaName',
					title : '区级名称',
					sortable : true
				}, {
					field : 'payType',
					title : '支付方式',
					sortable : true,
					formatter : sys.dicts.text('payType')
				}, {
					field : 'userAccount',
					title : '用户账号',
					sortable : true
				}, {
					field : 'plateNo',
					title : '车牌号',
					sortable : true
				}, {
					field : 'parkrecordId',
					title : '停车记录id',
					sortable : true
				}, {
					field : 'price',
					title : '订单金额',
					sortable : true,
					formatter : function(value, row, index) {
						return "<font>￥" + value / 100 + "</font>";
					}
				}, {
					field : 'payTime',
					title : '支付时间',
					sortable : true
				}, {
					field : 'orderBody',
					title : '订单描述',
					sortable : true
				}, {
					field : 'isHandle',
					title : '处理状态',
					sortable : true,
					formatter : function(value, row, index) {
						if (value == '0') {
							return "未处理";
						} else if (value == '1') {
							return "已处理";
						}
					}
				}, ] ],
				toolbar : [ {
					id : 'updateOrder',
					text : '更新异常订单',
					btnType : 'detail',
					iconCls : "ext-icon-arrow_refresh_small",
					handler : function() {
						$.messager.progress({
							title : '请稍后',
							msg : '正在更新异常订单...'
						});
						$.ajax({
							url : 'updateExceptionOrder.do',
							type : 'post',
							success : function(result) {
								$('#data-list').datagrid('reload');
								$.messager.progress('close');
							},
							error : function() {
								$.messager.progress('close');
							}
						});
					}
				}, {
					id : 'btnSubmit',
					text : '提交客服',
					btnType : 'export',
					iconCls : "l-btn-icon icon-add",
					handler : function() {
						var rows = $('#data-list').datagrid('getChecked');
						if (rows.length == 0) {
							$.messager.show({
								title : '提示',
								msg : "请选择一条记录"
							});
						} else if (rows.length > 1) {
							$.messager.show({
								title : '提示',
								msg : "请选择一条记录"
							});
						} else if (rows.length == 1) {
							if(rows[0].isHandle==1){
								$.messager.alert('提示','该条记录已被处理过'); 
								return;
							}
							$('#editForm').form('clear');
							var rows = $('#data-list').datagrid('getChecked');
							var id = rows[0].id;
							var areaName = rows[0].areaName;
							var areaCode = rows[0].areaCode;
							var parkrecordId = rows[0].parkrecordId;
							var userAccount = rows[0].userAccount;
							var plateNo = rows[0].plateNo;
							var complainType = "1";
							var complainResource = "3";
							var complainDesc = "";
							$("#id").val(id);
							$("#areaName").val(areaName);
							$("#areaCode").val(areaCode);
							$("#userAccount").val(userAccount);
							$("#palteNo").val(plateNo);
							$("#parkrecordId").val(parkrecordId);
							$("#isComplate").val("已完成");
							$("#complainType").val("费用问题");
							$("#complainResource").val("其他");
							$('#edit-win').dialog('open');
						}
					}
				}, {id:'btndetail',text:'停车记录详情',btnType:'exceptionOrderDetail',iconCls : 'ext-icon-report_add',
                    handler : function() {
                        var rows = $('#data-list').datagrid('getChecked');
                        if (rows.length == 1) {
                            _this.detail(rows);
                        } else {
                            $.messager.show({
                                msg : '请选择一条记录',
                                title : '提示'
                            });
                        }
                    }}]
			}
		},
		init : function() {
			$('#startTime').datebox('setValue', getMonthFirstDatetime());
            $('#endTime').datebox('setValue', getNowDay());
			_box = new YDataGrid(_this.config);
			_box.init();
		}
	}
	return _this;
}();

$(function() {
	exceptionOrder.init();
	$('#edit-win').dialog({
		buttons : [ {
			text : '保存',
			handler : function() {
				var complainDesc = $.trim($("#complainDesc").val());
				if(complainDesc==""){
					$.messager.alert('提示', '请填写投诉内容');
				}else{
					add();
				}
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#edit-win').dialog('close');
			}
		} ]
	});

});
function add() {
	var id = $("#id").val();
	var areaCode = $("#areaCode").val();
	var userAccount = $("#userAccount").val();
	var plateNo = $("#palteNo").val();
	var parkrecordId = $("#parkrecordId").val();
	var isComplate = "1";
	var complainType = "1";
	var complainResource = "3";
	var complainDesc = $("#complainDesc").val();
	$.ajax({
		url : 'save.do',
		type : 'post',
		dataType : 'json',
		data : {
			exceptionOrderId : id,
			cityCode : areaCode,
			userAccount : userAccount,
			palteNo : plateNo,
			parkrecordId : parkrecordId,
			isComplate : isComplate,
			complainResource : complainResource,
			complainType : complainType,
			complainDesc : complainDesc
		},
		success : function(result) {
			if (result.msg == "已提交过客服 请勿重复提交") {
				$('#edit-win').dialog('close');
				$.messager.alert('警告', '已提交过客服 请勿重复提交');
			} else {
				$.messager.show({
					title : '提示',
					msg : result.msg
				})
				$('#edit-win').dialog('close');
				$('#data-list').datagrid('reload');
			}
			
		}
	});
}