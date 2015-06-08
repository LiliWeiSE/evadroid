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
			<h3>App评分</h3>
			<p>评分次数: <%= TestRecord.getCount(aid)%></p>
			<p>平均分: <%= TestRecord.getAverage(aid)%></p>
			<h3>Activity 分析结果</h3>
			<table>
				<tr>
					<td>Activity 名称</td>
					<td>冗余次数</td>
					<td>Activity 内误触发事件概率</td>
				</tr>
			<%
			while (it_a.hasNext()) {
				ActivityInfo info = it_a.next();%>
				<tr>
					<td><%= info.getName()%></td>
					<td><%= info.getCount()%></td>
					<td><%= info.getMistakeRate()%></td>
				</tr>
			<%}
			%>
			</table>

			<h3>Event 分析结果</h3>
			<table>
				<tr>
					<td>Event 名称</td>
					<td>Event 类型</td>
					<td>触发时 Activity</td>
					<td>触发后 Activity</td>
					<td>触发次数</td>
				</tr>
			<%
			while (it_e.hasNext()) {
				EventInfo info = it_e.next();%>
				<tr>
					<td><%= info.getName()%></td>
					<td><%= info.getType()%></td>
					<td><%= info.getSrc()%></td>
					<td><%= info.getDes()%></td>
					<td><%= info.getCount()%></td>
				</tr>
			<%}%>
			</table>
		</div>
	</body>
</html>