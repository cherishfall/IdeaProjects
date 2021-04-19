<%@ tag pageEncoding="UTF-8" isELIgnored="false" body-content="empty"%>
<!--标签 id -->
<%@ attribute name="id" required="true"%>
<!--标签name -->
<%@ attribute name="name" required="true"%>
<!--是否自适应高度 -->
<%@ attribute name="isAutoHeight" required="false"%>
<!--easyui 数据选项-->
<%@ attribute name="dataOptions" required="false"%>

<!-- groupId -->
<%@ attribute name="groupId" required="false"%>
<!-- collectorCode -->
<%@ attribute name="collectorCode" required="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${isAutoHeight == null}">
	<c:set var="isAutoHeight" value="200" />
</c:if>
<c:if test="${dataOptions == null}">
	<c:set var="dataOptions" value="required:true" />
</c:if>

<script type="text/javascript">
$(function() {
	var isLinked = ('${isLinked}');
    var groupId = $('#${groupId}');
    var collectorCode=$('#${collectorCode}');
    if(groupId.length != 0){
        groupId.combobox({
            url: ''
        });
        $('#${id}').combotree({
            onSelect : function (record) {
                var url = '<%=request.getContextPath()%>/tag/getCollectorGroupItems.do?isDefaultLine=${isDefaultLine}';
                $.ajax({
                    url: url + '&departmentId=' + record.id,
                    type: 'post',
                    dataType: 'json',
                    success: function (result) {
                        groupId.combobox('loadData', result);
                    }
                });
            }
        });
    }
    if(collectorCode.length != 0){
        collectorCode.combobox({
            url: ''
        });
        $('#${id}').combotree({
            onSelect : function (record) {
                var url = '<%=request.getContextPath()%>/tag/getDepartmentCollectorItems.do?isDefaultLine=${isDefaultLine}';
                $.ajax({
                    url: url + '&departmentId=' + record.id,
                    type: 'post',
                    dataType: 'json',
                    success: function (result) {
                        collectorCode.combobox('loadData', result);
                    }
                });
            }
        });
    }
	})
</script>
<input id="${id}" name="${name}" class="easyui-combotree"  
	panelHeight="${isAutoHeight}" data-options="width:'135',${dataOptions},url:'<%=request.getContextPath()%>/tag/getDepartmentItems.do',idField : 'id',treeField : 'departmentName',
	parentField : 'parentId'">
