$package('sys.main');

sys.main = function() {
	return {
		treeSelect : function() {
			var _this = $(this);
			var title = _this.text();
			var url = _this.attr('href');
			sys.main.addTab(title, url);
			return false;
		},
		treeInit : function() {
			var $items = $('#tree-box').find(".menu-item");
			$items.bind('click', this.treeSelect);
		},
		addTab : function(_title, _url) {
			var boxId = '#layout_center_tabs';
			if ($(boxId).tabs('exists', _title)) {
				var tab = $(boxId).tabs('getTab', _title);
				var index = $(boxId).tabs('getTabIndex', tab);
				$(boxId).tabs('select', index);
				//点击菜单刷新
				/*if (tab && tab.find('iframe').length > 0) {
					var _refresh_ifram = tab.find('iframe')[0];
					_refresh_ifram.contentWindow.location.href = _url;
				}*/
			} else {
				var _content = "<iframe scrolling='auto' frameborder='0' src='"
						+ _url + "' style='width:100%; height:100%'></iframe>";
				$(boxId).tabs('add', {
					title : _title,
					content : _content,
					closable : true
				});
			}
		},
		menuHover : function() {
			// 菜单鼠标进入效果
			$('.menu-item').hover(function() {
				$(this).stop().animate({
					paddingLeft : "15px"
				}, 200, function() {
					$(this).addClass("orange");
				});
			}, function() {
				$(this).stop().animate({
					paddingLeft : "0px"
				}, function() {
					$(this).removeClass("orange");
				});
			});
		},
		modifyPwd : function() {
			var pwdForm = $("#pwdForm");
			if (pwdForm.form('validate')) {
				var parentId = $('#search_parentId').val();
				$("#edit_parentId").val(parentId);
				sys.saveForm(pwdForm, function(data) {
					$('#modify-pwd-win').dialog('close');
					pwdForm.form('reset');
				});
			}
		},
		init : function() {
			this.treeInit();
			this.menuHover();
			$('#btn-pwd-submit').click(this.modifyPwd);
		}
	};
}();

$(function() {
	sys.main.init();
	$('#userInfo').dialog({
		buttons : [ {
			text : '关闭',
			handler : function() {
				$('#userInfo').dialog('close');
			}
		} ]
	});
	$('#passwordDialog').dialog({
		buttons : [ {
			text : '保存',
			handler : function() {
				$('#passwordForm').form('submit', {
					url : 'modifyPwd.do',
					type : 'post',
					success : function(result) {
						var res = eval('(' + result + ')');
						$.messager.show({
							title : '提示',
							msg : res.msg
						});
						if(res.success){
							$('#passwordDialog').dialog('close');
							$('#passwordForm').form('reset');
						}
					}
				});
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#passwordDialog').dialog('close');
			}
		} ]
	});
	$('#lockDialog').dialog({
		buttons : [ {
			text : '重新登录',
			handler : function() {
				$('#lockForm').form('submit', {
					url : 'clearLock.do',
					type : 'post',
					success : function(result) {
						var res = $.parseJSON(result);
						if(res.success){
							$.messager.show({
								title : '提示',
								msg : res.msg
							});
							$('#lockDialog').dialog('close');
							$('#lockForm').form('reset');
						}else{
							$.messager.show({
								title : '提示',
								msg : res.msg
							});
						}
					}
				});
			}
		} ]
	});
	
	$('#pwd').keyup(function () { 
		var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
		var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
		var enoughRegex = new RegExp("(?=.{6,}).*", "g"); 
		var pwdStrong = 0;
		if (false == enoughRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass(' pw-defule'); 
			pwdStrong = 1;
			 //密码小于六位的时候，密码强度图片都为灰色 
		} 
		else if (strongRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass(' pw-strong'); 
			pwdStrong = 3;
			 //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
		} 
		else if (mediumRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass(' pw-medium'); 
			pwdStrong = 2;
			 //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
		} 
		else { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-weak'); 
			pwdStrong = 1;
			 //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
		} 
		$('#pwdStrong').val(pwdStrong);
		return true; 
	}); 
});
function showMyInfoFun() {
	$('#userInfo').dialog('open');
	$.ajax({
		url : 'getCurrentUser.do',
		type : 'post',
		dataType : 'json',
		success : function(data) {
			$('#userInfoForm').form('load', data);
		}
	});
}
function lockWindowFun() {
//	$.messager.confirm('确认', '确认锁定系统?（解锁需重新登录）', function() {
		$.ajax({
			url : 'clearCurrentUser.do',
			type : 'post',
			dataType : 'json',
			success : function(data) {
				$('#lockDialog').dialog('open');
				$("#lockForm input[name=password]").val('');
			}
		});
//	});
}