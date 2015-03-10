<%@ page pageEncoding="UTF-8"%>
<%
	String result = request.getParameter("result");
	boolean login=true;
	if(result != null)
		login = false;
%>
<html>
<head>
	<title>EvaDroid</title>
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<link rel="stylesheet" type="text/css" href="css/general.css">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<script type="text/javascript" src="js/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="js/index.js"></script>
</head>
<body>
	<div class="container">
		<div id="left">EvaDroid</div>
		<div id="signin" action="/signin/index.jsp">
			<span>登录</span>
			<a href="#signup" id="tosignup">注册</a>
			<form method="post">
				<!--label>用户名</label><br/-->
				<input class="textfield" type="text" name="username" placeholder="用户名"><br/>
				<!--label>密码</label><br/-->
				<input class="textfield" type="password" name="password" placeholder="密码"><br/>
				<input class="button" type="submit" value="完成">
			</form>
		</div>
		<div id="signup">
			<span>注册</span>
			<a href="#signup" id="tosignin">登录</a>
			<form method="post" action="/signup/index.jsp">
				<!--label>用户名</label><br/-->
				<input class="textfield" type="text" name="username" placeholder="用户名"><br/>
				<!--label>邮箱</label><br/-->
				<input class="textfield" type="text" name="email" placeholder="邮箱"><br/>
				<!--label>密码</label><br/-->
				<input class="textfield" type="password" name="password" placeholder="密码"><br/>
				<!--label>确认密码</label><br/-->
				<input class="textfield" type="password" name="passwordcfm" placeholder="确认密码"><br/>
				<!--label>类型</label><br/-->
				<input class="radio" type="radio" name="mytype" value="tester">普通用户
				<input class="radio" type="radio" name="mytype" value="developer">开发用户<br/>
				<input class="button" type="submit" value="完成">
			</form>
		</div>
	</div>
</body>
</html>