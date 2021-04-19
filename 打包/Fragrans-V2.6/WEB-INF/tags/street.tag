<%@ tag pageEncoding="UTF-8" isELIgnored="false" body-content="empty"%>
<!--标签 id -->
<%@ attribute name="id" required="true"%>
<!--标签name -->
<%@ attribute name="name" required="true"%>
<!--是否自适应高度 -->
<%@ attribute name="isAutoHeight" required="false"%>
<!--是否有默认横线 -->
<%@ attribute name="isDefaultLine" required="false"%>
<!-- regionId -->
<%@ attribute name="parkId" required="false"%>
<!--easyui 数据选项-->
<%@ attribute name="dataOptions" required="false"%>

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
	$(function() {
		var park = $('#${parkId}');
		if (park.length !=0 ) {
			park.combobox({
				disabled : true
			});
			$('#${id}').combobox({
				onSelect : function(record) {
						var url = '<%=request.getContextPath()%>/tag/getParkItems.do?isDefaultLine=${isDefaultLine}&streetId='+ record.id;
						park.combobox({
							disabled : false,
							url : url
						});
					}
				});
		}
	});
</script>
<input id="${id}" name="${name}" valueField="id" textField="regionName"
	class="easyui-combobox" panelHeight="${isAutoHeight}"
	data-options="${dataOptions},editable:false,url:'<%=request.getContextPath()%>/tag/getStreetItems.do'">