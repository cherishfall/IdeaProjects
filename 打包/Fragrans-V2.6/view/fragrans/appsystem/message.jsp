<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
   <script src="<%=basePath%>/assets/js/ckeditor/ckeditor.js"></script>
   <script src="<%=basePath%>/assets/js/ckeditor/samples/js/sample.js"></script>
   <link rel="stylesheet" href="<%=basePath%>/assets/js/ckeditor/samples/css/samples.css">
   <link rel="stylesheet" href="<%=basePath%>/assets/js/ckeditor/samples/toolbarconfigurator/lib/codemirror/neo.css">
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">消息名称:</label>
 	 	   <input id="messageName" name="messageName" class="easyui-box ui-text" style="width:100px;">
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search" onclick="searchForm()">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
      </form>  
     </div> 
     <!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

     <!-- Edit Form -->
     <div id="edit-win" class="easyui-dialog" title="消息列表" data-options="maximizable:true,closed:true,iconCls:'icon-save',modal:true" style="width:750px;height:400px;">  
     	<form id="editForm" class="ui-form"  enctype="multipart/form-data" method="post" >  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
     		 		 <tr>
		          		<td style="text-align: right;">消息分类:</td>
			     	 	<td colspan="3"> 
		         		<input id="messageTopic" name="messageTopicId" class="easyui-combobox"  data-options="fit : true,required:true,editable:false" style="width:240px"/>
	             		<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png" onclick="$('#messageTopic').combotree('clear');" />  
				 		</td>
					 </tr>
   			     	 <tr>
		          		<td id="areaDiv" style="text-align: right;"> 区域配置:</td>
			     	 	<td id="areaNameDiv" colspan="3"> 
		         		<input id="areaName" name="cityCodeArr" class="easyui-combobox"  data-options="fit : true,required:false,editable:false"/>
				 		</td>
				 	 </tr>
					 <tr>
						 <td style="text-align: right;"> 消息名称:</td>
						 <td >
							 <input class="easyui-validatebox" type="text" name="messageName" missingMessage="请输入消息名称"
									data-options="required:true,validType:'length[1,64]'" style="width:240px"/>
						 </td>
					 </tr>
				 	 <tr>
						<td style="text-align: right;"> 消息类型:</td>
					 	<td > 
			 			<mytag:dictionary codeType="MESSAGE_TYPE" id="messageType" name="messageType"
							 dataOptions="required:true,validType:'length[1,10]'" />
						</td>
						 <td style="text-align: right;"> 推送范围:</td>
						 <td >
							 <mytag:dictionary codeType="PUSH_RANGE" id="pushRange" name="pushRange"
											   dataOptions="required:true,validType:'length[1,10]'" />
						 </td>
					 </tr>
					 <tr>
						<td style="text-align: right;"> 用户账号:</td>
				 		<td > 
			 			<input class="easyui-validatebox" type="text" id="userAccount" name="userAccount" missingMessage="请输入消息名称"
              		   			 data-options="required:false,validType:'mobile'"/>
						</td>
						<td style="text-align: right;"> 活动有效期:</td>
						<td >
							<input class="easyui-datetimebox" id="expireDate" name="expireDate" missingMessage="请输入活动有效期" style="width:160px;"
									data-options="required:true,editable:false,validType:'length[1,19]'">
						</td>
					 </tr>
					  <tr>
			 			<td style="text-align: right;"> 是否可点击:</td>
				 		<td >
			 			<mytag:dictionary name="isClick" id="isClick" codeType="YESORNO" dataOptions="required:true,validType:'length[1,10]'"/>
						</td>
					    <td style="text-align: right;"> 是否显示标题和内容:</td>
					    <td >
						<mytag:dictionary name="isDisplayContent" id="isDisplayContent" codeType="YESORNO" dataOptions="required:true,validType:'length[1,10]'"/>
					    </td>
					 </tr>
					 <tr>
			 			<td style="text-align: right;"> 消息图片地址:</td>
				 		<td > 
              	 			<input class="easyui-validatebox" id="messageImage" name="messageImage"  style="width:160px;"
	           				  data-options="required:false,validType:'length[1,225]'">
	           				  <input type="button" id="msgButton" value="上传"/>
              	 			<input type="file" id="msgImage" name="msgImage" style="display:none;">
						</td>
			 			<td style="text-align: right;"> 消息跳转h5页面地址:</td>
				 		<td > 
              	 			<input class="easyui-validatebox" id="messageUrl" name="messageUrl"  style="width:160px;"
	           				  data-options="required:false,validType:'length[1,225]'">
						</td>
					 </tr>
					   <tr>
			 			<td style="text-align: right;vertical-align:middle;"> 消息摘要:</td>
				 	  	<td colspan="3"> 
			 			<textarea id="messageRemark" name="messageRemark" missingMessage="请输入消息摘要"  style="height:50px;width:500px"></textarea>
						</td>
					 	
					 </tr>
					 <tr>
					 	<td colspan="4"> 
						<lable styl e="text-align: right;"> 消息内容:</lable>
							<textarea id="content" name="content" cols="40" rows="2" class="ckeditor" maxlength="500"></textarea> 
						</td>
					 </tr>
   			</table>
     	</form>
  	 </div> 
  	 
  	  <!-- 下发消息 -->
     <div id="edit-push" class="easyui-dialog" title="下发消息" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:630px;height:350px;">  
     	<form id="editPushForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		 <!--模板类型-->
     		 <input class="hidden" type="text" id="templetType" name="templetType">
     		 <!--下发类型-->
     		 <input class="hidden" type="text" id="pushType" name="pushType">
     		 <!--消息名称-->
     		 <input class="hidden" type="text" id="messageId" name="messageId">
     		 <!--消息Id-->
     		 <input class="hidden" type="text" id="messageNamePush" name="messageName">
     		 <!--消息类型-->
     		 <input class="hidden" type="text" id="pushMessageType" name="messageType">
     		
     		 <table cellpadding="5px;">	
						<tr>
							<td style="text-align: right;"> 消息类型:</td>
							<td> 
								<p>用户消息</p>
								 <%-- <mytag:dictionary name="messageType" id="pushMessageType" codeType="PUSH_MESSAGE_TYPE"  style="width:130px;"/> --%>
							</td>
							<td style="text-align: right;"> 推送类型:</td>
							<td> 
								 <mytag:dictionary name="pushRange" id="pushRange" codeType="PUSH_RANGE_TYPE"  style="width:130px;"/>
							</td>
						</tr>
				   		<tr>
							<td style="text-align: right;">用户账号:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="userAccount" 
			                		    data-options="required:false,validType:'length[1,380]'" style="width:400px;"/>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;"> 消息标题:</td>
							<td colspan="3"> 
								 <input class="easyui-validatebox" type="text" name="title" missingMessage="请输入消息标题"
			                		    data-options="required:true,validType:'length[1,64]'" style="width:400px;"/>
							</td>
						</tr>
				   		<tr>
							<td style="text-align: right;"> 推送对象类型:</td>
							<td> 
								 <mytag:dictionary name="pushClientType" id="pushClientType" codeType="PUSH_CLIENT_TYPE"/>
							</td>
							<td style="text-align: right;"> 是否开启声音:</td>
							<td> 
								<mytag:dictionary name="isVoice" id="isVoice" codeType="YESORNO" dataOptions="required:false"/>
							</td>
						</tr>
				   		<tr>
				   			<td style="text-align: right;"> 是否开启振动:</td>
							<td>
								<mytag:dictionary name="isShock" id="isShock" codeType="YESORNO" dataOptions="required:false"/>
							</td>
				   			<td style="text-align: right;"> 是否显示提示:</td>
							<td> 
								<mytag:dictionary name="isDisplay" id="isDisplay" codeType="YESORNO" dataOptions="required:false"/>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;"> 是否可清除:</td>
							<td> 
								<mytag:dictionary name="isClear" id="isClear" codeType="YESORNO" dataOptions="required:false"/>
							</td>
							<td style="text-align: right;"> 是否启动应用:</td>
							<td> 
								<mytag:dictionary name="isOpen" id="isOpen" codeType="YESORNO" dataOptions="required:false"/>
							</td>	
						</tr>
<!-- 						<tr> -->
<!-- 							<td style="text-align: right;"> 任务执行结果描述:</td> -->
<!-- 							<td colspan="3">  -->
<!-- 								 <input class="easyui-validatebox" type="text" name="exeResult" missingMessage="请输入任务执行结果描述" -->
<!-- 			                		    data-options="required:false,validType:'length[1,225]'" style="width:460px;"/> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td style="text-align: right;">消息内容:</td> -->
<!-- 							<td colspan="3"> -->
<!-- 								<textarea id="contentPush" name="content" style="width:460px;height:60px;" maxlength="350"></textarea> -->
<!-- 							</td>				  -->
<!-- 						</tr> -->
				</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/message.js"></script>
  </body>
</html>
