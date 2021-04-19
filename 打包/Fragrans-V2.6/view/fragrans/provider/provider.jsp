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
				 <label class="ui-label">商户名称:</label><input name="providerName" class="easyui-box ui-text" style="width:100px;"> 
				 <label class="ui-label">公司名称:</label><input name="companyName" class="easyui-box ui-text" style="width:100px;"> 
				 <label class="ui-label">是否有效:</label><mytag:dictionary codeType="YESORNO" id="deleted" name="deleted" isDefaultLine='1' dataOptions="required:false"/> 
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

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="商户信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 530px; height: 300px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">所属商户:</td>
					<td><input class="easyui-validatebox" type="text"
						name="providerNo" missingMessage="请输入商户编号"
						data-options="required:true,validType:'length[1,36]'" readonly="readonly" style="background-color:#eee"/></td>
					<td style="text-align: right;">商户名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="providerName" missingMessage="请输入商户名称"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">公司名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="companyName" missingMessage="请输入公司名称"
						data-options="required:true,validType:'length[1,64]'" /></td>
					<td style="text-align: right;">公司地址:</td>
					<td><input class="easyui-validatebox" type="text"
						name="address" missingMessage="请输入公司地址"
						data-options="required:false,validType:'length[1,128]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">联系人:</td>
					<td><input class="easyui-validatebox" type="text"
						name="contact" missingMessage="请输入联系人"
						data-options="required:true,validType:'length[1,32]'" /></td>
					<td style="text-align: right;">联系电话:</td>
					<td><input class="easyui-validatebox" type="text" name="phone"
						missingMessage="请输入联系电话"
						data-options="required:true,validType:'mobile'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">Email:</td>
					<td><input class="easyui-validatebox" type="text" name="email"
						missingMessage="请输入Email"
						data-options="required:false,validType:'email'" /></td>
					<td style="text-align: right;">是否有效:</td>
					<td><mytag:dictionary name="deleted" id="deleted" codeType="YESORNO"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">接入有效期:</td>
					<td><input class="easyui-datetimebox" type="text"
						name="validityDate" id="validityDate"
						data-options="required:true,editable:false" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- allot Form -->
	<div id="allot" class="easyui-dialog" title="分配"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 400px; height: 300px;">
		<form id="allotForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<input class="hidden" type="text" name="providerNo">
			<div class="ui-edit">
				<div class="fitem">
				<label>商户名称:</label> <input class="easyui-validatebox" type="text"
						readonly="readonly" name="providerName" data-options="required:true"></input>
				</div>
				<div class="fitem">
					<label>授权类型:</label> 
					<mytag:dictionary name="authType" id="authType"
							codeType="PROVIDER_AUTH_TYPE" />
				</div>
				<div class="fitem" id="park">
					<label>分配停车场:</label> 
					<select class="easyui-combobox" id="parkIds"
						name="parkIds" data-options="width:200"></select>
				</div>
				<div class="fitem" id="area">
					<label>分配区域:</label>
					<input class="easyui-combobox" id="areaCodes"
						name="areaCodes" data-options="width:200"/>
				</div>
			</div>
		</form>
		<!-- Search panel start -->
		<!-- <div class="datagrid-toolbar" region="north" style="height: 62px;"
			title="过滤条件"
			data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
			<form id="searchForm_park">
				<p class="ui-fields">
					 <label class="ui-label">停车场名称:</label><input name="name" class="easyui-box ui-text" style="width:100px;"> 
				</p>
				<a href="#" id="btn-search" class="easyui-linkbutton"
					iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
					class="easyui-linkbutton" onclick="$('#searchForm_park').form('clear');"
					style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
			</form>
		</div>
		 Search panel end
		DataList 
		<div region="center" border="false">
			<table id="park-list"></table>
		</div> -->
	</div>
	
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/provider/provider.js"></script>
</body>
</html>
