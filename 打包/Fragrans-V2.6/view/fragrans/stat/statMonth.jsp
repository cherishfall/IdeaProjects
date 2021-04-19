<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 		<label class="ui-label">区域名称:</label><input id="areaCode" name="areaCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
			<label class="ui-label">月份:</label>
				 <input id="dayTimeSelect" name="dayTime" class="easyui-datebox" data-options="formatter:myFormatter,parser:myParser" />
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
        <a href="#" class="easyui-linkbutton" onclick="generateStatMonth();" style="margin-top:3px;" iconCls="icon-edit" >生成月报表</a>
        <a href="#" class="easyui-linkbutton" onclick="exportStatMonth();" style="margin-top:3px;" iconCls="icon-edit" >导出月报表</a>
      </form>  
     </div> 
     <!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>
     
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/stat/statMonth.js"></script>
	
	<script>
		function myFormatter(date){
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			return y+'-'+(m<10?('0'+m):m);
		}


		function myParser(s){
			if(!s){
				return new Date();
			}
			var ss = s.split('-');
			var y = parseInt(ss[0],10);
			var m = parseInt(ss[1],10);
			if (!isNaN(y) && !isNaN(m)){
				return new Date(y,m-1);
			}
		}
	</script>
  </body>
</html>
