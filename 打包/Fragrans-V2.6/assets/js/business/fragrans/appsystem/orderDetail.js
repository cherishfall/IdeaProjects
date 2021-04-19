$(function(){
	$.messager.progress({
        title:'请稍后',
        msg:'正在打开支付明细...'
	});
	var orderNo = $('#orderNo').val();
	$.ajax({
		url : '../orderDetail/getPaylog.do',
		type : 'post',
		data : {
			orderNo :orderNo,
		},
		success : function(result){
			$.messager.progress('close');
			if(result !=null){
				var parkrecord = result ;
				if(parkrecord.ticketDiscount!=null&&parkrecord.ticketDiscount==100){
					parkrecord.ticketDiscount="不打折";
					}else if(parkrecord.ticketDiscount!=null&&parkrecord.ticketDiscount==0){
						parkrecord.ticketDiscount="免费";
					}else{
						parkrecord.ticketDiscount=parkrecord.ticketDiscount/10+"折";
					}
				if(parkrecord.paymentDiscount!=null&&parkrecord.paymentDiscount==100){
					parkrecord.paymentDiscount="不打折";
				}else if(parkrecord.paymentDiscount!=null&&parkrecord.paymentDiscount==0){
					parkrecord.paymentDiscount="免费";
				}else{
					parkrecord.paymentDiscount=parkrecord.paymentDiscount/10+"折";
				}
				if(parkrecord.ticketNo!=null&&parkrecord.ticketNo=="(null)"){
					parkrecord.ticketNo="";
				}
				$('#parkFee').html("￥"+toDecimal(parkrecord.parkFee));
				$('#isActivity').html(sys.dicts.text('YESORNO',parkrecord.isActivity));
				$('#activityType').html(sys.dicts.text('ORDER_ACTIVITY_TYPE',parkrecord.activityType));
				$('#activityName').html(parkrecord.activityName);
				$('#ticketName').html(parkrecord.ticketName);
				$('#ticketNo').html(parkrecord.ticketNo);
				$('#ticketMoney').html("￥"+toDecimal(parkrecord.ticketMoney));
				$('#ticketDiscount').html(parkrecord.ticketDiscount);
				$('#paymentDiscount').html(parkrecord.paymentDiscount);
				$('#redboxFee').html("￥"+toDecimal(parkrecord.redboxFee));
				$('#ticketFee').html("￥"+toDecimal(parkrecord.ticketFee));
				$('#discountFee').html("￥"+toDecimal(parkrecord.discountFee));
				$('#payFee').html("￥"+toDecimal(parkrecord.payFee));
				$('#isPaid').html(sys.dicts.text('IS_PAID',parkrecord.isPaid));
                $('#batchpayNo').html(parkrecord.batchpayNo);
                $('#memberCardFee').html("￥"+toDecimal(parkrecord.memberCardFee));
			}else{
				$.messager.confirm('提示', '该条支付记录没有支付明细', function(r) {
					if(r){
						$('#paylog').dialog("close");
					}
				});
			}
		}
		
	});
});	
