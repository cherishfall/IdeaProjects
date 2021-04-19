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
				<label class="ui-label">接口名称：</label><input name="name" class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">接口服务名称：</label><input name="service" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">接口数据：</label><input name="data" class="easyui-box ui-text" style="width:100px;">
			    <label class="ui-label">数据描述：</label><input name="dataDesc" class="easyui-box ui-text" style="width:100px;">
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
		data-options="draggable:true,title:'接口信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:750px; height:350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">接口名称: </td>
					<td>
					 <input class="hidden" type="text" name="id" />
					 <input class="easyui-validatebox" type="text" name="name" missingMessage="请输入接口名称"
	                        data-options="required:true,validType:'length[1,36]'"style="width:250px;" >
 					</td>
				 
					
				</tr>
				<tr>
				    <td style="text-align: right;">接口服务名称: </td>
					<td> 
						   <input class="easyui-validatebox" type="text" name="service" missingMessage="请输入服务名称"
							data-options="required:true,validType:'length[1,256]'" style="width:250px;">
					</td>
				</tr>
				
				<tr>
				    <td style="text-align: right;">接口数据:  </td>
					<td> 						  
						   <!-- <input class="easyui-validatebox" style:"width:250px;" type="text" name="data" missingMessage="请输入接口数据"
							data-options="required:true,validType:'length[1,256]'" style="width:250px;" /> -->
							<textarea class="editor" id="data" name="data" 
									style="height: 60px; width: 580px;"></textarea>
 					</td>
				</tr>
				
				<tr>
				    <td style="text-align: right;"> 数据描述: </td>
					<td >  					 
					   <!-- <input class="easyui-validatebox" type="text" name="dataDesc" missingMessage="请输入数据描述"
						data-options="required:true,validType:'length[1,256]'" style="width:250px;" /> -->
						<textarea class="editor" id="dataDesc" name="dataDesc" 
									style="height: 60px; width: 580px;"></textarea>
					</td>
				</tr>
				
			</table>
		</form>
	</div>
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/sys/interfaceHandle.js"></script>
  </body>
</html>
