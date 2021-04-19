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
			<label class="ui-label">账单日期:</label>
				 <input id="statdate" name="statdate" class="easyui-datebox" data-options="width:150" />
			<label class="ui-label">区域名称:</label><input name="cityCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
			<label class="ui-label">交易订单编号:</label><input name="orderNo" class="easyui-box ui-text" style="width:200px;">
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
							<td style="text-align: right;"> 城市代码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="cityCode" missingMessage="请输入城市代码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易订单编号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderNo" missingMessage="请输入交易订单编号"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车点ID:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkId" missingMessage="请输入停车点ID"
			                		    data-options="required:true,validType:'length[1,36]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车记录id:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkrecordId" missingMessage="请输入停车记录id"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 车牌号码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="plateNo" missingMessage="请输入车牌号码"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 支付方式：1支付宝支付；2微信APP支付；3微信公众号支付；4余额支付；:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="payType" missingMessage="请输入支付方式：1支付宝支付；2微信APP支付；3微信公众号支付；4余额支付；"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 订单类型：1停车订单；2退费订单:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="orderType" missingMessage="请输入订单类型：1停车订单；2退费订单"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 仅限APP上支付的支付金额:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="price" missingMessage="请输入仅限APP上支付的支付金额"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 退款编码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="refundNo" missingMessage="请输入退款编码"
			                		    data-options="required:true,validType:'length[1,32]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 退款费用:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="refundFee" missingMessage="请输入退款费用"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 泊位编号:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="berthCode" missingMessage="请输入泊位编号"
			                		    data-options="required:true,validType:'length[1,25]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车点名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkName" missingMessage="请输入停车点名称"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车时长:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkDurations" missingMessage="请输入停车时长"
			                		    data-options="required:true,validType:'length[1,64]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 驶入时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="arriveTime" missingMessage="请输入驶入时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 驶离时间:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="departureTime" missingMessage="请输入驶离时间"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 <div id="exportOrderNomalList" class="easyui-dialog" title="导出账单"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 200px;" singleSelect:false>
		<form id="exportOrderNomalListForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
					<label>开始日期:</label> 
					<input id="startDate" name="startDate" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
					<label>结束日期:</label> 
					<input id="endDate" name="endDate" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
				<label class="ui-label">城市名称:</label>
					<input id="cityId" name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
				</div>
				</div>
			</div>
		</form>
	</div>
  	 <div id="orderSpmsList" class="easyui-dialog" title="获取账单"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 200px;" singleSelect:false>
		<form id="orderSpmsListForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
					<label>账单日期:</label> 
					<input id="statdate" name="statDate" class="easyui-datebox" data-options="width:150" />
					<br/>&nbsp;<br/> 
					<label class="ui-label">城市名称:</label>
					<input id="cityCode" name="cityCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
				</div>
				</div>
			</div>
		</form>
	</div>
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/rca/orderSpms.js"></script>
  </body>
</html>
