<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
   <script type="text/javascript" src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">分享活动名称:</label>
 	 	   <input id="activityShareId" name="activityShareId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/activityShareUser/getActivityShareTree.do',fit : true,
						idField : 'id',treeField : 'activityShareName',required:false"/>
 	 	   <label class="ui-label">用户账号:</label>
 	 	   <input name="userAccount" class="easyui-box ui-text" style="width:100px;">
 	 	   <label class="ui-label">分享介质:</label>
 	 	   <mytag:dictionary codeType="SHARE_SOURCE" id="source" name="source"
					isDefaultLine='1' dataOptions="required:false" />
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

<!--      Edit Form -->
<!--      <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">   -->
<!--      	<form id="editForm" class="ui-form" method="post">   -->
<!--      		 <input class="hidden" type="text" name="id"> -->
<!--      		<input class="hidden" name="deleted"> -->
     		
<!--      		 <table cellpadding="5px;">	 -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 分享活动名称:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="activityShareName"  -->
<!-- 			                		    data-options="required:true,validType:'length[1,64]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 用户ID:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="userId" missingMessage="请输入用户ID" -->
<!-- 			                		    data-options="required:true,validType:'length[1,64]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 用户账号:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="userAccount" missingMessage="请输入用户账号" -->
<!-- 			                		    data-options="required:true,validType:'length[1,64]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 分享介质(微信好友，微信朋友圈，QQ等):</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="source" missingMessage="请输入分享介质(微信好友，微信朋友圈，QQ等)" -->
<!-- 			                		    data-options="required:true,validType:'length[1,10]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 停车记录编号:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="parkrecordId" missingMessage="请输入停车记录编号" -->
<!-- 			                		    data-options="required:true,validType:'length[1,64]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 订单编号:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="orderNo" missingMessage="请输入订单编号" -->
<!-- 			                		    data-options="required:true,validType:'length[1,64]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 通知类型(200成功；100失败):</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="status" missingMessage="请输入通知类型(200成功；100失败)" -->
<!-- 			                		    data-options="required:true,validType:'length[1,10]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 操作标示 ADD：增加 UPDATE:修改 DELETE:删除:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="flag" missingMessage="请输入操作标示 ADD：增加 UPDATE:修改 DELETE:删除" -->
<!-- 			                		    data-options="required:true,validType:'length[1,16]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 创建人:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="createdBy" missingMessage="请输入创建人" -->
<!-- 			                		    data-options="required:true,validType:'length[1,36]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 修改人:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="updatedBy" missingMessage="请输入修改人" -->
<!-- 			                		    data-options="required:true,validType:'length[1,36]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 创建时间:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间" -->
<!-- 			                		    data-options="required:true,validType:'length[1,19]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			     	 <tr> -->
<!-- 							<td style="text-align: right;"> 更新时间:</td> -->
<!-- 							<td>  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="updateTime" missingMessage="请输入更新时间" -->
<!-- 			                		    data-options="required:true,validType:'length[1,19]'" /> -->
<!-- 							</td>					  -->
<!-- 						</tr> -->
<!-- 				   			</table> -->
<!--      	</form> -->
<!--   	 </div>  -->
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/activity/activityShareUser.js"></script>
  </body>
</html>
