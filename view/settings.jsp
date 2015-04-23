<%@ page import = "evadroid.model.User" pageEncoding="UTF-8"%>
<%@ page import = "evadroid.model.UserProfile"%>
<%@ page import = "evadroid.model.App"%>
<%@ page import = "evadroid.model.AppProfile"
	import = "java.util.ArrayList"
	import = "java.text.DateFormat"
	import = "java.text.SimpleDateFormat"
	import = "java.sql.Date"%>

<%
	User user = null;
	UserProfile profile = null;
	try {
		user = (User)session.getAttribute("user");
		profile = user.getUserProfile();
	}
	catch(Exception e) {
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"请重新登录！\")");	
		out.println("location.href = 'index.jsp';");
		out.println("</script>");
		return;
	}
	String index = null;
	if(profile.getType() == 0)
		index = "\"myEvaTester.jsp\"";
	else
		index = "\"myEvaDeveloper.jsp\"";
%>

<html>
	<head>
		<title>Evadroid | 文档</title>
		<link rel="stylesheet" type="text/css" href="css/settings.css">
		<link rel="stylesheet" type="text/css" href="css/general.css">
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	</head>
	<body>
		<div id="navi">
			<ul>
				<li><a href=<%= index%>>首页</a></li>
				<li><a href="explore.jsp">发现</a></li>
				<li><a href="settings.jsp">修改密码</a></li>
				<%if(profile.getType() == 1) {%>
				<li><a href="toolkit.jsp">安卓工具包下载</a></li>
				<li><a href="documentation.jsp">文档</a></li>
				<%}%>
				<li><%= profile.getName()%><%if(profile.getType() == 0)
												out.print("， " + profile.getCredit() + "分"); %></li>
				<li><a href="process/logout.jsp">退出</a></li>
			</ul>
		</div>
		<div id="center">
			<form method="post" action="process/changePWD.jsp">
				<label>旧密码<br><input type="password" name="old_pwd" class="textfield"></label><br>
				<label>新密码<br><input type="password" name="pwd" class="textfield"></label><br>
				<label>密码确认<br><input type="password" name="pwd_cfm" class="textfield"></label><br>
				<input type="submit" value="完成">
			</form>
		</div>
	</body>
</html>