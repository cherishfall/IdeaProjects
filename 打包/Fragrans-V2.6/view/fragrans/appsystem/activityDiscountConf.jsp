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
 	 	   <label class="ui-label">关联活动名称:</label><input name="activityName" class="easyui-box ui-text" style="width:100px;">
		   <label class="ui-label">支付方式:</label><mytag:dictionary name="payment"
						id="payment" codeType="PAY_METHOD" dataOptions="required:false" isDefaultLine="1" />
<!--  	 	   <label class="ui-label">开始时间:</label> -->
<!--  	 	   <input class="easyui-datebox" type="text" name="discountStartTime" style="width:160px;"> -->
<!--  	 	   <label class="ui-label">结束时间:</label> -->
<!--  	 	   <input class="easyui-datebox" type="text" name="discountEndTime" style="width:160px;"> -->
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

     <!-- 添加 -->
     <div id="edit-discount" class="easyui-dialog" title="支付折扣配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:680px;height:380px;">  
     	<form id="editDiscountForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		 <input type="hidden" id="areaCodeAdd" name="areaCode" value="" style="width:390px;"/>
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
				   		<tr>
							<td style="text-align: right;">折扣关联活动:</td>
							<td> 
								 <input class="easyui-combobox" type="text" id="activityNameAdd" name="activityId" missingMessage="请输入关联活动名称"
			                		    data-options="required:true,validType:'length[1,36]',editable:false" style="width:150px;"/>
							</td>
							<td style="text-align: right;">活动城市:</td>
							<td>
								<input id="areaNameAdd" name="areaName" style="width: 160px;"
								class="easyui-validatebox" data-options="fit : true,required:true" readonly="readonly">
								<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" 
								style="border-style:none;" onclick="ztreeAdd();"></a>
							</td>	
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">折扣名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="discountName" missingMessage="请输入折扣名称"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>
							<td style="text-align: right;">支付方式:</td>
							<td> 
						 		<mytag:dictionary codeType="PAY_METHOD" id="payment" name="payment" />  
							</td>
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">满额使用条件:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" id="fulluse" name="fulluse"
			                		    data-options="required:false,validType:'length[1,10]'" />
							</td>
							<td style="text-align: right;">折扣比例:</td>
							<td> 
								 <input class="easyui-validatebox easyui-numberspinner" type="text" 
								 		id="discount" name="discount"
			                		    data-options="required:false,min:0,max:100" />
							</td>	
						</tr>
				   		<tr>
							<td style="text-align: right;">折扣有效期开始时间:</td>
							<td> 
								 <input class="easyui-datebox" type="text" id="discountStartTimeAdd" name="discountStartTime" missingMessage="请输入折扣有效期开始时间"
			                		    data-options="required:true,validType:'length[1,20]'" style="width:160px;" />
							</td>
							<td style="text-align: right;">折扣有效期结束时间:</td>
							<td> 
								 <input class="easyui-datebox" type="text" id="discountEndTimeAdd" name="discountEndTime" missingMessage="请输入折扣有效期结束时间"
			                		    data-options="required:true,validType:'length[1,20]'" style="width:160px;"/>
							</td>
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">最大折扣封顶金额:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" id="maxdiscountFee" name="maxdiscountFee"
			                		    data-options="required:false,validType:'length[1,10]'" />
							</td>
							<td style="text-align: right;">是否可叠加其他活动:</td>
							<td> 
						 		<mytag:dictionary codeType="YESORNO" id="isOverly" name="isOverly" dataOptions="required:false"/>  
							</td>	
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">折扣使用描述:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="discountDesc" missingMessage="请输入折扣使用描述（如：满20元打8折）"
			                		    data-options="required:true,validType:'length[1,225]'" />
							</td>
							<td style="text-align: right;">单个用户每日打折次数:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="userDayCount" missingMessage="必填 仅填数字即可"
			                		    data-options="required:false,validType:'length[1,19]'" />
							</td>	
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">每日打折总次数:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="dayCount" missingMessage="必填 仅填数字即可"
			                		    data-options="required:false,validType:'length[1,19]'" />
							</td>
							<td style="text-align: right;">总配置次数:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="allCount" missingMessage="必填 仅填数字即可"
			                		    data-options="required:false,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	 <!-- Edit Form -->
     <div id="edit-win" class="easyui-dialog" title="支付折扣配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:680px;height:380px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		 <input type="hidden" id="areaCodeEdit" name="areaCode" value="" style="width:390px;"/>
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
     		 			<tr>
     		 				<td style="text-align: right;">
								<div id="activityName" style="height:25px;width:110px;text-align: right;">
									折扣关联活动:
								</div>
							</td>
							<td>
								<div id="activityNameDiv" style="height:25px;width:150px;margin:0;padding:0;">
									<input class="easyui-combobox" type="text" id="activityNameEdit" name="activityId" missingMessage="请输入关联活动名称"
					                		    data-options="required:true,validType:'length[1,36]',editable:false" style="width: 180px;"/>
								</div>
							</td>
							<td style="text-align: right;">
								<div id="areaName" style="height:25px;width:120px;text-align: right;">
									活动城市:
								</div>
							</td>
							<td>
								<div id="areaNameDiv" style="height:25px;width:200px;margin:0;padding:0;">
									<input id="areaNameEdit" name="areaName" style="width: 160px;"
									class="easyui-validatebox" data-options="fit : true,required:true">
									<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" 
									style="border-style:none;" onclick="ztreeEdit();"></a>
								</div>
							</td>
							</tr>
				   			<tr>
				   			<td style="text-align: right;">折扣名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="discountName" missingMessage="请输入折扣名称"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>
							<td style="text-align: right;">支付方式:</td>
							<td> 
						 		<mytag:dictionary codeType="PAY_METHOD" id="payment" name="payment" />  
							</td>
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">满额使用条件:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" id="fulluse" name="fulluse"
			                		    data-options="required:false,validType:'length[1,10]'" />
							</td>
							<td style="text-align: right;">折扣比例:</td>
							<td> 
								 <input class="easyui-validatebox easyui-numberspinner" type="text" 
								 		id="discount" name="discount"
			                		    data-options="required:false,min:0,max:100" />
							</td>	
						</tr>
				   		<tr>
							<td style="text-align: right;">折扣有效期开始时间:</td>
							<td> 
								 <input class="easyui-datebox" type="text" id="discountStartTimeEdit" name="discountStartTime" missingMessage="请输入折扣有效期开始时间"
			                		    data-options="required:true,validType:'length[1,20]'" style="width:160px;" />
							</td>
							<td style="text-align: right;">折扣有效期结束时间:</td>
							<td> 
								 <input class="easyui-datebox" type="text" id="discountEndTimeEdit" name="discountEndTime" missingMessage="请输入折扣有效期结束时间"
			                		    data-options="required:true,validType:'length[1,20]'" style="width:160px;"/>
							</td>
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">最大折扣封顶金额:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" id="maxdiscountFee" name="maxdiscountFee"
			                		    data-options="required:false,validType:'length[1,10]'" />
							</td>
							<td style="text-align: right;">是否可叠加其他活动:</td>
							<td> 
						 		<mytag:dictionary codeType="YESORNO" id="isOverly" name="isOverly" dataOptions="required:false"/>  
							</td>	
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">折扣使用描述:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="discountDesc" missingMessage="请输入折扣使用描述（如：满20元打8折）"
			                		    data-options="required:true,validType:'length[1,225]'" />
							</td>
							<td style="text-align: right;">单个用户每日打折次数:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="userDayCount" missingMessage="必填 仅填数字即可"
			                		    data-options="required:false,validType:'length[1,19]'" />
							</td>	
						</tr>
				   			     	 <tr>
				   			<td style="text-align: right;">每日打折总次数:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="dayCount" missingMessage="必填 仅填数字即可"
			                		    data-options="required:false,validType:'length[1,19]'" />
							</td>
							<td style="text-align: right;">总配置次数:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="allCount" missingMessage="必填 仅填数字即可"
			                		    data-options="required:false,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	 <!-- ztree -->
	<div id="ztree" class="easyui-dialog" title="城市" 
		data-options="closed:true,iconCls:'ext-icon-picture',modal:true"  
		style="width: 300px; height: 400px;">
	</div>
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/activityDiscountConf.js"></script>
  </body>
</html>
