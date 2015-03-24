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
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	String index = null;
	if(profile.getType() == 0)
		index = "\"myEvaTester.jsp\"";
	else
		index = "\"myEvaDeveloper.jsp\"";
%>

<html>
	<head>
		<title>EvaDroid|我的主页</title>
		<link rel="stylesheet" type="text/css" href="css/explore.css">
		<link rel="stylesheet" type="text/css" href="css/general.css">
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	</head>
	<body>
		<div id="navi">
			<ul>
				<li><a href=<%= index%>>首页</a></li>
				<li><a href="explore.jsp">发现</a></li>
				<li><a href="settings.jsp">设置</a></li>
				<%if(profile.getType() == 1) {%>
				<li><a href="toolkit.jsp">安卓工具包下载</a></li>
				<li><a href="documentation.jsp">文档</a></li>
				<%}%>
				<li><%= profile.getName()%><%if(profile.getType() == 0)
												out.print("， " + profile.getCredit() + "分"); %></li>
				<li><a href="process/logout.jsp">退出</a></li>
			</ul>
		</div>
		<div id="myrecord" class="container">
			<h3>最新的App</h3>
			<ul id="allApps">
				<%
				AppProfile appProfile = null;
				String description = null;
				for (int i = 0; i < appList.size(); i++) {
					appProfile = appList.get(i).getAppProfile();
					description = appProfile.getDescription();
					if (description.length()>50) {
						description = description.substring(0, 50);
					}
					%>
					<li>
					<a href=<%="\"app.jsp?id=" + appProfile.getId() + "\""%>>
					<%= appProfile.getName()%>
					</a>
					<span class="time"><%=df.format(appProfile.getTime())%></span>
					<span class="description"><%= description%></span>
					</li>
				<%
				}
				%>
			</ul>
			<h3>热门App</h3>

		</div>
	</body>
</html>