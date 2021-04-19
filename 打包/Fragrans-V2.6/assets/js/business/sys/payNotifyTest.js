function sendNotify(form) {
	var buyerAccount = $('#buyerAccount').val();
	var orderNo = $('#orderNo').val();
	var payMent = $('#payMent').val();
	var payTime = $('#payTime').datetimebox('getValue');
	$.messager.confirm('确认', '确定要执行此操作吗？', function(r) {
		if(r){
			$.messager.progress({
		        title:'请稍后',
		        msg:'正在发送通知...'
			});
			$.ajax({
				url : 'sendNotify.do',
				type : 'post',
				data : {
					buyerAccount : buyerAccount,
					orderNo : orderNo,
					payMent : payMent,
					payTime : payTime
				},
				success : function(result){
					$.messager.progress('close');
					console.log(result);
					$.messager.show({
						msg : result.msg,
						title : '提示'
					});
					if (result.success) {
						$('#data-list').datagrid('reload');
					}
				}
			});
		}
	});
}
