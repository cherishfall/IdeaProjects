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
 	 	   <label class="ui-label">日期:</label>
				 <input id="dayTime" name="dayTime" class="easyui-datebox" data-options="width:150" />
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
							<td style="text-align: right;"> 日期:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="dayTime" missingMessage="请输入日期"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 日活（登录用户:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="activityCountLogin" missingMessage="请输入日活（登录用户"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 日活（登录/非登录）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="activityCountTotal" missingMessage="请输入日活（登录/非登录）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 新增注册用户数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="newRegisterCount" missingMessage="请输入新增注册用户数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 新增访问用户数（以新设备访问,包括注册用户和非注册用户）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="newAccessCount" missingMessage="请输入新增访问用户数（以新设备访问,包括注册用户和非注册用户）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 新增次日使用数（新增用户次日仍然在使用的用户数）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="nextDayStillUseCount" missingMessage="请输入新增次日使用数（新增用户次日仍然在使用的用户数）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 启动次数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="startupCount" missingMessage="请输入启动次数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 下载量（ANDROID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="downloadCountAndroid" missingMessage="请输入下载量（ANDROID"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 下载量（IOS）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="downloadCountIos" missingMessage="请输入下载量（IOS）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 总下载量（到目前为止，非日）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="downloadCountAll" missingMessage="请输入总下载量（到目前为止，非日）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建时间,默认SYSDATE:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间,默认SYSDATE"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/activityDaily.js"></script>
  </body>
</html>
