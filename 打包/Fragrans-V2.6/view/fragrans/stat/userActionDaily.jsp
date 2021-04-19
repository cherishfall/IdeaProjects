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
 	 	   <label class="ui-label">统计日期:</label>
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
							<td style="text-align: right;"> 统计日期:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="dayTime" missingMessage="请输入统计日期"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 设备号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="deviceNo" missingMessage="请输入设备号"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 用户账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="userId" missingMessage="请输入用户账号"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 个人信息功能使用次数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="personalInfoCount" missingMessage="请输入个人信息功能使用次数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 电子钱包功能使用次数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="walletCount" missingMessage="请输入电子钱包功能使用次数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 预约功能使用次数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="bookCount" missingMessage="请输入预约功能使用次数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 消息功能使用次数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="messageCount" missingMessage="请输入消息功能使用次数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 设置功能使用次数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="setCount" missingMessage="请输入设置功能使用次数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 搜索功能使用次数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="searchCount" missingMessage="请输入搜索功能使用次数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 缴费次数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="payCount" missingMessage="请输入缴费次数"
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
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/stat/userActionDaily.js"></script>
  </body>
</html>
