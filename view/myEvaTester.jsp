<%@ page import = "evadroid.model.*" pageEncoding="UTF-8"
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
	ArrayList<App> appList = App.getCertainApps(5);
	AppProfile myAP = null;
	TestRecordDetail record = null;
	ArrayList<TestRecord> myRList = TestRecord.getByTid(profile.getId());
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
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
				<li><a href="myEvaTester.jsp">首页</a></li>
				<li><a href="explore.jsp">发现</a></li>
				<li><a href="settings.jsp">修改密码</a></li>
				<li><%= profile.getName()%>，<%= profile.getCredit()%>分</li>
				<li><a href="process/logout.jsp">退出</a></li>
			</ul>
		</div>
		<div class="container">
			<div id="left">
				<h3>我评分的App</h3>
				<ul>
					<%
						for (int i = myRList.size() - 1; i >= 0; i--) {
							record = myRList.get(i).getTestRecordDetail();
							myAP = App.getAppById(record.getAid()).getAppProfile();
							%>
							<li>
							<a href=<%= "\"testRecord.jsp?id=" + record.getId() + "\""%>><%= myAP.getName()%></a>
							<span class="time"><%= df.format(record.getTime())%></span><br/>
							<span class="score">评分: <%= record.getScore() == -1?"尚未评分":record.getScore()%></span>
							</li>
					<%
						}
					%>

				</ul>
				<h3>最新的App</h3>
				<ul id="allApps">
					<%
					AppProfile appProfile = null;
					for (int i = 0; i < appList.size(); i++) {
						appProfile = appList.get(i).getAppProfile();
						out.println("<li>");
						out.print("<a href=\"app.jsp?id=" + appProfile.getId() + "\">");
						out.print(appProfile.getName());
						out.print("</a>");
						out.print("<span class=\"time\">");
						out.print(df.format(appProfile.getTime()));
						out.println("</span><br/>");
						out.println("</li>");
					}
					%>
				</ul>
			</div>
			<div id="right">
				<h4>我的用户id:<%= profile.getId()%></h4>
				请在使用App时正确输入此id。
			</div>
		</div>
	</body>
</html>