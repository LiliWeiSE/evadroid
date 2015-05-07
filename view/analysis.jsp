<%@ page import = "evadroid.model.*" pageEncoding="UTF-8"%>
<%@ page
	import = "java.util.ArrayList"
	import = "evadroid.utils.*"
	import = "evadroid.graph.*"
	import = "evadroid.controller.*"
	import = "java.util.ArrayList"
	import = "java.util.Iterator" %>

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

	String aidstr = request.getParameter("aid");
	int aid = Integer.parseInt(aidstr);
	App app = App.getAppById(aid);
	AppProfile appProfile = app.getAppProfile();
	boolean exist = appProfile.getResult() != null && !appProfile.getResult().equals("");
	boolean exist_xml = appProfile.getXml() != null && !appProfile.getXml().equals("");
	ArrayList<ActivityNode> activityList = null, activityList_xml = null;
	Iterator<ActivityInfo> it_a = null;
	Iterator<EventInfo> it_e = null;
	MyXMLParser parser = null;

	if (exist && exist_xml) {
		activityList = (ArrayList<ActivityNode>)ObjectIOUtil.read(appProfile.getResult());
		try{
			parser = new MyXMLParser(request.getServletContext().getRealPath("/") + appProfile.getXml());
			activityList_xml = parser.readSingleFile();
		}
		catch(Exception e) {
			out.println("<script type=\"text/javascript\">");
			out.println("alert(\"缺少实际使用信息或标准使用信息，暂不能提供分析结果！\")");	
			out.println("window.history.back()");
			out.println("</script>");
			return;
		}
		AnalysisUtil analysis = new AnalysisUtil(activityList_xml, activityList);
		ArrayList<ActivityInfo> activityInfoList = analysis.getRedundantActivity();
		ArrayList<EventInfo> eventInfoList = analysis.getRedundantEvent();
		it_a = activityInfoList.iterator();
		it_e = eventInfoList.iterator();
	}
	else {
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"缺少实际使用信息或标准使用信息，暂不能提供分析结果！\")");	
		out.println("window.history.back()");
		out.println("</script>");
		return;
	}
%>
<html>
	<head>
		<title>Evadroid | <%=appProfile.getName()%>测试结果</title>
		<link rel="stylesheet" type="text/css" href="css/general.css">
		<link rel="stylesheet" type="text/css" href="css/analysis.css">
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
			<h3>误入最多的Activity</h3>
			<ul>
			<%
			int i = 1;
			while (it_a.hasNext()) {
				ActivityInfo info = it_a.next();%>
				<li>
					<h4>Activity <%= i%></h4>
					Activity名称: <%= info.getName()%><br />
					Activity出现次数: <%= info.getCount()%>
				</li>
			<%
			i++;}
			%>
			</ul>

			<h3>误触发最多的Event</h3>
			<ul>
			<%
			i = 1;
			while (it_e.hasNext()) {
				EventInfo info = it_e.next();%>
				<li>
					<h4>Event <%= i%></h4>
					Event名称: <%= info.getName()%><br />
					Event类型: <%= info.getType()%><br />
					触发时Activity: <%= info.getSrc()%><br />
					触发后Activity: <%= info.getDes()%><br />
					Event触发次数: <%= info.getCount()%>
				</li>
			<%
			i++;}
			%>
			</ul>
		</div>
	</body>
</html>