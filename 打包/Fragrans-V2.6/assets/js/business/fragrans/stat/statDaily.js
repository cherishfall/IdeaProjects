function searchForm() {
    var startDate = $('#startDateSel').datebox('getValue');
    var endDate = $('#endDateSel').datebox('getValue');
    //var cityCode = $('#cityCode').datebox('getValue');
    var areaCode = $('#areaCode').datebox('getValue');
    console.log(startDate + "," + endDate);
    if (startDate != "" && endDate != "") {
        if (startDate > endDate) {
            sys.alert('警告', '起始时间大于结束时间！.', 'warning');
            return;
        }
    }
    $('#data-list').datagrid({
        url: 'dataList.do?startDate=' + startDate +
        "&endDate=" + endDate + "&areaCode=" + areaCode
    });
}

$('#cityCode').combotree({
    onChange: function (newValue, oldValue) {
        $('#areaCode').combotree({
            url: '../area/getArea.do?parentId=' + newValue,
            fit: true,
            idField: 'id',
            treeField: 'areaName',
            parentField: 'parentId',
        });
    }
});

$('#exp_cityCode').combotree({
    onChange: function (newValue, oldValue) {
        console.log("new:" + newValue);
        $('#exp_areaCode').combotree({
            url: '../area/getArea.do?parentId=' + newValue,
            fit: true,
            idField: 'id',
            treeField: 'areaName',
            parentField: 'parentId',
        });
    }
});

$(function () {
    $('#data-list').datagrid({
        title: '列表',
        iconCls: "ext-icon-page_excel",
        fitColumns: true,
        fit: true,
        pagination: true,
        columns: [[
            {field: 'id', checkbox: true},
            {
                field: 'dayTime', title: '日期', sortable: true,
                formatter: function (value, row, index) {
                    return value.split(" ")[0];
                }
            },
            {field: 'cityName', title: '城市名称', sortable: true},
            {field: 'areaName', title: '区域名称', sortable: true},
            {field: 'allTranCount', title: '交易总笔数', sortable: true},
            {
                field: 'payableFee', title: '交易成功应付金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'tranSuccessCount', title: '交易成功笔数', sortable: true},
            {
                field: 'tranSuccessAmount', title: '交易成功实付金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {
                field: 'counterAmount', title: '手续费总金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'refundSuccessCount', title: '退费成功笔数', sortable: true},
            {
                field: 'refundSuccessAmount', title: '退费成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {
                field: 'refundCounterAmount', title: '退款手续费总金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'alipaySuccessCount', title: '支付宝支付成功笔数', sortable: true},
            {
                field: 'alipaySuccessAmount', title: '支付宝支付成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {
                field: 'alipayCounterAmount', title: '支付宝手续费', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'wxpaySuccessCount', title: '微信支付成功笔数', sortable: true},
            {
                field: 'wxpaySuccessAmount', title: '微信支付成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {
                field: 'wxpayCounterAmount', title: '微信手续费', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'monthlySuccessCount', title: '包月支付成功笔数', sortable: true},
            {
                field: 'monthlySuccessAmount', title: '包月支付成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'innopaySuccessCount', title: '收费宝支付成功笔数', sortable: true},
            {
                field: 'innopaySuccessAmount', title: '收费宝支付成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'alipayRefundSucCount', title: '支付宝退费成功笔数', sortable: true},
            {
                field: 'alipayRefundSucAmount', title: '支付宝退费成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'wxpayRefundSucCount', title: '微信退费成功笔数', sortable: true},
            {
                field: 'wxpayRefundSucAmount', title: '微信退费成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'cmbpayRefundSucCount', title: '一网通退费成功笔数', sortable: true},
            {
                field: 'cmbpayRefundSucAmount', title: '一网通退费成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'mcpayRefundSucCount', title: '会员卡退费成功笔数', sortable: true},
            {
                field: 'mcpayRefundSucAmount', title: '会员卡退费成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            // {field:'subsSuccessCount',title:'预约成功笔数',sortable:true},
            // {field:'subsSuccessAmount',title:'预约成功金额',sortable:true,
            // 	formatter:function(value,row,index){
            // 		return "<font font-weight:bold;'>￥"+value/100+"</font>";
            // }},
            {field: 'discountSuccessCount', title: '折扣成功笔数', sortable: true},
            {
                field: 'discountSuccessAmount', title: '折扣成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'ticketpaySuccessCount', title: '停车券支付笔数 ', sortable: true},
            {field: 'ticketAllPaySuccessCount', title: '全额支付笔数 ', sortable: true},
            {
                field: 'ticketpaySuccessAmount', title: '停车券抵扣金额  ', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'payUserCount', title: '支付用户数 ', sortable: true},
            {field: 'paySuccessUserCount', title: '成功支付用户数 ', sortable: true},
            {field: 'ticketpaySuccessUserCount', title: '停车券支付用户数 ', sortable: true},
            {field: 'cmbpaySuccessCount', title: '一网通支付成功笔数', sortable: true},
            {
                field: 'cmbpaySuccessAmount', title: '一网通支付成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {
                field: 'cmbpayCounterAmount', title: '一网通手续费', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'balanceSuccessCount', title: '余额支付成功笔数', sortable: true},
            {
                field: 'balanceSuccessAmount', title: '余额支付成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
            {field: 'mcpaySuccessCount', title: '会员卡支付成功笔数', sortable: true},
            {
                field: 'mcpaySuccessAmount', title: '会员卡支付成功金额', sortable: true,
                formatter: function (value, row, index) {
                    return "<font font-weight:bold;'>￥" + value / 100 + "</font>";
                }
            },
        ]],
        toolbar: [
            {
                id: 'btnGenerate', text: '生成日报表', btnType: 'add', iconCls: "icon-edit",
                handler: function () {
                    $('#generateStatDailyForm').form('reset');
                    generateStatDaily();
                }
            },
            {
                id: 'btnRepair', text: '修复日报表', btnType: 'add', iconCls: "icon-edit",
                handler: function () {
                    $('#repairStatDailyForm').form('reset');
                    repairStatDaily();
                }
            },
            {
                id: 'btnExport', text: '导出日报表', btnType: 'edit', iconCls: "ext-icon-page_excel",
                handler: function () {
                    $('#exportStatDailyForm').form('reset');
                    exportStatDaily();
                }
            }
        ]
    });
    $('#startDate').datebox('setValue', getBeforeSevenDays());
    $('#endDate').datebox('setValue', getYesterDay());
    searchForm();
    $('#generateStatDaily').dialog({
        buttons: [{
            text: '生成',
            handler: function () {
                var param = $('#generateStatDailyForm').serializeObject();
                var dayTime = param.dayTime;
                //验证生成日报时间
                if (dayTime == null || dayTime == '' || dayTime == undefined) {
                    $.messager.show({
                        title: '提示',
                        msg: '请选择日期'
                    });
                    return;
                }
                //生成当前日期
                var nowDate = getNowDate();
                if (dayTime > nowDate) {
                    $.messager.show({
                        title: '提示',
                        msg: '请输入合理的日期'
                    });
                    return;
                }
                $.messager.confirm("提示", "确认生成日报表?", function (r) {
                    if (r) {
                        $.messager.progress({
                            title: '请稍后',
                            msg: '正在生成日报表...'
                        });
                        $('#generateStatDailyForm').form('submit', {
                            url: 'generateStatDaily.do',
                            type: "post",
                            onSubmit: function () {
                                return $(this).form('validate');
                            },
                            success: function (result) {
                                $.messager.progress('close');
                                var res = $.parseJSON(result);
                                $.messager.show({
                                    title: '提示',
                                    msg: res.msg
                                });
                                if (res.success) {
                                    $('#generateStatDaily').dialog('close');
                                    $('#data-list').datagrid('reload');
                                }
                            }
                        });
                    }
                });
            }
        }, {
            text: '关闭',
            handler: function () {
                $('#generateStatDaily').dialog('close');
            }
        }]
    });
    
    $('#repairStatDaily').dialog({
        buttons: [{
            text: '修复',
            handler: function () {
                var param = $('#repairStatDailyForm').serializeObject();
                var startTime = param.startTime;
                //验证生成日报时间
                if (startTime == null || startTime == '' || startTime == undefined) {
                    $.messager.show({
                        title: '提示',
                        msg: '请选择开始日期'
                    });
                    return;
                }
                //生成当前日期
                var nowDate = getNowDate();
                if (startTime > nowDate) {
                    $.messager.show({
                        title: '提示',
                        msg: '请输入合理的开始日期'
                    });
                    return;
                }
                var endTime = param.endTime;
                //验证生成日报时间
                if (endTime == null || endTime == '' || endTime == undefined) {
                    $.messager.show({
                        title: '提示',
                        msg: '请选择结束日期'
                    });
                    return;
                }
                //生成当前日期
                var nowDate = getNowDate();
                if (endTime > nowDate) {
                    $.messager.show({
                        title: '提示',
                        msg: '请输入合理的结束日期'
                    });
                    return;
                }
                $.messager.confirm("提示", "确认修复日报表?", function (r) {
                    if (r) {
                        $.messager.progress({
                            title: '请稍后',
                            msg: '正在修复日报表...'
                        });
                        $('#repairStatDailyForm').form('submit', {
                            url: 'repairStatDaily.do',
                            type: "post",
                            onSubmit: function () {
                                return $(this).form('validate');
                            },
                            success: function (result) {
                                $.messager.progress('close');
                                var res = $.parseJSON(result);
                                $.messager.show({
                                    title: '提示',
                                    msg: res.msg
                                });
                                if (res.success) {
                                    $('#repairStatDaily').dialog('close');
                                    $('#data-list').datagrid('reload');
                                }
                            }
                        });
                    }
                });
            }
        }, {
            text: '关闭',
            handler: function () {
                $('#repairStatDaily').dialog('close');
            }
        }]
    });
    
    $('#exportStatDaily').dialog({
        buttons: [{
            text: '保存',
            handler: function () {
                var param = $('#exportStatDailyForm').serializeObject();
                var startDate = param.startDate;
                var endDate = param.endDate;
                var cityCode = param.cityCode;
                var areaCode = param.areaCode;
                //验证导出日报时间
                if (startDate == null || startDate == '' || startDate == undefined
                    || endDate == null || endDate == '' || endDate == undefined) {
                    $.messager.show({
                        title: '提示',
                        msg: '请选择日期'
                    });
                    return;
                }
                if (endDate < startDate) {
                    $.messager.show({
                        title: '提示',
                        msg: "开始时间必须小于结束时间"
                    });
                    return;
                }
                $('#exportStatDailyForm').form('submit', {
                    url: 'getExportStatDaily.do',
                    type: "post",
                    success: function (result) {
                        $.messager.progress('close');
                        var res = $.parseJSON(result);
                        if (!res.success) {
                            $.messager.show({
                                title: '提示',
                                msg: res.msg
                            });
                        } else {
                            $.messager.confirm('确认', '确认导出符合查询条件的数据？', function (r) {
                                if (r) {
                                    window.open('exportStatDaily.do?startDate=' + startDate
                                        + '&endDate=' + endDate + '&cityCode=' + cityCode
                                        + '&areaCode=' + areaCode);
                                }
                            });
                        }
                        $('#exportStatDaily').dialog('close');
                    }
                });
            }
        }, {
            text: '关闭',
            handler: function () {
                $('#exportStatDaily').dialog('close');
            }
        }]
    });
});

function generateStatDaily() {
    $('#generateStatDaily').dialog('open');
}

function repairStatDaily() {
    $('#repairStatDaily').dialog('open');
}

function exportStatDaily() {
    $('#exportStatDaily').dialog('open');
}

function getYesterDay() {
    var date = new Date();
    date.setTime(date.getTime() - 1 * 24 * 60 * 60 * 1000);
    return date.pattern("yyyy-MM-dd");
}

function getBeforeSevenDays() {
    var date = new Date();
    date.setTime(date.getTime() - 7 * 24 * 60 * 60 * 1000);
    return date.pattern("yyyy-MM-dd");
}

function getNowDate() {
    var date = new Date();
    date.setTime(date.getTime());
    return date.pattern("yyyy-MM-dd");
}

