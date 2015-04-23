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
	TestRecord tr = TestRecord.getById(id);
	if(tr == null)
	{
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"选择的app有误！\")");	
		out.println("location.href = 'myEvaTester.jsp';");
		out.println("</script>");
		return;
	}
	TestRecordDetail record = tr.getTestRecordDetail();
	AppProfile myAP = App.getAppById(record.getAid()).getAppProfile();
	
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
%>
<html>
	<head>
		<title>EvaDroid | 我的App <%= myAP.getName()%></title>
		<link rel="stylesheet" type="text/css" href="css/record.css">
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
			<h3>我的App: <%= myAP.getName()%></h3>
			<div id="left">
				<img src=<%= "\"" + myAP.getIcon() + "\""%>>
				<h5>添加时间: <%= df.format(record.getTime())%></h5>
				<h5>我的评分: <%= record.getScore() == -1?"尚未评分":record.getScore()%></h5>
				<h5>App更新时间: <%= df.format(myAP.getTime())%></h5>
				<a class="download_button" href=<%= "\"" + myAP.getUrl() + "\""%>>下载apk</a>
			</div>
			<div id="right">
				<h4>任务价值: <%= myAP.getPoint()%></h4>
			
				<h4>App简介</h4>
				<%= myAP.getDescription()%>

				<h4>任务描述</h4>
				<%= myAP.getTask()%><br />
				<form method="post" action="process/updateRecord.jsp">
					<h4>修改评分</h4>
					<input type="hidden" name="id" value=<%="\"" + record.getId() + "\""%>>
					<select name="score">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					</select>
					<br>
					<input type="submit" value = "提交">
				</form>
			</div>
			
		</div>
	</body>
</html>