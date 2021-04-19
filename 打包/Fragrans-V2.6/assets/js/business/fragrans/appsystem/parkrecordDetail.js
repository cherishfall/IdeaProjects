$(function(){
		var parkrecordId = $('#detailParkrecordId').val();
		var detailCityCode = $('#detailCityCode').val();
		
		if(parkrecordId==null||parkrecordId==''||parkrecordId==undefined||parkrecordId.length==15){
			$.messager.confirm('提示', '停车记录id为空或有误', function(r) {
				if(r){
					$('#detail').dialog("close");
				}
			});
		}else{
			$.messager.progress({
	            title:'请稍后',
	            msg:'正在打开停车记录详情...'
			});
			$.ajax({
				url : '../parkrecordDetail/getDetail.do',
				type : 'post',
				data : {
					parkrecordId :parkrecordId,//"202206",
					cityCode:detailCityCode//330110
				},
				success : function(result){
					$.messager.progress('close');
					$('#detailForm').form('clear');
					if(result !=null){
						var parkrecord = result ;
						$('#parkName').html(parkrecord.parkName);//result.parkName
						$('#parkModel').html(sys.dicts.text('PARK_MODEL',parkrecord.parkModel));
						$('#berthCode').html(parkrecord.berthCode);
						$('#plateNo').html(parkrecord.plateNo);
						$('#feeState').html(sys.dicts.text('PARK_STATE',parkrecord.feeState));
						$('#parkFee').html("￥"+toDecimal(parkrecord.parkFee));
						$('#paidFee').html("￥"+toDecimal(parkrecord.paidFee));
						$('#unpaidFee').html("￥"+toDecimal(parkrecord.unpaidFee));
						$('#disCountFee').html("￥"+toDecimal(parkrecord.disCountFee));
						$('#overFlowFee').html("￥"+toDecimal(parkrecord.overFlowFee));
						$('#isAutoHandle').html(sys.dicts.text('YESORNO',parkrecord.isAutoHandle));
						$('#parkLongDesc').html(parkrecord.parkLongDesc);
						$('#arriveTime').html(parkrecord.arriveTime);
						$('#departureTime').html(parkrecord.departureTime);
					}else{
						$.messager.confirm('提示', '该条记录没有详情', function(r) {
							if(r){
								$('#detail').dialog("close");
							}
						});
					}
				
					$('#handleRecord').datagrid({
								rownumbers : true,
								title : '操作详情(双击查看照片)',
								fitColumns : true,
								singleSelect : true,
								maximizable:true,
								width : 750,
								height : 138,
								onDblClickRow : function(index, data) {
									console.log("photo:"+data.photoUrl);
									if(data.photoUrl!=null && data.photoUrl!=''){
										$('#pic').html("<img src=\""+data.photoUrl+"\" alt='' />"); 
										$('#photo').dialog("open");
									}
								},
								columns : [ [
										{
											field : 'photoUrl',
											hidden:true,
										},
										{
											field : 'handleType',
											title : '操作类型',
											width : 80,
											align : 'center',
										},
										{
											field : 'handler',
											title : '操作人',
											width : 80,
											align : 'center',
										},
										{
											field : 'handlerType',
											title : '操作人类型',
											width : 80,
											align : 'center',
										},
										{
											field : 'handleBefore',
											title : '操作前状态',
											width : 60,
										},{
											field : 'handleAfter',
											title : '操作后状态',
											width : 60,
										},{
											field : 'handleTime',
											title : '操作时间',
											width : 120,
										},{
											field : 'handleDesc',
											title : '描述',
											width : 200,
											formatter: function(value,row,index){
							     				if (value!=null&&value.length > 15){
							     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
							     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
							     				}else{
							     					return value;
							     				}
							     		    }
										}]]
							});
							if(result !=null){
								var data=new Object();
								data.total = result.handleRecords.length;
								data.rows = result.handleRecords;
								$("#handleRecord").datagrid("loadData",data);
							}
					}
			});
		}
});	
function toDecimal(x) { 
    var f = parseFloat(x); 
    if (isNaN(f)) { 
      return 0; 
    } 
    f = Math.round(x*100)/100/100; 
    return f; 
  }