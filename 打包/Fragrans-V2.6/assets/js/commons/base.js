$package('sys');
var sys = {
	/* Json 工具类 */
	isJson : function(str) {
		var obj = null;
		try {
			obj = sys.paserJson(str);
		} catch (e) {
			return false;
		}
		var result = typeof (obj) == "object"
				&& Object.prototype.toString.call(obj).toLowerCase() == "[object object]"
				&& !obj.length;
		return result;
	},
	paserJson : function(str) {
		return eval("(" + str + ")");
	},
	infoAuto : function(msg, timeout) {
		$.messager.show({
			title : '提示',
			msg : msg,
			showType : 'show',
			timeout : timeout || 3000
		});
	},
	info : function(msg, callback) {
		$.messager.alert('消息', msg, 'info', callback);
	},
	infoNoRowSelect : function(callback) {
		sys.info('请选择要操作的记录', callback);
	},
	error : function(msg, callback) {
		$.messager.alert('错误', msg, 'error', callback);
	},
	warn : function(msg, callback) {
		$.messager.alert('警告', msg, 'warning', callback);
	},
	/* 弹出框 */
	alert : function(title, msg, icon, callback) {
		$.messager.alert(title, msg, icon, callback);
	},
	/* 弹出框 */
	confirm : function(title, msg, callback) {
		$.messager.confirm(title, msg, callback);
	},
	progress : function(title, msg) {
		var win = $.messager.progress({
			title : title || '请稍等',
			msg : msg || '正在加载数据...'
		});
	},
	closeProgress : function() {
		$.messager.progress('close');
	},
	/* 重新登录页面 */
	toLogin : function() {
		window.top.location = urls['msUrl'] + "/login.action";
	},
	checkLogin : function(data) {// 检查是否登录超时
		if (data.logoutFlag) {
			sys.closeProgress();
			sys.alert('提示', "登录超时,点击确定重新登录.", 'error', sys.toLogin);
			return false;
		}
		return true;
	},
	ajaxSubmit : function(form, option) {
		form.ajaxSubmit(option);
	},
	ajaxJson : function(url, option, callback) {
		$.ajax(url, {
			type : 'post',
			dataType : 'json',
			data : option,
			async : false,
			cache : false,  
			success : function(data) {
				// 坚持登录
				if (!sys.checkLogin(data)) {
					return false;
				}
				if ($.isFunction(callback)) {
					callback(data);
				}
			},
			error : function(response, textStatus, errorThrown) {
				try {
					sys.closeProgress();
					var data = $.parseJSON(response.responseText);
					// 检查登录
					if (!sys.checkLogin(data)) {
						return false;
					} else {
						sys.alert('提示', data.msg || "请求出现异常,请联系管理员", 'error');
					}
				} catch (e) {
					sys.alert('提示', "请求出现异常,请联系管理员.", 'error');
				}
			},
			complete : function() {

			}
		});
	},
	submitForm : function(form, callback, dataType) {
		var option = {
			type : 'post',
			dataType : dataType || 'json',
			success : function(data) {
				if ($.isFunction(callback)) {
					callback(data);
				}
			},
			error : function(response, textStatus, errorThrown) {
				try {
					sys.closeProgress();
					var data = $.parseJSON(response.responseText);
					// 检查登录
					if (!sys.checkLogin(data)) {
						return false;
					} else {
						sys.alert('提示', data.msg || "请求出现异常,请联系管理员", 'error');
					}
				} catch (e) {
					sys.alert('提示', "请求出现异常,请联系管理员.", 'error');
				}
			},
			complete : function() {

			}
		}
		sys.ajaxSubmit(form, option);
	},
	saveForm : function(form, callback) {
		if (form.form('validate')) {
			sys.progress('请稍等', '正在保存数据...');
			// ajax提交form
			sys.submitForm(form, function(data) {
				sys.closeProgress();
				if (data.success) {
					if (callback) {
						callback(data);
					} else {
						sys.alert('提示', '保存成功.', 'info');
					}
				} else {
					sys.alert('提示', data.msg, 'error');
				}
			});
		}
	},
	/**
	 * 
	 * @param {}
	 *            url
	 * @param {}
	 *            option {id:''}
	 */
	getById : function(url, option, callback) {
		sys.progress();
		sys.ajaxJson(url, option, function(data) {
			sys.closeProgress();
			if (data.success) {
				if (callback) {
					callback(data);
				}
			} else {
				sys.alert('提示', data.msg, 'error');
			}
		});
	},
	deleteForm : function(url, option, callback) {
		sys.progress();
		sys.ajaxJson(url, option, function(data) {
			sys.closeProgress();
			if (data.success) {
				if (callback) {
					callback(data);
				}
			} else {
				sys.alert('提示', data.msg, 'error');
			}
		});
	}
}

/**
 * 增加formatString功能
 * 
 * 使用方法：formatString('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * 
 * @returns 格式化后的字符串
 */
formatString = function(str) {
	for ( var i = 0; i < arguments.length - 1; i++) {
		str = str.replace("{" + i + "}", arguments[i + 1]);
	}
	return str;
};
/* 将2000-01-00 10:00:00 转成 2000-01-00 */
formatDate = function(value) {
	if (value != null) {
		var str = value.toString();
		if (str) {
			if (str.length > 10) {
				return str.substring(0, 10);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
}
/* 将2000-01-00 10:00:00 转成  10:00 */
formatTime = function(value){
	if (value != null) {
		var str = value.toString();
		if (str) {
			if (str.length > 10) {
				return str.substr(11,5);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
}
/* 表单转成json数据 */
$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
}

/**
 * 初始化Grid按钮 按钮控制
 */
initTbar = function(Grid, tbars, url) {
	var _url = urls['msUrl'] + '/getActionBtn.do';
	var data = {
		'url' : url
	};
	// 查询页面授权的btnType
	sys.ajaxJson(_url, data, function(data) {
		if (data.success) {
			if (data.allType) {
				Grid.treegrid({
					'toolbar' : tbars
				});
			} else {
				var newBars = [];
				jQuery.inArray("John", data.types);
				for ( var i = 0; i < tbars.length; i++) {
					var bar = tbars[i];
					// btnType 为空显示
					if (!bar.btnType) {
						newBars.push(bar);
					} else {
						// 判断btnType是否存在,存在则显示
						if ($.inArray(bar.btnType, data.types) >= 0) {
							newBars.push(bar);
						}
					}
				}
				if (newBars.length > 0) {
					Grid.treegrid({
						'toolbar' : newBars
					});
				}
			}
		}
	});
}

/* easyui datagrid 添加和删除按钮方法 */
$
		.extend(
				$.fn.datagrid.methods,
				{
					addToolbarItem : function(jq, items) {
						return jq
								.each(function() {
									var toolbar = $(this).parent().prev(
											"div.datagrid-toolbar");
									for ( var i = 0; i < items.length; i++) {
										var item = items[i];
										if (item === "-") {
											toolbar
													.append('<div class="datagrid-btn-separator"></div>');
										} else {
											var btn = $("<a href=\"javascript:void(0)\"></a>");
											btn[0].onclick = eval(item.handler
													|| function() {
													});
											btn.css("float", "left").appendTo(
													toolbar).linkbutton(
													$.extend({}, item, {
														plain : true
													}));
										}
									}
									toolbar = null;
								});
					},
					removeToolbarItem : function(jq, param) {
						return jq
								.each(function() {
									var btns = $(this).parent().prev(
											"div.datagrid-toolbar").children(
											"a");
									var cbtn = null;
									if (typeof param == "number") {
										cbtn = btns.eq(param);
									} else if (typeof param == "string") {
										var text = null;
										btns
												.each(function() {
													text = $(this).data().linkbutton.options.text;
													if (text == param) {
														cbtn = $(this);
														text = null;
														return;
													}
												});
									}
									if (cbtn) {
										var prev = cbtn.prev()[0];
										var next = cbtn.next()[0];
										if (prev
												&& next
												&& prev.nodeName == "DIV"
												&& prev.nodeName == next.nodeName) {
											$(prev).remove();
										} else if (next
												&& next.nodeName == "DIV") {
											$(next).remove();
										} else if (prev
												&& prev.nodeName == "DIV") {
											$(prev).remove();
										}
										cbtn.remove();
										cbtn = null;
									}
								});
					}
				});
Date.prototype.pattern = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1, // 月份
		"d+" : this.getDate(), // 日
		"h+" : this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, // 小时
		"H+" : this.getHours(), // 小时
		"m+" : this.getMinutes(), // 分
		"s+" : this.getSeconds(), // 秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
		"S" : this.getMilliseconds()
	// 毫秒
	};
	var week = {
		"0" : "/u65e5",
		"1" : "/u4e00",
		"2" : "/u4e8c",
		"3" : "/u4e09",
		"4" : "/u56db",
		"5" : "/u4e94",
		"6" : "/u516d"
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	if (/(E+)/.test(fmt)) {
		fmt = fmt
				.replace(
						RegExp.$1,
						((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "/u661f/u671f"
								: "/u5468")
								: "")
								+ week[this.getDay() + ""]);
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
}

function getNextDay(nDate) {
	var date = new Date(Date.parse(nDate.replace(/-/g, "/")));
	if (date.getTime() > 0) {
		date.setTime(date.getTime() + 1 * 24 * 60 * 60 * 1000);
		return date.pattern("yyyy-MM-dd HH:mm:ss");
	} else {
		return "";
	}
}

function getYesterDay() {
	var date = new Date();
	date.setTime(date.getTime() - 1 * 24 * 60 * 60 * 1000);
	return date.pattern("yyyy-MM-dd HH:mm:ss");
}

function getYesterDayMorning() {
	var date = new Date();
	date.setTime(date.getTime() - 1 * 24 * 60 * 60 * 1000);
	return date.pattern("yyyy-MM-dd 00:00:00");
}

function getYesterDayEnd(){
	var date = new Date();
	date.setTime(date.getTime() - 1 * 24 * 60 * 60 * 1000);
	return date.pattern("yyyy-MM-dd 23:59:59");
}

function getNowDayMorning() {
	var date = new Date();
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM-dd 00:00:00");
}

function getNowDay() {
	var date = new Date();
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM-dd");
}

function getNowDayNow() {
	var date = new Date();
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM-dd HH:mm:ss");
}

function getNextDayMorning() {
	var date = new Date();
	date.setTime(date.getTime()+1 * 24 * 60 * 60 * 1000);
	return date.pattern("yyyy-MM-dd 00:00:00");
}
// 开始时间大于当前时间，截止时间大于开始时间
function checkDate(startDate, endDate) {
	var date = getNowDayMorning();
	if (startDate < date) {
		$.messager.show({
			title : '提示',
			msg : "请输入合理的时间"
		});
		return false;
	}
	if (endDate < startDate) {
		$.messager.show({
			title : '提示',
			msg : "请输入合理的时间"
		});
		return false;
	}
	return true;
}
function getEndOfDay(){
	var date = new Date();
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM-dd 23:59:59");
}

function getMonthFirstDay() {
	var date = new Date();
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM") + "-01";
}

/**
 * 获取当前时间前十分钟时间 
 * @returns {String}
 */
function getStartDate(){
	var curr_time = new Date();
	curr_time.setTime(curr_time.getTime() - 10 * 60 * 1000);
	return curr_time.pattern("yyyy-MM-dd HH:mm:ss");
}

/**
 * 获取当前时间
 * @param nDate
 * @returns
 */
function getEndDate(nDate){
	var date = new Date(Date.parse(nDate.replace(/-/g, "/")));
	if (date.getTime() > 0) {
		date.setTime(date.getTime() + 10 * 60 * 1000);
		var strDate = date.pattern("yyyy-MM-dd HH:mm:ss");
	    return strDate;
	} else {
		return "";
	}
}

/**
 * 毫秒数转换为时间格式
 * @param time
 * @returns {String}
 */
function formatDateToStr(time){
	var d=new Date(time);
	var year=d.getFullYear();
	var day=d.getDate();
	var month=+d.getMonth()+1;
	var hour=d.getHours();
	var minute=d.getMinutes();
	var second=d.getSeconds();
	//var misec=d.getMilliseconds();
	return year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
}

Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function isEmpty(str){
	if(str == null || str == '' || str == undefined || str == 'null'){
		return true;
	}
	return false;
}

function toDecimal(x) {
    var f = parseFloat(x);
    if (isNaN(f)) {
        return 0;
    }
    f = Math.round(x*100)/100/100;
    return f;
}

function getMonthFirstDatetime() {
    var date = new Date();
    date.setTime(date.getTime());
    return date.pattern("yyyy-MM") + "-01 00:00:00";
}