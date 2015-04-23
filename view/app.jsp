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
	String idstr = request.getParameter("id");
	int id = Integer.parseInt(idstr);
	App app = App.getAppById(id);
	AppProfile appProfile = app.getAppProfile();
	int tid = profile.getId();
	TestRecord tr = TestRecord.getByTidAndAid(tid, id);
	if (tr != null) {
		response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		String newLocn="testRecord.jsp?id=" + tr.getTestRecordDetail().getId();
		response.setHeader("Location",newLocn);
	}
	String index = null;
	if(profile.getType() == 0)
		index = "\"myEvaTester.jsp\"";
	else
		index = "\"myEvaDeveloper.jsp\"";
%>
<html>
	<head>
		<title>EvaDroid|<%= appProfile.getName()%></title>
		<link rel="stylesheet" type="text/css" href="css/record.css">
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
		<div class="container">
			<h3><%= appProfile.getName()%></h3>
			<div id="left">
				<img src=<%="\"" + appProfile.getIcon() + "\""%>>
				<a class="download_button" href=<%= "\"" + appProfile.getUrl() + "\""%>>下载apk</a>
			<form method="post" action="process/addToMy.jsp">
				<input type="hidden" name="tid" value=<%="\"" + profile.getId() + "\""%>>
				<input type="hidden" name="aid" value=<%="\"" + appProfile.getId() + "\""%>>
				<%if (profile.getType() == 0) {%>
				<input class="download_button" type="submit" value="添加到我的App">
				<%}%>
			</form>
			</div>

			<div id="right">
				<h4>App简介</h4>
				<%=appProfile.getDescription()%>
				<h4>任务描述</h4>
				<%= appProfile.getTask()%><br />

				<h4>任务价值: <%= appProfile.getPoint()%></h4>
			</div>
			
		</div>
	</body>
</html>