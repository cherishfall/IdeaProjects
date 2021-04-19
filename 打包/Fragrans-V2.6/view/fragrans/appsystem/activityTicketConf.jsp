<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
 	 	   <label class="ui-label">关联活动名称:</label><input name="activityName" class="easyui-box ui-text" style="width:100px;">
 	 	   <label class="ui-label">券类型:</label><mytag:dictionary name="ticketType" id="ticketType" codeType="TICKET_TYPE" isDefaultLine="1" dataOptions="required:false"/>
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- 添加 -->
	<div id="edit-ticket" class="easyui-dialog" title="优惠券策略配置"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width:720px;height:400px;">
		<form id="editTicketForm" class="ui-form" method="post">
			<input type="hidden" type="text" name="id">
			<input type="hidden" id="areaCodeAdd" name="areaCode" value="" style="width:390px;"/>
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">券类型：</td>
					<td colspan="3" style="text-align: left;">
					<input name="ticketType" type="radio" value="1" checked="checked" onclick="hid()"/>抵扣券
					<input name="ticketType" type="radio" value="2"  onclick="hid()"/>满减券
					<input name="ticketType" type="radio" value="3"  onclick="show()"/>折扣券</td>
				</tr>
				<tr>
					<td style="text-align: right;">
						<div id="disc" style="height:25px;width:110px;text-align: right;">
							折扣比例：
						</div>
					</td>
					<td>
						<div id="discountDiv" style="height:25px;width:150px;margin:0;padding:0;">
							<input class="easyui-validatebox easyui-numberspinner" type="text"
							id="discount" name="discount"
							data-options="required:false,validType:'length[1,10]',min:0,max:100" />
						</div>
					</td>
					<td style="text-align: right;">
						<div id="maxdiscFee" style="height:25px;width:120px;text-align: right;">
							最大优惠金额：
						</div>
					</td>
					<td>
						<div id="maxdiscountFeeDiv" style="height:25px;width:150px;margin:0;padding:0;">
							<input class="easyui-validatebox" type="text"
							id="maxdiscountFee" name="maxdiscountFee"
							data-options="required:false,validType:'length[1,10]'" />
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">优惠券关联活动：</td>
					<td><input class="easyui-combobox" type="text" id="activityNameAdd" name="activityId" missingMessage="请输入关联活动名称"
			                		    data-options="required:true,validType:'length[1,36]',editable:false" style="width: 180px;"/></td>
			        <td style="text-align: right;">活动区域:</td>
					<td>
						<input id="areaNameAdd" name="areaName" style="width: 160px;" missingMessage="请添加活动区域"
						class="easyui-validatebox" data-options="fit : true,required:true" readonly="readonly" >
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" 
						style="border-style:none;" onclick="ztreeAdd();"></a>
					</td>
				</tr>
				<tr>
					<!-- <td style="text-align: right;">活动城市:</td>
					<td><input id="areaCode" name="areaCode" missingMessage="请先选择活动主题名称，再选择活动城市"
						class="easyui-combotree" data-options="fit : true,required:true" style="width: 180px;"/>
					</td> -->
					<td style="text-align: right;">券名称：</td>
					<td><input class="easyui-validatebox" type="text"
						name="ticketName" missingMessage="请输入券名称"
						data-options="required:true,validType:'length[1,64]'" style="width: 150px;"/></td>
					<td style="text-align: right;">券面额：</td>
					<td><input class="easyui-numberbox" type="text" id="ticketMoney"
						name="ticketMoney" missingMessage="请输入券面额(单位：分)"
						data-options="required:true,validType:['length[1,10]','equals']" style="width: 180px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">券有效期：</td>
					<td><input class="easyui-validatebox easyui-numberspinner" type="text"
						name="ticketValidity" missingMessage="请输入券有效期(单位：天)"
						data-options="required:true,validType:'length[1,10]'" style="width: 150px;"/></td>
					<td style="text-align: right;">券使用范围：</td>
					<td><mytag:dictionary name="useRange" id="useRange" codeType="TICKET_USE_RANGE" dataOptions="required:true" style="width: 150px;"/>
					
				</tr>
				<tr>
					<td style="text-align: right;">满额使用条件：</td>
					<td><input class="easyui-numberbox" type="text" id="fulluseAdd"
						name="fulluse" data-options="required:false,validType:'length[1,10]'" style="width: 180px;"/></td>
					<td style="text-align: right;">是否可叠加其他活动：</td>
					<td><mytag:dictionary name="isOverly" id="isOverly" codeType="YESORNO" dataOptions="required:false" style="width: 150px;"/>
					<img
						src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#isOverly').combobox('clear');" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">每日最多发行张数：</td>
					<td><input class="easyui-numberbox" type="text"
						name="dayPutcount" missingMessage="请输入每日最多发行张数"
						data-options="required:false,validType:'length[1,19]'" style="width: 180px;"/></td>
					<td style="text-align: right;">可发行总数：</td>
					<td><input class="easyui-numberbox" type="text"
						name="allPutcount" missingMessage="请输入可发行总数"
						data-options="required:false,validType:'length[1,19]'" style="width: 150px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">券背景图片：</td>
					<td><input class="easyui-validatebox" type="text"
						name="ticketBgimage" missingMessage="请输入券背景图片"
						data-options="required:false,validType:'length[1,225]'" style="width: 180px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">券使用描述：</td>
					<td colspan="3"><textarea type="text" id="ticketDescAdd"
						name="ticketDesc" missingMessage="请输入券使用描述（如：满20元使用）" style="height: 40px; width: 490px;" maxlength="225"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="优惠券策略配置"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width:720px;height:400px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<input class="hidden" id="areaCodeEdit" name="areaCode" style="width:390px;"/>
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">券类型：</td>
					<td><p id="ticketTypeEdit"></p></td>
					<td style="text-align: right;">折扣比例：</td>
					<td><p id="discountEdit"></p></td>
				</tr>
				<tr>
					<td style="text-align: right;">最大优惠金额：</td>
					<td><p id="maxdiscountFeeEdit"></p></td>
					<td style="text-align: right;">券名称：</td>
					<td><input class="easyui-validatebox" type="text"
						name="ticketName" missingMessage="请输入券名称"
						data-options="required:true,validType:'length[1,64]'" style="width: 150px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">
						<div id="activityName" style="height:25px;width:110px;text-align: right;">
							优惠券关联活动：
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
							活动区域:
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
					<td style="text-align: right;">券面额：</td>
					<td><input class="easyui-numberbox" type="text"
						name="ticketMoney" missingMessage="请输入券面额(单位：分)"
						data-options="required:true,validType:['length[1,10]','equalsShow','equalsHid']" style="width: 180px;"/></td>
					<td style="text-align: right;">券有效期：</td>
					<td><input class="easyui-validatebox easyui-numberspinner" type="text"
						name="ticketValidity" missingMessage="请输入券有效期(单位：天)"
						data-options="required:true,validType:'length[1,10]'" style="width: 150px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">满额使用条件：</td>
					<td><input class="easyui-numberbox" type="text" id="fulluseEdit"
						name="fulluse" data-options="required:false,validType:'length[1,10]'" style="width: 180px;"/></td>
					<td style="text-align: right;">是否可叠加其他活动：</td>
					<td><mytag:dictionary name="isOverly" id="isOverly" codeType="YESORNO" dataOptions="required:false" style="width: 130px;"/>
					<img
						src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#isOverly').combobox('clear');" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">每日最多发行张数：</td>
					<td><input class="easyui-numberbox" type="text"
						name="dayPutcount" missingMessage="请输入每日最多发行张数"
						data-options="required:false,validType:'length[1,19]'" style="width: 180px;"/></td>
					<td style="text-align: right;">可发行总数：</td>
					<td><input class="easyui-numberbox" type="text"
						name="allPutcount" missingMessage="请输入可发行总数"
						data-options="required:false,validType:'length[1,19]'" style="width: 150px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">券使用范围：</td>
					<td><mytag:dictionary name="useRange" id="useRange" codeType="TICKET_USE_RANGE" dataOptions="required:true" style="width: 150px;"/>
				</tr>
				<tr>
					<td style="text-align: right;">券背景图片：</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="ticketBgimage" missingMessage="请输入券背景图片"
						data-options="required:false,validType:'length[1,225]'" style="width: 490px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">券使用描述：</td>
					<td colspan="3"><textarea type="text" id="ticketDescEdit"
						name="ticketDesc" missingMessage="请输入券使用描述（如：满20元使用）" style="height: 40px; width: 490px;" maxlength="225"></textarea></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- Edit Form -->
	<div id="edit-authArea" class="easyui-dialog" title="授权区域"
		 data-options="closed:true,iconCls:'icon-save',modal:true"
		 style="width:380px;height:200px;">
		<form id="authAreaForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<input class="hidden" id="authAreaCodeEdit" name="areaCode" style="width:390px;"/>
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">
						优惠券关联活动：
					</td>
					<td>
						<span id="authActivityName"></span>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">
						活动区域:
					</td>
					<td>
						<div style="height:25px;width:200px;margin:0;padding:0;">
							<input id="authAreaNameEdit" name="areaName" style="width: 160px;"
								   class="easyui-validatebox" data-options="fit : true,required:true">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'"
							   style="border-style:none;" onclick="ztreeEdit();"></a>
						</div>
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
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/activityTicketConf.js"></script>
</body>
</html>
