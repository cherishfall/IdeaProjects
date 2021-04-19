<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <!-- <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">信息名称:</label><input name="codeName" class="easyui-box ui-text" style="width:100px;">
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
      </form>  
     </div>  -->
     <!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

     <!-- Edit Form -->
     <div id="edit-win" class="easyui-dialog" title="图标配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:560px;height:400px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
				   			     	 <tr>
							<td style="text-align: right;"> 缩放比例最小:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="zoomMin" missingMessage="请输入缩放比例最小"
			                		    data-options="required:true,validType:'length[1,9]'" />
							</td>	
							<td style="text-align: right;"> 缩放比例最大:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="zoomMax" missingMessage="请输入缩放比例最大"
			                		    data-options="required:true,validType:'length[1,9]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车点个数最小:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="countMin" missingMessage="请输入停车点个数最小"
			                		    data-options="required:true,validType:'length[1,9]'" />
							</td>	
							<td style="text-align: right;"> 停车点个数最大:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="countMax" missingMessage="请输入停车点个数最大"
			                		    data-options="required:true,validType:'length[1,9]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 空闲停车点图标:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="parkPointIcon" missingMessage="请输入空闲停车点图标"
			                		    data-options="required:true,validType:'length[1,32]'" style="width:370px;"/>
							</td>	
						</tr>
						<tr>
							<td style="text-align: right;"> 空闲停车场图标:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="parkLotIcon" missingMessage="请输入空闲停车场图标"
			                		    data-options="required:true,validType:'length[1,32]'" style="width:370px;"/>
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 预约停车场图标:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="subsParkLotIcon" missingMessage="请输入预约停车场图标"
			                		    data-options="required:true,validType:'length[1,32]'" style="width:370px;"/>
							</td>	
						</tr>
						<tr>
							<td style="text-align: right;"> 繁忙停车点图标:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="busyParkPointIcon" missingMessage="请输入繁忙停车点图标"
			                		    data-options="required:true,validType:'length[1,32]'" style="width:370px;"/>
							</td>				 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 繁忙停车场图标:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="busyParkLotIcon" missingMessage="请输入繁忙停车场图标"
			                		    data-options="required:true,validType:'length[1,32]'" style="width:370px;"/>
							</td>
						</tr>
						<tr>	
							<td style="text-align: right;"> 繁忙预约停车场图标:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="busySubsParkLotIcon" missingMessage="请输入繁忙预约停车场图标"
			                		    data-options="required:true,validType:'length[1,32]'" style="width:370px;"/>
							</td>				 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 静态停车场图标:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="staticParkLotIcon" missingMessage="请输入静态停车场图标"
			                		    data-options="required:false,validType:'length[1,32]'" style="width:370px;"/>
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/parkMapicon.js"></script>
  </body>
</html>
