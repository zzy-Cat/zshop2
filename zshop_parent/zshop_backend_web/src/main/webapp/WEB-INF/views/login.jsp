<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title>在线商城-后台管理系统</title>
	<meta charset="utf-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script>
		//重新加载验证码
		function reloadImage() {
			$('#randCode').attr('src','${pageContext.request.contextPath}/backend/code/image?time='+new Date().getTime());
			$('#code').val('');
		}
		function loginSubmit() {
			var loginName=document.logings.loginName.value;
			var password=document.logings.password.value;
			var code=document.logings.code.value;
			if (loginName=="") {
				alert("用户名不能为空");
				document.logings.loginName.focus();
				return;
			}
			else if (password==""){
				alert("密码不能为空");
				document.logings.password.focus();
				return;
			}
			else if (code==""){
				alert("验证码不能为空");
				document.logings.code.focus();
				return;
			}
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/backend/code/checkCode',
				data:{'code':$('#code').val()},
				dataType:'json',
				success:function (result) {
					if (result==false) {
						alert("验证码输入错误，请重新输入");
						document.logings.code.focus();
						return;
					}
					else {
						$.post(
								'${pageContext.request.contextPath}/backend/sysuser/testlogin',
								{'loginName':loginName,'password':password},
								function (result) {
									if (result.status==1) {
										location.href='${pageContext.request.contextPath}/backend/sysuser/login';
									}
									else
										alert(result.message);
								}
						);
					}
				}
			});

		}
		//显示注册模态框
		function showadduser() {
			$('#myMangerUser').modal('show');
		}
		function adduser() {
			var loginName=document.adds.loginName.value;
			var password=document.adds.password.value;
			if (loginName=="") {
				alert("账号不能为空");
				document.adds.loginName.focus();
				return;
			}
			else if (password==""){
				alert("密码不能为空");
				document.adds.password.focus();
				return;
			}
			else
			$.post(
					'${pageContext.request.contextPath}/backend/sysuser/add',
					$('#frmAddSysuser').serialize(),
					function (result) {
						if(result.status==1){
							alert(result.message);
						}
					}
			);
		}
	</script>
</head>
<body>
<!-- 使用自定义css样式 div-signin 完成元素居中-->
<div class="container div-signin">
	<div class="panel panel-primary div-shadow">
		<!-- h3标签加载自定义样式，完成文字居中和上下间距调整 -->
		<div class="panel-heading">
			<h3>在线商城系统</h3>
			<span>ZSHOP Manager System</span>
		</div>
		<div class="panel-body">
			<!-- login form start -->
			<form name="logings" id="frmLogin" class="form-horizontal" method="post">
				<div class="form-group">
					<label class="col-sm-3 control-label">用户名：</label>
					<div class="col-sm-9">
						<input class="form-control" name="loginName" type="text" placeholder="请输入用户名">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
					<div class="col-sm-9">
						<input class="form-control" name="password" type="password" placeholder="请输入密码">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">验证码：</label>
					<div class="col-sm-4">
						<input class="form-control" type="text" id="code" name="code" placeholder="验证码">
					</div>
					<div class="col-sm-2">
						<!-- 验证码 -->
						<img class="img-rounded" src="${pageContext.request.contextPath}/backend/code/image" id="randCode" style="height: 32px; width: 70px;"/>
					</div>
					<div class="col-sm-2">
						<button type="button" onclick="reloadImage()" class="btn btn-link">看不清</button>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-3">
					</div>
					<div class="col-sm-9 padding-left-0">
						<div class="col-sm-4">
							<button type="button" class="btn btn-link btn-block" onclick="showadduser()">注册</button>
						</div>
						<div class="col-sm-4">
							<button type="button" onclick="loginSubmit()" class="btn btn-primary btn-block">登&nbsp;&nbsp;陆</button>
						</div>
						<div class="col-sm-4">
							<button type="reset" class="btn btn-primary btn-block">重&nbsp;&nbsp;置</button>
						</div>
						<div class="col-sm-4">
							<button type="button" class="btn btn-link btn-block">忘记密码？</button>
						</div>
					</div>
				</div>
			</form>
			<!-- login form end -->
		</div>
	</div>
</div>
<!-- 添加系统用户 start -->
<div class="modal fade" tabindex="-1" id="myMangerUser">
	<!-- 窗口声明 -->
	<div class="modal-dialog">
		<!-- 内容声明 -->
		<form id="frmAddSysuser" name="adds">
			<div class="modal-content">
				<!-- 头部、主体、脚注 -->
				<div class="modal-header">
					<button class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">注册系统用户</h4>
				</div>
				<div class="modal-body text-center">
					<div class="row text-right">
						<label for="marger-username" class="col-sm-4 control-label">用户姓名：</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="marger-username" name="name">
						</div>
					</div>
					<br>
					<div class="row text-right">
						<label for="marger-loginName" class="col-sm-4 control-label">登录帐号：</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="marger-loginName" name="loginName">
						</div>
					</div>
					<br>
					<div class="row text-right">
						<label for="marger-password" class="col-sm-4 control-label">登录密码：</label>
						<div class="col-sm-4">
							<input type="password" class="form-control" id="marger-password" name="password">
						</div>
					</div>
					<br>
					<div class="row text-right">
						<label for="marger-phone" class="col-sm-4 control-label">联系电话：</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="marger-phone" name="phone">
						</div>
					</div>
					<br>
					<div class="row text-right">
						<label for="marger-adrees" class="col-sm-4 control-label">联系邮箱：</label>
						<div class="col-sm-4">
							<input type="email" class="form-control" id="marger-email" name="email">
						</div>
					</div>
					<br>
					<div class="row text-right">
						<label for="role" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
						<div class=" col-sm-4">
							<select class="form-control" name="roleId">
								<option>--请选择--</option>
								<option value="1">商品专员</option>
							</select>
						</div>
					</div>
					<br>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary add-Manger" onclick="adduser()" type="button">添加</button>
					<button class="btn btn-primary cancel" data-dismiss="modal" >取消</button>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- 添加系统用户 end -->
<!-- 页尾 版权声明 -->
<div class="container">
	<div class="col-sm-12 foot-css">
		<p class="text-muted credit">
			Copyright Web2019_Group5
		</p>
	</div>
</div>

</body>
</html>
