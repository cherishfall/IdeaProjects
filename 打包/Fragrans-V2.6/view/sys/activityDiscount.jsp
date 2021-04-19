<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<%@include file="/view/inc.jsp"%>
	<script type="text/javascript" src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
	<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">活动名称：</label><input name="discountName" class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">活动时间：</label><input name="startTime" type="text" class="easyui-datebox" value="" style="width:168px"></input>
				<label class="ui-label">到：</label><input name="endTime" type="text" class="easyui-datebox" value="" style="width:168px"></input>
			    <label class="ui-label">是否有效：</label>
			    <mytag:dictionary name="isValid" id="isValid" codeType="YESORNO"
					isDefaultLine='1' dataOptions="required:false" />
			</p>
			<a href="#" id="btn-search" style="margin-top:3px;" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
		</form>
	</div>
	<!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     	<table id="data-list"></table>
     </div>
     
	 <!-- Edit Form -->    
     <div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'折扣活动配置',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:700px; height:480px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<input type="hidden" type="text" name="id">
			<input class="hidden" id="areaCodeEdit" name="areaCode" style="width:390px;"/>
			<table cellpadding="5px;">
			<tr>
			     <td style="text-align: right;">选择主题:</td>
				 <td>
				 	<input class="easyui-combobox" type="text"
						id="activityTopicName" name="activityTopicId"
						data-options="required:true,validType:'length[1,36]'" style="width:180px"/></td>		
				 <td style="text-align: right;">活动名称:</td>
				 <td>
				 	<input class="easyui-validatebox" type="text"
						name="discountName" data-options="required:false,validType:'length[1,64]'"
						style="width: 180px;" /></td>		
			</tr>	
			<tr>
				<td style="text-align: right;">开始时间:</td>
				<td>
					<input class="easyui-datebox" type="text"
						name="startTime" missingMessage="请输入活动开始时间"
						data-options="required:true" style="width: 180px;"/></td>
				<td style="text-align: right;">结束时间:</td>
				<td>
					<input class="easyui-datebox" type="text"
						name="endTime" missingMessage="请输入活动结束时间"
						data-options="required:true" style="width: 180px;"/></td>
			</tr>
			<tr>
			     <td style="text-align: right;">选择地区:</td>
				 <td>  
				 	<input id="areaNameEdit" name="areaName"
						class="easyui-validatebox" data-options="fit : true,required:true"> 
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'"
						style="border-style: none;" onclick="ztreeAdd();"></a></td>
						
				<td style="text-align: right;">业务类型:</td>
				<td> 
					<input class="easyui-combobox" id="busiType"
						name="busiTypeCode"/></td>
			</tr>
			<tr>
			     <td style="text-align: right;">折扣策略:</td>
			     <td>
			     	<input class="easyui-combobox" id="discountStrat"
						name="discountStratCode"/></td>
				 <td style="text-align: right;">满折金额:</td>
				 <td>
				 	<input class="easyui-numberbox" type="text"
						name="fulluse" data-options="required:true,validType:'length[1,64]'"
						style="width: 180px;" /></td>		
			</tr>
			<tr>
			     <td style="text-align: right;">最大折扣金额:</td>
			     <td>
			     	<input class="easyui-validatebox" type="text"
						name="maxdiscountFee" missingMessage="请输入最大折扣金额"
						data-options="required:true,validType:'length[1,64]'"
						style="width: 180px;" /></td>
				  <td style="text-align: right;">是否可叠加券:</td>
				  <td> 
				  	<mytag:dictionary codeType="YESORNO" id="isCoverly" name="isCoverly" dataOptions="required:true"/>  
							</td>	
			</tr>
			<tr>
				  <td style="text-align: right;">是否有效:</td>
				  <td> 
				  	<mytag:dictionary codeType="YESORNO" id="isValid" name="isValid" dataOptions="required:true"/>  
				  </td>	
				  <td style="text-align: right;">排序号:</td>
				  <td>
				 	<input class="easyui-numberbox" type="text"
						name="displayNum" data-options="required:false,validType:'length[1,64]'"
						style="width: 180px;" />
				  </td>	
			</tr>		
			</table>
			<div id="tt" class="easyui-tabs" style="width:500px;height:200px;">   
			    <div title="基本策略" data-options="closable:false" style="padding:20px;display:block;">   
			        <table id="btn-dg-base"></table>
			    </div>   
			    <div title="拍照策略" data-options="closable:false" style="overflow:auto;padding:20px;display:block;">   
			        <table id="btn-dg-photo"></table>    
			    </div>   
			    <div title="付款策略" data-options="closable:false" style="padding:20px;display:block;">   
			        <table id="btn-dg-paytime"></table>    
			    </div>
			    <div title="批量缴费策略" data-options="closable:false" style="padding:20px;display:block;">   
			        <table id="btn-dg-batchpay"></table>    
			    </div>    
			</div>  
		</form>
	</div>
	
	<!-- ztree -->
	<div id="ztree" class="easyui-dialog" title="城市" 
		data-options="closed:true,iconCls:'ext-icon-picture',modal:true"  
		style="width: 300px; height: 400px;">
	</div>
	
	
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/activityDiscount.js"></script>
  </body>
</html>
