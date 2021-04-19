$package('sys.login');
sys.login = function(){
	return {
		toLogin:function(){
			try{
				var form = $("#loginForm");
				if(form.form('validate')){
					sys.progress('Please waiting','Loading...');
					sys.submitForm(form,function(data){
						sys.closeProgress();
						if(data.success){
					 		window.location= "main.action";
				        }else{
				       	   sys.alert('提示',data.msg,'error');  
				        }
				        sys.login.loadVrifyCode();//刷新验证码
					});
				}
			}catch(e){
				
			}
			return false;
		},
		loadVrifyCode:function(){//刷新验证码
			var _url = "ImageServlet?time="+new Date().getTime();
			$(".vc-pic").attr('src',_url);
		},
		init:function(){
			if(window.top != window.self){
				window.top.location =  window.self.location;
			}
			//验证码图片绑定点击事件
			$(".vc-pic").click(sys.login.loadVrifyCode);
			
			var form = $("#loginForm");
			form.submit(sys.login.toLogin);
		}
	}
}();

$(function(){
	sys.login.init();
});		