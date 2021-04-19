<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:110px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">支付方式:</label>
				<mytag:dictionary name="payType" id="payType" codeType="PAY_METHOD"
					isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">停车记录ID:</label><input name="parkrecordId"
					class="easyui-box ui-text" style="width: 140px;">
					
        </p>
        <p class="ui-fields">
				<label class="ui-label">开始时间:</label><input name="startTime" id="startTime"
					class="easyui-datetimebox" style="width: 180px;"> 
				<label class="ui-label">结束时间:</label><input name="endTime" id="endTime"
					class="easyui-datetimebox" style="width: 180px;">
				<a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
                <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('reset');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a> 
		</p>
        <hidden name="orderType"  value="1"/>
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
							<td style="text-align: right;"> 城市代码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="cityCode" missingMessage="请输入城市代码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 城市名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="cityName" missingMessage="请输入城市名称"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 区级代码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="areaCode" missingMessage="请输入区级代码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 区域名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="areaName" missingMessage="请输入区域名称"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 车牌号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="plateNo" missingMessage="请输入车牌号"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 车牌颜色 蓝0;黄1;白2;黑3:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="plateColor" missingMessage="请输入车牌颜色 蓝0;黄1;白2;黑3"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 用户ID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="userId" missingMessage="请输入用户ID"
			                		    data-options="required:true,validType:'length[1,36]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 用户账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="userAccount" missingMessage="请输入用户账号"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 买家账号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="buyerAccount" missingMessage="请输入买家账号"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 手机号码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="mobile" missingMessage="请输入手机号码"
			                		    data-options="required:true,validType:'length[1,20]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易订单编号(唯一):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderNo" missingMessage="请输入交易订单编号(唯一)"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车记录ID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkrecordId" missingMessage="请输入停车记录ID"
			                		    data-options="required:true,validType:'length[1,36]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 支付方式:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="payType" missingMessage="请输入支付方式"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 实际支付金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="payFee" missingMessage="请输入实际支付金额"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单标题:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="subject" missingMessage="请输入订单标题"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单描述:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderBody" missingMessage="请输入订单描述"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderTime" missingMessage="请输入订单时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 支付时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="payTime" missingMessage="请输入支付时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 记录创建时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入记录创建时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 记录同步时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="syncTime" missingMessage="请输入记录同步时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 开票时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="invoiceTime" missingMessage="请输入开票时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 开票状态 1已开票 2未开票 3开票中 4开票失败:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="invoiceState" missingMessage="请输入开票状态 1已开票 2未开票 3开票中 4开票失败"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单类型 APP1;线下2;包月3;充值4:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderType" missingMessage="请输入订单类型 APP1;线下2;包月3;充值4"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单来源 中间件1;业务后台2;三码合一3:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderSource" missingMessage="请输入订单来源 中间件1;业务后台2;三码合一3"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 包月开始时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="monthStart" missingMessage="请输入包月开始时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 包月结束时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="monthEnd" missingMessage="请输入包月结束时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 保留字段1:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="reserve1" missingMessage="请输入保留字段1"
			                		    data-options="required:true,validType:'length[1,255]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 保留字段2:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="reserve2" missingMessage="请输入保留字段2"
			                		    data-options="required:true,validType:'length[1,255]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 保留字段3:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="reserve3" missingMessage="请输入保留字段3"
			                		    data-options="required:true,validType:'length[1,255]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/invoice/invoiceOrder.js"></script>
  </body>
</html>
