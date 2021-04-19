<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
   <style>
   	.font-oblique{
   		font-weight:bold;
   		font-style:oblique;
   	}
   </style>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:102px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">提交人:</label>
 	 	   	<input name="userAccount" class="easyui-box ui-text" style="width: 100px;">
 	 	   <label class="ui-label">包月手机号:</label>
 	 	   	<input name="phone" class="easyui-box ui-text" style="width: 100px;"> 
 	 	   <label class="ui-label">车牌号码:</label>
 	 	   	<input name="plateNo" class="easyui-box ui-text" style="width: 100px;">  
 	 	   <label class="ui-label">车牌颜色:</label>
 	 	    <mytag:dictionary name="plateColor" id="userPlateColor" codeType="PLATE_COLOR" isDefaultLine='1' dataOptions="required:false" />
 	 	    <label class="ui-label">审核状态:</label>
 	 	    <mytag:dictionary name="verifyStatus" id="verifyStatus" codeType="MONTHLY_REVIEW_STATUS" isDefaultLine='1' dataOptions="required:false" />    
        </p>
        <p class="ui-fields">
       	   <label class="ui-label">包月开始时间：</label>
	 	   	  <input id="searchStartTime" name="startTime" type="text" class="easyui-datebox" value="" style="width:168px"></input>
	       <label class="ui-label">包月结束时间：</label>
	   	      <input id="searchEndTime" name="endTime" type="text" class="easyui-datebox" value="" style="width:168px"></input>
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

	<div id="handle" class="easyui-dialog" title="续包审核" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:660px; height:480px; padding:5px;">
	     <form id="verifyForm" class="ui-form" method="post"> 
	     <input class="hidden" type="text" name="id">
	     <fieldset>
	     	<legend><span class="font-oblique">本次提交信息:</span></legend>
	     	<table cellpadding="5px;">	
   	       	<tr>
				<td style="text-align: right;width:100px; "> 区域名称:</td>
				<td>
				     <p id="areaName"></p> 
				</td>
				<td style="text-align: right;width:100px;"> 包月停车点:</td>
				<td> 
					 <p id="parkName"></p>
				</td>
			</tr>
	   		<tr>
				<td style="text-align: right;"> 父级包月记录ID:</td>
				<td> 
					<p id="parentId"></p>
				</td>
				<td style="text-align: right;"> 包月手机号:</td>
				<td> 
					<p id="phone"></p>
				</td>					 
			</tr>
	   		<tr>
				<td style="text-align: right;"> 车牌号:</td>
				<td> 
					<p id="plateNo"></p>
				</td>					 
				<td style="text-align: right;"> 车牌颜色:</td>
				<td> 
					<p id="plateColor"></p>
				</td>					 
			</tr>
	   		<tr>
				<td style="text-align: right;"> 开始时间:</td>
				<td> 
					<p id="startTime"></p>
				</td>					 
				<td style="text-align: right;"> 结束时间:</td>
				<td> 
					<p id="endTime"></p>
				</td>					 
			</tr>
	   		<tr>
				<td style="text-align: right;"> 包月描述:</td>
				<td colspan="8">
					<p id="note" type="text"></p> 
				</td>					 
			</tr>
  			</table>
	     </fieldset> 
	     <fieldset>
	     	<legend><span class="font-oblique">历史续包信息:</span></legend>
	     	<table cellpadding="5px;">	
   	       	<tr>
				<td style="text-align: right; width:100px;"> 区域名称:</td>
				<td>
				     <p id="_areaName"></p> 
				</td>
				<td style="text-align: right;width:100px;"> 包月停车点:</td>
				<td> 
					 <p id="_parkName"></p>
				</td>
			</tr>
	   		<tr>
				<td style="text-align: right;"> 包月记录ID:</td>
				<td> 
					<p id="_monthlyId"></p>
				</td>
				<td style="text-align: right;"> 包月手机号:</td>
				<td> 
					<p id="_phone"></p>
				</td>					 
			</tr>
	   		<tr>
				<td style="text-align: right;"> 车牌号:</td>
				<td> 
					<p id="_plateNo"></p>
				</td>					 
				<td style="text-align: right;"> 车牌颜色:</td>
				<td> 
					<p id="_plateColor"></p>
				</td>					 
			</tr>
			<tr>
				<td style="text-align: right;"> 包月费用:</td>
				<td> 
					<p id="_monthlyFee"></p>
				</td>
				<td style="text-align: right;"> 包月状态:</td>
				<td> 
					<p id="_status"></p>
				</td>
			</tr>
	   		<tr>
				<td style="text-align: right;"> 开始时间:</td>
				<td> 
					<p id="_startTime"></p>
				</td>					 
				<td style="text-align: right;"> 结束时间:</td>
				<td> 
					<p id="_endTime"></p>
				</td>					 
			</tr>
	   		<tr>
				<td style="text-align: right;"> 包月描述:</td>
				<td colspan="8">
					<p id="_note" type="text"></p> 
				</td>					 
			</tr>
  			</table>
	     </fieldset> 
	     <fieldset>
	     	<legend><span class="font-oblique">处理续包审核:</span></legend>
		     	<div style="width:80px;float:left;position: relative;left:80%;">
				 	<a id="verifyRule" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-book_open'" style="margin:0 auto;">审核规则</a>
				</div> 
  		 		<table cellpadding="5px;" style="margin:center">	
		   		<tr>
					<td style="text-align: right;"> 包月金额:</td>
					<td> 
						 <input class="easyui-numberbox" type="text" id="advideMonthlyFee" name="monthlyFee" missingMessage="请输入建议包月时长"
		               		    data-options="required:false,validType:'length[1,4]'" style="width:200px;"/>
					</td>					 
				</tr>
		   		<tr>
					<td style="text-align: right;">建议包月时长:</td>
					<td> 
						 <input class="easyui-numberbox" type="text" id="adviceMonthlyDuration" name="adviceMonthlyDuration" missingMessage="请输入建议包月时长"
		               		    data-options="required:false,validType:'length[1,2]'" style="width:200px;"/>
					</td>					 
				</tr>
		   		<tr>
					<td style="text-align: right;"> 建议开始时间:</td>
					<td> 
						 <input class="easyui-datebox" type="text" id="adviceStartTime" name="adviceStartTime" missingMessage="请输入建议开始时间"
		               		    data-options="required:false,validType:'length[1,10]',editable:false"  style="width:200px;"/>
		               	  <img class="iconImg ext-icon-cross" onclick="$('#adviceStartTime').datebox('setValue', '');;" title="清空" />
					</td>					 
				</tr>
		   		<tr>
					<td style="text-align: right;"> 驳回原因:</td>
					<td colspan="2">
						<textarea name="verifyInfo" id="verifyInfo" style="height: 100px; width: 450px;" maxlength="50"></textarea>
					</td>
				</tr>
		   	</table>
			<div style="width:80px;float:left;position: relative;left:20%;">
		 		<a id="passBut" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'" style="margin:0 auto;">通过</a>
			</div> 
		    <div style="width:80px;float:left;position: relative;left:50%;">
				<a id="rejectBut" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'">驳回</a>
			</div>
	     </fieldset> 
    	</form>
	</div>
	
	<div id="rule" class="easyui-dialog" title="审核规则" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px; height:420px; padding:5px;">
		<h4>1、包月金额：</h4>
		<ul>
		  <li>单位:￥（元）；</li>
		  <li>“通过”时不可为空；</li>
		  <li>“驳回”时若不建议续包可不填；</li>
		</ul>
		<h4>2、建议包月时长：</h4>
		<ul>
		  <li>单位：（月）；</li>
		  <li>可不填；</li>
		  <li>必须大于零且不可超过本区域最大包月时长；</li>
		</ul>
		<h4>3、建议开始时间</h4>
		<ul>
		  <li>可不填；</li>
		  <li>大于或等于最近一次包月截止时间及当前时间</li>
		</ul>
		<h4>4、驳回原因</h4>
		<ul>
		  <li>驳回时必填</li>
		</ul>
	</div>
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/monthly/parkMonthlyRecordLog.js"></script>
  </body>
</html>
