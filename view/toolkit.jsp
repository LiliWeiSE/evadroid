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
%>

<html>
	<head>
		<title>Evadroid | 文档</title>
		<link rel="stylesheet" type="text/css" href="css/toolkit.css">
		<link rel="stylesheet" type="text/css" href="css/general.css">
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	</head>
	<body>
		<div id="navi">
			<ul>
				<li><a href="myEvaDeveloper.jsp">首页</a></li>
				<li><a href="explore.jsp">发现</a></li>
				<li><a href="settings.jsp">修改密码</a></li>
				<li><a href="toolkit.jsp">安卓工具包下载</a></li>
				<li><a href="documentation.jsp">文档</a></li>
				<li><%= profile.getName()%></li>
				<li><a href="process/logout.jsp">退出</a></li>
			</ul>
		</div>
		<div class="container">
			<h3>下载安卓工具包</h3>
			<p>想要利用EvaDroid对你的App进行便捷的可用性评估测试？选择下面的链接下载并在<a href="documentation.jsp">文档</a>中查看更多信息</p>
			<h3>EvaToolkit</h3>
			<h4>EvaToolkit Version 1.0.0</h4>
			<p>使用时App需联网，使用HttpClient进行数据传输</p>
			<a href="" class="download_button">下载</a>
		</div>
	</body>
</html>