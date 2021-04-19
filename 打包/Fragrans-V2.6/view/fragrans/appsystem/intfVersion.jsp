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
 	 	   <!-- <label class="ui-label">信息名称:</label><input name="codeName" class="easyui-box ui-text" style="width:100px;"> -->
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
     <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
				   			     	 <tr>
							<td style="text-align: right;"> 城市:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="areaCode" missingMessage="请输入城市"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 接口类型（1APP接口；2spms接口）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="intfType" missingMessage="请输入接口类型（1APP接口；2spms接口）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 接口服务名:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="intfServiceName" missingMessage="请输入接口服务名"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 接口版本:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="intfVersion" missingMessage="请输入接口版本"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 版本接口名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="intfVersionName" missingMessage="请输入版本接口名称"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 备注:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="remark" missingMessage="请输入备注"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> :</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createBy" missingMessage="请输入"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> :</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updateBy" missingMessage="请输入"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> :</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="flag" missingMessage="请输入"
			                		    data-options="required:true,validType:'length[1,8]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> :</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updateTime" missingMessage="请输入"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> :</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/app/intfVersion.js"></script>
  </body>
</html>
