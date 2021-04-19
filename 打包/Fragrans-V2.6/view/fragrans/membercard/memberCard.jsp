<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 100px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">用户账号:</label>
					<input name="userAccount" class="easyui-box ui-text" style="width: 130px;">
 	 	   		<label class="ui-label">会员卡编码:</label>
 	 	   			<input name="memberCardNo" class="easyui-numberbox" style="width: 130px;">
 	 	   		<label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">是否开启免密支付 :</label>
 	 	   			<mytag:dictionary name="isNoPwdpay" id="isNoPwdpay" codeType="YESORNO"
						isDefaultLine='1' dataOptions="required:false" />
				<br/>
				<label class="ui-label">退款状态 :</label>
				<mytag:dictionary name="refundStatus" id="refundStatusSel" codeType="MEMBER_CARD_REFUND_STATUS"
								  isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">会员卡状态 :</label>
 	 	   			<mytag:dictionary name="status" id="status" codeType="MEMBER_CARD_STATUS"
						isDefaultLine='1' dataOptions="required:false" />
				<a href="#" id="btn-search" class="easyui-linkbutton"
				   iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
												   class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
												   style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
			</p>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="编辑"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 400px; height: 300px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">归属用户ID:</td>
					<td><input class="easyui-validatebox" type="text"
						name="userId" missingMessage="请输入归属用户ID"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">用户账号:</td>
					<td><input class="easyui-validatebox" type="text"
						name="userAccount" missingMessage="请输入用户账号"
						data-options="required:true,validType:'length[1,32]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">区级代码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="areaCode" missingMessage="请输入区级代码"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">会员卡编码（3301+1594128
						城市编码+手机号前三后四）:</td>
					<td><input class="easyui-validatebox" type="text"
						name="memberCardNo"
						missingMessage="请输入会员卡编码（3301+1594128 城市编码+手机号前三后四）"
						data-options="required:true,validType:'length[1,11]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">卡内余额:</td>
					<td><input class="easyui-validatebox" type="text"
						name="balance" missingMessage="请输入卡内余额"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">支付密码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="payPassword" missingMessage="请输入支付密码"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">是否开启免密支付 1是0否:</td>
					<td><input class="easyui-validatebox" type="text"
						name="isNoPwdpay" missingMessage="请输入是否开启免密支付 1是0否"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">操作标示 ADD：增加 UPDATE:修改
						DELETE:删除:</td>
					<td><input class="easyui-validatebox" type="text" name="flag"
						missingMessage="请输入操作标示 ADD：增加 UPDATE:修改 DELETE:删除"
						data-options="required:true,validType:'length[1,16]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">创建人:</td>
					<td><input class="easyui-validatebox" type="text"
						name="createdBy" missingMessage="请输入创建人"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">修改人:</td>
					<td><input class="easyui-validatebox" type="text"
						name="updatedBy" missingMessage="请输入修改人"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">创建时间:</td>
					<td><input class="easyui-validatebox" type="text"
						name="createTime" missingMessage="请输入创建时间"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">更新时间:</td>
					<td><input class="easyui-validatebox" type="text"
						name="updateTime" missingMessage="请输入更新时间"
						data-options="required:true,validType:'length[1,19]'" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	 <!-- autoPay -->
	 <div id="autoPay" class="easyui-dialog"
		data-options="draggable:true,title:'自动支付列表',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:400px; height:300px; padding: 10px;">
		<form id="editFormAutoPay" class="ui-form" method="post">
			<table id="autoPay-data"></table>
		</form>
	</div> 
	
	<!-- autoPay -->
	 <div id="recordDialog" class="easyui-dialog"
		data-options="draggable:true,title:'会员卡记录列表',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:900px; height:500px;">
		<div id="cc" class="easyui-layout" style="width: 880px; height: 450px;">
			<div class="datagrid-toolbar" region="north" style="height: 62px;"
				title="过滤条件"
				data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
				<form id="recordSearchForm">
					<p class="ui-fields">
						<label class="ui-label">操作类型 :</label>
		 	 	   			<mytag:dictionary name="handleType" id="handleType" codeType="MEMBER_CARD_HANDLE_TYPE"
							isDefaultLine='1' dataOptions="required:false" /> 
						<label class="ui-label">操作对象:</label>
							<input name="objId" class="easyui-box ui-text" style="width: 200px;">
						<label class="ui-label">状态 :</label>
 	 	   					<mytag:dictionary name="changeStatus" id="changeStatus" codeType="ORDER_STATUS"
						isDefaultLine='1' dataOptions="required:false" />
					</p>
					<a href="#" id="btn-search-record" class="easyui-linkbutton" iconCls="icon-search">查询</a> 
					<a href="#" id="btn-reset-record" class="easyui-linkbutton" onclick="$('#recordSearchForm').form('clear');"
						style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
				</form>
			</div>
			<div data-options="region:'center',title:'余额变动记录'"  >
				<form class="ui-form" method="post" style="width: 840px; height:330px;">
					<table id="record-data"></table>
				</form>
			</div>
		</div>
	</div>
	
	 <!-- refund -->
	<div id="refund" class="easyui-dialog" title="退款"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 550px; height: 380px;">
		<form id="refundForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="userId">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">用户账号:</td>
					<td colspan="2">
					<input class="easyui-validatebox" type="text" name="userAccount" id="userAccount"
		                style=" width: 200px;" readonly="readonly" data-options="required:true,validType:'length[1,11]'" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">会员卡号:</td>
					<td colspan="2">
					<input class="easyui-validatebox" type="text" name="memberCardNo" id="memberCardNo"
			                style=" width: 200px;" readonly="readonly" data-options="required:true,validType:'length[1,11]'" />
			        </td>
				</tr>
				<tr>
					<td style="text-align: right;">当前余额:</td>
					<td colspan="2">
					<input class="easyui-validatebox" type="text" name="balance" id="balance"
			                style=" width: 200px;" readonly="readonly" data-options="required:true,validType:'length[1,10]'" />
			        </td>
				</tr>
				<tr>
					<td style="text-align: right;">可退余额:</td>
					<td colspan="2">
					<input class="easyui-validatebox" type="text" name="refundBalance" id="refundBalance"
			                style=" width: 200px;" readonly="readonly" data-options="required:true,validType:'length[1,10]'" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">退款原因:</td>
					<td colspan="3"><textarea id="reason" name="reason"
					style="height: 100px; width: 350px;" maxlength="100" data-options="required:true"></textarea></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="processMemberCardDiv" class="easyui-dialog" data-options="draggable:true,title:'申办会员',iconCls:'icon-save',closed:true,modal:true "
		 style="width: 640px; height: 360px; padding: 10px;">
		<form id="processMemberCardForm" class="ui-form" method="post" style="width: 560px; height: 220px;">
			<table cellpadding="5px 0;" style="padding-top: 20px;">
				<tr>
					<td style="text-align: right;">选择城市：</td>
					<td colspan="2">
						<input id="cityCode" name="cityCode" class="easyui-combotree"
							   data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
							idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true" style="width: 170px;height:30px;"/>
						<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
							 onclick="$('#cityCode').combotree('clear');" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">姓名：</td>
					<td>
						<input class="easyui-validatebox" type="text"
							   name="name" id="name" data-options="required:true" placeholder="请输入姓名" style="width: 170px;height:30px;"/>
					</td>
					<td style="text-align: right;">手机号码：</td>
					<td>
						<input class="easyui-validatebox" type="text"
							   name="phone" id="phone" data-options="required:true,validType:'mobile'" placeholder="请输入手机号码"
							   style="width: 170px;height:30px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">车牌号：</td>
					<td>
						<input class="easyui-validatebox" type="text"
							   name="plateNo" id="plateNo" data-options="required:true,validType:'plateNo'" placeholder="请输入车牌号"
							   style="width: 170px;height:30px;"/>
					</td>
					<td style="text-align: right;">车牌颜色：</td>
					<td>
						<mytag:dictionary id="plateColor" name="plateColor" codeType="PLATE_COLOR" style="width: 170px;height:30px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">金额：</td>
					<td>
						<input class="easyui-validatebox" type="text"
							   name="price" id="price" data-options="required:true" placeholder="请输入金额（单位：元）" style="width: 170px;height:30px;"/>
					</td>
					<td style="text-align: right;">是否开通代扣：</td>
					<td>
						<mytag:dictionary name="isAutoPay" id="isAutoPay" codeType="YESORNO" style="width: 170px;height:30px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">原泊车卡号及备注信息：</td>
					<td colspan="3">
						<input class="easyui-validatebox" type="text"
							   name="remark" id="remark" data-options="required:true" placeholder="请输入原泊车卡号及备注信息" style="width: 440px;height:40px;"/>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/membercard/memberCard.js"></script>
</body>
</html>
