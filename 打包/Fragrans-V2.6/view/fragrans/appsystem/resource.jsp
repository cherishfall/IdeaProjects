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
 	 	   <label class="ui-label">应用类型:</label><mytag:dictionary name="appType" id="appTypeDic" codeType="resource_apptype" isDefaultLine="1" dataOptions="required:false"/>
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

     <!-- 添加 -->
     <div id="edit-win" class="easyui-dialog" title="资源配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:600px;height:400px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
     		 			<tr>
				   			<td style="text-align: right;"> 应用类型:</td>
							<td> 
								 <mytag:dictionary name="appType" id="appType" codeType="resource_apptype" style="width:150px;"/>
							</td>
						</tr>
				   	    <tr>
							<td style="text-align: right;">城市名称:</td>
							<td colspan="3"><input id="areaNameAdd" name="areaName"
							class="easyui-combotree" data-options="fit:true,required:true" style="width:400px;"/>
							<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
							onclick="$('#areaNameAdd').combotree('clear');"/></td>
						</tr>
						<tr>
							<td style="text-align: right;"> 版本号:</td>
							<td colspan="3"> 
								 <input class="easyui-combobox" type="text" id="versionCode" name="versionCode" missingMessage="请先选择应用类型，再选择版本号"
			                		    data-options="fit:true,required:true,validType:'length[1,1000]'" style="width:400px;"/>
			                	<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
								onclick="$('#versionCode').combotree('clear');"/>
							</td>
						</tr>
				   		<tr>
							<td style="text-align: right;"> 资源名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="resourceName" missingMessage="请输入资源名称"
			                		    data-options="required:true,validType:'length[1,64]'" style="width:150px;"/>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;">资源类型:</td>
							<td style="text-align: left;"><input name="resourceType" type="radio" value="1" checked="checked" onclick="show()"/>图片
							<input name="resourceType" type="radio" value="2"  onclick="hid()"/>文字</td>
						</tr>
						<tr>
							<td style="text-align: right;"> 资源文件名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="resourceFilename" missingMessage="请输入资源文件名称"
			                		    data-options="required:true,validType:'length[1,64]'" style="width:150px;"/>
							</td>			 
						</tr>
						<tr>
							<td id="size" style="text-align: right;"> 资源尺寸:</td>
							<td id="resourceSizeDiv"> 
								 <input class="easyui-combotree" type="text" id="resourceSize" name="resourceSize" 
			                		    data-options="fit:true,required:false,validType:'length[1,100]'" style="width:150px;"/>
			                	<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
								onclick="$('#resourceSize').combotree('clear');"/>
							</td>
						</tr>
						<tr>
							<td id="loadUrl" style="text-align: right;"> 资源下载路径:</td>
							<td id="resourceUrlDiv" colspan="3"> 
								 <input class="easyui-validatebox" type="text" id="resourceUrl" name="resourceUrl" missingMessage="请输入资源下载路径"
			                		    data-options="required:false,validType:'length[1,225]'" style="width: 390px;"/>
							</td>	
						</tr>
				   		<tr>
							<td style="text-align: right;"> 资源描述:</td>
		                	<td colspan="3"><textarea id="resourceDesc" name="resourceDesc"
								style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
						</tr>
			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/resource.js"></script>
  </body>
</html>
