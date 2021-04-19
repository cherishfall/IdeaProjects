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
							<td style="text-align: right;"> 用户ID，关联APP_USER:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="userId" missingMessage="请输入用户ID，关联APP_USER"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 用户昵称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="nickName" missingMessage="请输入用户昵称"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 注册城市代码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="cityCode" missingMessage="请输入注册城市代码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 邮箱地址:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="email" missingMessage="请输入邮箱地址"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 邮箱是否已激活 0:未激活, 1:已激活:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="isEmailActivated" missingMessage="请输入邮箱是否已激活 0:未激活, 1:已激活"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> :</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="photoUrl" missingMessage="请输入"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> :</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="address" missingMessage="请输入"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> :</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="remark" missingMessage="请输入"
			                		    data-options="required:true,validType:'length[1,256]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 操作标示 ADD：增加 UPDATE:修改 DELETE:删除:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="flag" missingMessage="请输入操作标示 ADD：增加 UPDATE:修改 DELETE:删除"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建时间,默认SYSDATE:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间,默认SYSDATE"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 更新时间,默认SYSDATE:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updateTime" missingMessage="请输入更新时间,默认SYSDATE"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 保留字段1:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="attribute1" missingMessage="请输入保留字段1"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 保留字段2:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="attribute2" missingMessage="请输入保留字段2"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 保留字段3:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="attribute3" missingMessage="请输入保留字段3"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 保留字段4:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="attribute4" missingMessage="请输入保留字段4"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 保留字段5:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="attribute5" missingMessage="请输入保留字段5"
			                		    data-options="required:true,validType:'length[1,128]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/user/userExt.js"></script>
  </body>
</html>
