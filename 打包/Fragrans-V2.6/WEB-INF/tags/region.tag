<%@ tag pageEncoding="UTF-8" isELIgnored="false" body-content="empty"%>
<!--标签 id -->
<%@ attribute name="id" required="true"%>
<!--标签name -->
<%@ attribute name="name" required="true"%>
<!--是否自适应高度 -->
<%@ attribute name="isAutoHeight" required="false"%>
<!--是否有默认横线 -->
<%@ attribute name="isDefaultLine" required="false"%>
<!--easyui 数据选项-->
<%@ attribute name="dataOptions" required="false"%>
<!-- regionId -->
<%@ attribute name="departmentId" required="false"%>
<!-- streetId -->
<%@ attribute name="streetId" required="false"%>
<!-- groupId -->
<%@ attribute name="groupId" required="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${isDefaultLine == null}">
	<c:set var="isDefaultLine" value="0" />
</c:if>
<c:if test="${isAutoHeight == null}">
	<c:set var="isAutoHeight" value="200" />
</c:if>
<c:if test="${dataOptions == null}">
	<c:set var="dataOptions" value="required:true" />
</c:if>

<script type="text/javascript">
	$(function(){
		var url ='<%=request.getContextPath()%>/tag/getRegionItems.do?isDefaultLine=${isDefaultLine}';
		$('#${id}').combobox('reload', url);
		var department = $('#${departmentId}');
		var street = $('#${streetId}');
        var groupId=$('#${groupId}');
	if (department.length != 0 && street.length != 0) {
			department.combotree({
				disabled : true,
			});
			street.combobox({
				disabled : true
			});
			$('#${id}').combobox({
				onSelect : function(record) {
					console.log(record.id);
					var departmentUrl = '<%=request.getContextPath()%>/tag/getDepartmentItems.do?regionId=' + record.id;
					department.combotree({
						url : departmentUrl,
						disabled : false
					});
					
					var streetUrl = '<%=request.getContextPath()%>/tag/getStreetItems.do?regionId=' + record.id ;
					street.combobox({
						disabled : false,
						url : streetUrl
					});
				}
			});
		}else if(department.length != 0){
			department.combotree({
				disabled : true
			});
			$('#${id}').combobox({
				onSelect : function(record) {
					var departmentUrl = '<%=request.getContextPath()%>/tag/getDepartmentItems.do?regionId=' + record.id;
					department.combotree({
						url : departmentUrl,
						disabled : false
					});
				}
			});
			
		}else if(street.length != 0){
			street.combobox({
				disabled : true
			});
			var url = '<%=request.getContextPath()%>/tag/getStreetItems.do';
			$('#${id}').combobox({
				onSelect : function(record) {
					var streetUrl = '<%=request.getContextPath()%>/tag/getStreetItems.do?regionId=' + record.id ;
					street.combobox({
						disabled : false,
						url : streetUrl
					});
				}
			});
		}
	});
</script>
<input id="${id}" name="${name}" valueField="id" textField="regionName"
	class="easyui-combobox" panelHeight="${isAutoHeight}"
	data-options="${dataOptions},editable:false">
