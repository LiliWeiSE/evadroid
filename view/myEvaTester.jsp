<%@ page import = "evadroid.model.User" pageEncoding="UTF-8"%>
<%@ page import = "evadroid.model.UserProfile"%>
<%@ page import = "evadroid.model.App"%>
<%@ page import = "evadroid.model.AppProfile"%>

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
%>

<html>
	<head>
		<title>EvaDroid|我的主页</title>
		<link rel="stylesheet" type="text/css" href="css/tester.css">
		<link rel="stylesheet" type="text/css" href="css/general.css">
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	</head>
	<body>
		<div id="navi">
			<ul>
				<li><a href="">首页</a></li>
				<li><a href="explore.jsp">发现</a></li>
				<li><a href="">设置</a></li>
				<li><%= profile.getName()%>，<%= profile.getCredit()%>分</li>
				<li><a href="">退出</a></li>
			</ul>
		</div>
		<div id="myrecord" class="container">
			<ul>
				<li>
					<a href="">我的app</a><span class="time">2014-10-10</span><br/>
					<span class="score">评分:3</span>
				</li>
				<li>
					<a href="">我的app</a><span class="time">2014-10-10</span><br/>
					<span class="score">评分:3</span>
				</li>
			</ul>
		</div>
	</body>
</html>