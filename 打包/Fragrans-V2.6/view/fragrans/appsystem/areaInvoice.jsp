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
 	 	   <label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" style="width:160px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
      </form>  
     </div>
     <!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

     <!-- Edit Form -->
     <div id="edit-win" class="easyui-dialog" title="地址配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:500px;height:350px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
	     		 	<tr>
						<td style="text-align: right;">所在城市:</td>
						<td><input id="cityCode" name="cityId" 
							class="easyui-combotree"
							data-options="url:'${pageContext.request.contextPath}/area/getCity.do',fit : true,
							idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true" />
							<img
							src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
							onclick="$('#cityCode').combotree('clear');"/></td>
						<td style="text-align: right;">所在区域:</td>
						<td><input id="areaCode" name="areaId"
							class="easyui-combotree"
							data-options="url:'${pageContext.request.contextPath}/area/getArea.do',fit : true,
							idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true"/>
							<img
							src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
							onclick="$('#areaCode').combotree('clear');" /></td>
					</tr>
			   		<tr>
						<td style="text-align: right;"> 精度:</td>
						<td> 
							 <input class="easyui-validatebox" type="text" name="longitude" missingMessage="请输入精度"
		                		    data-options="required:true,validType:'length[1,32]'" />
						</td>	
						<td style="text-align: right;"> 纬度:</td>
						<td> 
							 <input class="easyui-validatebox" type="text" name="latitude" missingMessage="请输入纬度"
		                		    data-options="required:true,validType:'length[1,50]'" />
						</td>					 
					</tr>
			   		<tr>
						<td style="text-align: right;"> 电话号码:</td>
						<td> 
							 <input class="easyui-validatebox" type="text" name="telphone" missingMessage="请输入电话号码"
		                		    data-options="required:true,validType:'length[1,32]'" />
						</td>
						<td style="text-align: right;"> 排序号:</td>
						<td> 
		                	<input id="orderNum" name="orderNum" class="easyui-validatebox easyui-numberspinner" 
							data-options="required:true,min:0,max:99" missingMessage="请输入排序号" style="width:134px;" />
						</td>						 
					</tr>
			   		<tr>
						<td style="text-align: right;"> 标题:</td>
						<td colspan="3"> 
							 <input class="easyui-validatebox" type="text" name="title" missingMessage="请输入标题"
		                		    data-options="required:true,validType:'length[1,32]'" 
		                		    style="width:350px;"/>
						</td>					 
					</tr>
					<tr>
						<td style="text-align: right;"> 具体地址:</td>
	                	<td colspan="3"><textarea name="address" id="address" 
							style="height: 80px; width: 350px;" maxlength="225"></textarea></td>
					</tr>
			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/areaInvoice.js"></script>
  </body>
</html>
