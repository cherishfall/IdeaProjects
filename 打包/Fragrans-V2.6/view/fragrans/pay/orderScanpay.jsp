<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:100px;" title="过滤条件"
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
			<label class="ui-label">收费员账号:</label><input name="collectorAccount" class="easyui-box ui-text" style="width:100px;">
			<label class="ui-label">停车记录id:</label><input name="parkrecordId" class="easyui-box ui-text" style="width:100px;">
			<label class="ui-label">订单编号:</label><input name="orderNo" class="easyui-box ui-text" style="width:150px;">
			<label class="ui-label">车牌号:</label><input name="palteNo" class="easyui-box ui-text" style="width:100px;">
			<label class="ui-label">支付方式:</label><mytag:dictionary name="payType" id="payTypeSel" codeType="PAY_METHOD" isDefaultLine='1' dataOptions="required:false" />
		</p>
		<p class="ui-fields">
			<label class="ui-label">订单状态:</label><mytag:dictionary name="orderStatus" id="orderStatusSel" codeType="ORDER_STATUS" isDefaultLine='1' dataOptions="required:false" />
			<label class="ui-label">订单来源:</label><mytag:dictionary name="source" id="sourceSel" codeType="SCAN_ORDER_SOURCE" isDefaultLine='1' dataOptions="required:false" />
			<label class="ui-label">归属地区:</label><input id="areaId" name="areaId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
						
			<label class="ui-label">查询时间从</label>
			<input id="startDateSel" name="startDate" class="easyui-datebox" data-options="width:100" />
			<label class="ui-label">至</label>
			<input id="endDateSel" name="endDate" class="easyui-datebox" data-options="width:100" />
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

	<!-- refund -->
	<div id="refundOrderScanpay" class="easyui-dialog" title="退款"
		 data-options="closed:true,iconCls:'icon-save',modal:true"
		 style="width: 500px; height: 500px;">
		<form id="refundOrderScanpayForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">付款日期:</td>
					<td><input class="easyui-validatebox" type="text"
							   name="payTime" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">订单编号:</td>
					<td><input class="easyui-validatebox" type="text"
							   name="orderNo" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">实付款:</td>
					<td><input class="easyui-validatebox" type="text"
							   name="price" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">支付方式:</td>
					<td><input class="easyui-validatebox" type="text"
							   name="payType" readonly="readonly" style="width:200px;background:#eee"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款成功金额(元):</td>
					<td><input class="easyui-validatebox" type="text"
							   name="sucRefund" readonly="readonly" style="width:200px;background:#eee;color:blue;font-weight:bold"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款金额(元):</td>
					<td><input class="easyui-numberbox" type="text"
							   id="refundFee" name="refundFee" style="width:200px" data-options="required:true"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">退款原因:</td>
					<td colspan="3"><textarea id="reason" name="reason"
											  style="height: 100px; width: 350px;" maxlength="100"></textarea></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="exportOrderScanpay" class="easyui-dialog" title="导出清单报表"
		 data-options="closed:true,iconCls:'icon-save',modal:true"
		 style="width: 350px; height: 340px;" singleSelect:false>
		<form id="exportOrderScanpayForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem" style="position:absolute; top:50px;">
					<div style="padding:5px;">
						<label>开始日期:</label>
						<input name="startDate" class="easyui-datebox" data-options="width:150" />
					</div>
					<div style="padding:5px;">
						<label>结束日期:</label>
						<input name="endDate" class="easyui-datebox" data-options="width:150" />
					</div>
					<div style="padding:5px;">
						<label>订单来源:</label>
						<mytag:dictionary name="source" id="source" codeType="SCAN_ORDER_SOURCE" style="width:150" dataOptions="required:false" />
					</div>
					<div style="padding:5px;">
						<label>选择区域:</label>
						<input name="areaCode" class="easyui-combotree" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
					</div>
					<div style="padding:5px;">
						<label>收费员账号:</label>
						<input class="easyui-validatebox" type="text" name="collectorAccount" style="width:150px;"/>
					</div>
					<div style="padding:5px;">
						<label>停车点/场名称:</label>
						<input class="easyui-validatebox" type="text" name="parkName" style="width:150px;"/>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div id="exportAchievement" class="easyui-dialog" title="导出业绩报表"
		 data-options="closed:true,iconCls:'icon-save',modal:true"
		 style="width: 360px; height: 270px;" singleSelect:false>
		<form id="exportAchievementForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem" style="position:absolute; top:50px;">
					<div style="padding:5px;">
						<label>开始日期:</label>
						<input name="startDate" class="easyui-datebox" data-options="width:150" />
					</div>
					<div style="padding:5px;">
						<label>结束日期:</label>
						<input name="endDate" class="easyui-datebox" data-options="width:150" />
					</div>
					<div style="padding:5px;">
						<label>选择区域:</label>
						<input name="areaCode" class="easyui-combotree" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
					</div>
					<p style="text-align: center">注：日期必选，区域可选</p>
					<p>已选区域，按收费员分组统计；未选区域，按区域分组统计</p>
				</div>
			</div>
		</form>
	</div>

  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/pay/orderScanpay.js"></script>
  </body>
</html>
