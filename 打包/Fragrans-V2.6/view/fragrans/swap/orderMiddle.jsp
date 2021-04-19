<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
 <%@include file="/view/inc.jsp" %>
 <script type="text/javascript"
	src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
			<label class="ui-label">账单日期:</label>
				 <input id="dayTime" name="dayTime" class="easyui-datebox" data-options="formatter:myFormatter,parser:myParser" />
			 <label class="ui-label">区域名称:</label>
				<input id="areaCode" name="areaCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
					idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
      </form>  
     </div> 
     
      <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>
     
     <div id="orderMiddleList" class="easyui-dialog" title="导出账单"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 200px;" singleSelect:false>
		<form id="orderMiddleListForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
					<div style="padding:5px;">
					<label class="ui-label">账单日期:</label>
					 <input id="dayTime" name="dayTime" class="easyui-datebox" data-options="formatter:myFormatter,parser:myParser" />
					 </div>
					 <div style="padding:5px;">
					<label class="ui-label">区域名称:</label>
						<input id=cityId name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
							idField : 'id',treeField : 'cityId',parentField : 'parentId',required:false" />
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/swap/orderMiddle.js"></script>
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