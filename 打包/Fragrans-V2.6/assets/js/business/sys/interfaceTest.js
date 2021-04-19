$(function(){
	$.ajax({
		url:'getIP.do',
		success : function(data) {
			$("#gatewayUrl").val(data.ip)
		}
		});
	$('#name').combotree({
		valueField : 'id',
		textField : 'text',
		editable: true,
		keyHandler: {query : function(q) {
			var entertext = $('#name').combotree('getText');
			if (entertext == null || entertext == "") {
			//如果文本框的值为空，或者将文本框的值删除了，重新reload数据
		    $('#name').combotree('reload');
		    $('#name').combotree('clear');
		    $('#name').combotree('setText', q);
		    return;
			}
			if(q.charAt(q.length-1)==" "){
				q=q.substring(0,q.length-1)
				queryComboTree(q, "name");
			}
		}},
	    onChange:function(newValue,oldValue){
	    	$('#result').val('');
	    	$.ajax({
	    		url: '../service/getData.do',
				type : 'post',
				data : {
					id : newValue
				},
				success : function(result) {
					var service = result.service;
					var data = result.data;
					var dataDesc = result.dataDesc;
					$('#service').val(service);
					$('#data').val(data);
					$('#dataDesc').val(dataDesc);
				}
	    	});
	    	$('#name').combotree("clear");
	    }
	});
	function queryComboTree(q, comboid) {
		var datalist = [];
		var combotreeid = "#" + comboid;
		var roots = $(combotreeid).combotree('tree').tree('getRoots');//得到根节点数组
		var entertext = $(combotreeid).combotree('getText');
		$(combotreeid).combotree('setText', q);
		for (i = 0; i < roots.length; i++) {
				if (roots[i].text.indexOf(q) >= 0 && roots[i].text != "") {
				    var org = {
				        "id" : roots[i].id,
				        "text" : roots[i].text
					    };
				    datalist.push(org);
				}
		}
		//如果找到相似的结果，则加载过滤的结果
		if (datalist.length > 0) {
			$(combotreeid).combotree('loadData', datalist);
			$(combotreeid).combotree('setText', q);
			datalist = [];//这里重新赋值是避免再次过滤时，会有重复的记录
			return;
		} else {
			//$(combotreeid).combotree('reload');
			$(combotreeid).combotree('clear');
			$(combotreeid).combotree('setText', q);
			return;
		}
	}
});

function VerificateSendMessage(form) {
	$('#result').val('');
	var appId = $('#appId').val();
	var gatewayUrl = $('#gatewayUrl').val();
	var charset = $('#charset').val();
	var service = $('#service').val();
	var data = $.trim($('#data').val());
	var key = $('#key').val();
	var sign_type = $('#sign_type').val();
	$.ajax({
		url : "verificated.do",
		type : 'post',
		data : {
			appId : appId,
			gatewayUrl : gatewayUrl,
			charset : charset,
			service : service,
			data : data,
			key : key,
			sign_type : sign_type
		},
		dataType:'text',
		success : function(responseText) {
			$('#result').val(responseText);
		},
		error : function(e) {
			$.messager.confirm('提示', '登录超时,点击确定重新登录.', function(r) {
				if(r){
					window.top.location = urls['msUrl'] + "/login.action";
				}
			});
//			$.each(e, function(n, value) {
//				console.log(n + ' = ' + value);
//			});
		}
	});
}

function reset(){   	
	$("#service").val("");
	$("#data").val("");    	
	$("#dataDesc").val("");
	$("#result").val("");
	$('#name').combotree('setValues', "");
}