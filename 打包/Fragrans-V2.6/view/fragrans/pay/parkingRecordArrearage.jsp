<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:115px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <!-- <label class="ui-label">信息名称:</label><input name="codeName" class="easyui-box ui-text" style="width:100px;"> -->
        </p>
        <p>
         <label>停车记录ID：</label><input type="text" name="parkingId" id="parkingId"/>
         <label>停车点编码：</label><input type="text" name="parkCode" id="parkCode"/>
         <label>泊位编号：</label><input type="text" name="berthCode" id="berthCode"/>
		 </p>
		 <p style="margin:10px">
         <label>停车点地址：</label><input type="text" name="address" id="address"/>
         <label>车牌号：</label><input type="text" name="plateNo" id="plateNo"/>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
        </p>
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
							<td style="text-align: right;"> 停车记录ID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkingId" missingMessage="请输入停车记录ID"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 城市编码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="cityCode" missingMessage="请输入城市编码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车点编号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkCode" missingMessage="请输入停车点编号"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 泊位编号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="berthCode" missingMessage="请输入泊位编号"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车点地址:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="address" missingMessage="请输入停车点地址"
			                		    data-options="required:true,validType:'length[1,256]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 车牌号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="plateNo" missingMessage="请输入车牌号"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 到达时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="arrivalTime" missingMessage="请输入到达时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 离开时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="departureTime" missingMessage="请输入离开时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车应收费用(分):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkFee" missingMessage="请输入停车应收费用(分)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 未付金额(分):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="unpaidFee" missingMessage="请输入未付金额(分)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 超出金额(分):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="beyondFee" missingMessage="请输入超出金额(分)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 折扣金额（分，省多少钱）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="discountFee" missingMessage="请输入折扣金额（分，省多少钱）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 收费状态（00免费01预付费02未交费03预付费超时04特殊停车05包月停车06部分缴费07正常缴费08预缴超额）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="feeState" missingMessage="请输入收费状态（00免费01预付费02未交费03预付费超时04特殊停车05包月停车06部分缴费07正常缴费08预缴超额）"
			                		    data-options="required:true,validType:'length[1,2]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车状态, 1:未驶离 2:处理中 3：欠费:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="status" missingMessage="请输入停车状态, 1:未驶离 2:处理中 3：欠费"
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
				   			     	 <tr>
							<td style="text-align: right;"> 创建人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createdBy" missingMessage="请输入创建人"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 修改人:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updatedBy" missingMessage="请输入修改人"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间"
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
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/pay/parkingRecordArrearage.js"></script>
  </body>
</html>
