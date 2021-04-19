<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
					<label class="ui-label">接口服务名：</label><input name="intfServiceName"
					class="easyui-box ui-text" style="width: 100px;">
					<label class="ui-label">接口类型：</label>
					<mytag:dictionary codeType="INTF_TYPE" id="cx_intfType" name="intfType" isDefaultLine='1' dataOptions="required:false"/>
					<label class="ui-label">接口版本：</label><input name="intfVersion"
					class="easyui-box ui-text" style="width: 100px;">
			</p>
			<a href="#" id="btn-search" style="margin-top:3px;" class="easyui-linkbutton" iconCls="icon-search">查询</a>
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
		</form>
	</div>
	<!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

     <!-- Edit Form -->
     
     
     <div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'版本信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:600px; height:350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id" />
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">城市: </td>
					<td>
					<input id="areaAdd" name="areaName" class="easyui-combotree" data-options="fit:true,required:true" style="text-align: right;"/>
					<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png" 
							onclick="$('#areaAdd').combotree('clear');"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">接口类型:  </td>					
 					<td> 
						<mytag:dictionary codeType="INTF_TYPE" id="intfType" name="intfType"/>  
					</td>
					<td style="text-align: right;"> 接口服务名: </td>
					<td>  					 
					   <input class="easyui-validatebox" type="text" name="intfServiceName" missingMessage="请输入接口服务名"
						data-options="required:true,validType:'length[1,64]'">
					</td>
					<!-- <td>  					 
					   <input id="serviceAdd" class="easyui-combobox"  name="name"
						data-options="required:true,fit:true">
					</td> -->
				</tr>
				<tr>
					<td style="text-align: right;"> 接口版本: </td>
					<td> 					
						 <input class="easyui-validatebox" type="text" name="intfVersion" missingMessage="请输入接口版本"
						data-options="required:true,validType:'length[1,16]'"> 
					</td>

					<td style="text-align: right;">接口版本名称: </td>
					<td> 
						   <input class="easyui-validatebox" type="text" name="intfVersionName" missingMessage="请输入版本接口名称"
							data-options="required:true,validType:'length[1,64]'">
					</td>
				</tr>
				
				<tr>
					<td style="text-align: right;">备注: </td>
					<td> 
						   <input type="text" name="remark"
							data-options="required:true,validType:'length[1,128]'">
					</td>					 
				</tr>
				
				 
				
			</table>
		</form>
	</div>
     
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/sys/appIntfVersion.js"></script>
  </body>
</html>
