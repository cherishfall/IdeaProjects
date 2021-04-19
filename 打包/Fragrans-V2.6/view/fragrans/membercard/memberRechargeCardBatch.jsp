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
 	 	  <p class="ui-fields">
 	 	   <label class="ui-label">批次ID:</label>
 	 	   	<input name="batchId" class="easyui-numberbox" style="width: 100px;">
	       <label class="ui-label">是否已领取:</label>
			<mytag:dictionary name="isRecevice" id="isRecevice" codeType="YESORNO"
					isDefaultLine='1' dataOptions="required:false" />
		   <label class="ui-label">生成人:</label>
		   <input name="producer" class="easyui-box ui-text" style="width: 100px;">
		   <label class="ui-label">领取人:</label>
		   <input name="recevicer" class="easyui-box ui-text" style="width: 100px;">
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
							<td style="text-align: right;"> 批次号码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="batchId" missingMessage="请输入批次号码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 充值卡面额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="denomination" missingMessage="请输入充值卡面额"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 生成人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="producer" missingMessage="请输入生成人"
			                		    data-options="required:true,validType:'length[1,36]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 生成时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="prodeceTime" missingMessage="请输入生成时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 生成张数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="prodeceCount" missingMessage="请输入生成张数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 是否被领取，1是0否:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="isRecevice" missingMessage="请输入是否被领取，1是0否"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 领取人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="recevicer" missingMessage="请输入领取人"
			                		    data-options="required:true,validType:'length[1,36]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 领取时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="receiveTime" missingMessage="请输入领取时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 到期时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="validDate" missingMessage="请输入到期时间"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 操作标示 ADD：增加 UPDATE:修改 DELETE:删除:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="flag" missingMessage="请输入操作标示 ADD：增加 UPDATE:修改 DELETE:删除"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	 	 <!-- Edit Form -->
     <div id="create_win" class="easyui-dialog" title="生成充值卡" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">  
     	<form id="createForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		 <table cellpadding="5px;">	
		   		<tr>
					<td style="text-align: right;"> 批次ID:</td>
					<td> 
						 <input class="easyui-numberbox" type="text" id="batchId" name="batchId" missingMessage="请输入批次ID"
		               		    readonly="readonly" style="width:200px;" />
					</td>					 
				</tr>
		   		<tr>
					<td style="text-align: right;"> 充值卡面额:</td>
					<td> 
						<input id="denomination" class="easyui-combobox" name="denomination"  style="width:200px;" data-options="required:true,editable:false" />  
					</td>					 
				</tr>
				<tr>
					<td style="text-align: right;"> 充值卡有效期:</td>
					<td> 
						 <input class="easyui-datebox" type="text" name="validDate" missingMessage="请输入充值卡面额"
		               		   style="width:200px;" data-options="required:true,editable:false" />
					</td>					 
				</tr>
		   		<tr>
					<td style="text-align: right;"> 生成张数:</td>
					<td> 
						 <input class="easyui-numberbox" type="text" name="prodeceCount" missingMessage="请输入生成张数"
		               		    max="5000" style="width:200px;" data-options="required:true,validType:'length[1,4]'" />
					</td>					 
				</tr>
		   	</table>
		   	<div style="width:80px;float:left;position: relative;left:58%;top:70px;">
		 		<a id="submit" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'" style="margin:0 auto;">提交</a>
			</div> 
		    <div style="width:80px;float:left;position: relative;left:58%;top:70px;">
				<a id="close" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'">关闭</a>
			</div>
     	</form>
  	 </div>
  	 
  	   <!-- Edit Form -->
     <div id="recevice_win" class="easyui-dialog" title="领取充值卡" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">  
     	<form id="receviceForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     			<table cellpadding="15px;" style="padding:15px;">	
		   		<tr>
					<td style="text-align: right;"> 批次ID:</td>
					<td> 
						<input class="easyui-combobox" id="receviceBatchId"
						   name="batchId"/>
					</td>					 
				</tr>
		   	</table>
		   	<div style="width:80px;float:left;position: relative;left:25%;top:90px;">
		 		<a id="receviceSubmit" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'" style="margin:0 auto;">提交</a>
			</div> 
		    <div style="width:80px;float:left;position: relative;left:25%;top:90px;">
				<a id="receviceClose" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'">关闭</a>
			</div>
     	</form>
  	 </div>
  	 
  	 <!-- autoPay -->
	 <div id="recordDialog" class="easyui-dialog"
		data-options="draggable:true,title:'会员充值卡',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:1100px; height:500px;">
		<div id="cc" class="easyui-layout" style="width: 1080px; height: 450px;">
			<div class="datagrid-toolbar" region="north" style="height: 62px;"
				title="过滤条件"
				data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
				<form id="recordSearchForm">
					<p class="ui-fields">
					   <label class="ui-label">充值卡号:</label>
			 	 	   	<input name="rechargeCardNo" class="easyui-box ui-text" style="width: 130px;">
			 	 	   <label class="ui-label">是否已使用:</label>
						<mytag:dictionary name="isUsed" id="isUsed" codeType="YESORNO"
								isDefaultLine='1' dataOptions="required:false" />
				       <label class="ui-label">是否已过期:</label>
						<mytag:dictionary name="isOvertime" id="isOvertime" codeType="YESORNO"
								isDefaultLine='1' dataOptions="required:false" />
				       <label class="ui-label">是否已领取:</label>
						<mytag:dictionary name="isRecevice" id="isRecevice" codeType="YESORNO"
								isDefaultLine='1' dataOptions="required:false" />
			 	 	   	<a href="#" id="btn-search-card" class="easyui-linkbutton" iconCls="icon-search">查询</a> 
						<a href="#" id="btn-reset-card" class="easyui-linkbutton" onclick="$('#recordSearchForm').form('clear');"
						style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
					</p>
				</form>
			</div>
			<div data-options="region:'center',title:'会员充值卡批次列表'"  >
				<form id="editForm" class="ui-form" method="post" style="width: 1040px; height:330px;">
					<table id="record-data"></table>
				</form>
			</div>
		</div>
	</div>  
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/membercard/memberRechargeCardBatch.js"></script>
  </body>
</html>
