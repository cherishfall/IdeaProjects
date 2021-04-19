$package('app.areaConfig');
app.areaConfig = function () {
    var _box = null;
    var _this = {
        config: {
            dataGrid: {
                title: '列表',
                url: 'dataList.do',
                fitColumns: true,
                columns: [[ // ,formatter:sys.dicts.text('OPEN_FLAG')
                    {field: 'id', checkbox: true},
                    {field: 'areaName', title: '区域', sortable: true},
                    {field: 'paraName', title: '参数关键字', sortable: true},
                    {field: 'paraValue', title: '参数值', sortable: true},
                    {field: 'paraType', title: '是否通用', sortable: true,formatter:sys.dicts.text('ISCOMMON')},
                    {field: 'paraDesc', title: '参数描述', sortable: true},
                    {field: 'state', title: '参数状态', sortable: true,formatter:sys.dicts.text('STATE')},
                    {field: 'createdBy', title: '创建人', sortable: true},
                    {field: 'updatedBy', title: '修改人', sortable: true},
                    {field: 'createTime', title: '创建时间', sortable: true},
                    {field: 'updateTime', title: '更新时间', sortable: true}
                ]],
                toolbar: [
                    {id: 'btnadd', text: '添加', btnType: 'add'},
                    {id: 'btnedit', text: '修改', btnType: 'edit'},
                    {id: 'btndelete', text: '删除', btnType: 'remove'}
                ]
            }
        },
        init: function () {
            _box = new YDataGrid(_this.config);
            _box.init();
        }
    }
    return _this;
}();

$(function () {
    app.areaConfig.init();
});		