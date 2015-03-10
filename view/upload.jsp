<%@ page import = "evadroid.model.User" pageEncoding="UTF-8"%>
<%@ page import = "evadroid.model.UserProfile"%>
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
	AppProfile appProfile = null;
	if (session.getAttribute("appProfile") == null) {
		appProfile = new AppProfile();
		appProfile.setUid(profile.getId());
		session.setAttribute("appProfile", appProfile);
	}
	else {
		appProfile = (AppProfile)session.getAttribute("appProfile");
	}
	%>
<html>
	<head>
		<title>上传App</title>
		<link rel="stylesheet" type="text/css" href="css/general.css">
		<link rel="stylesheet" type="text/css" href="css/upload.css">
		<link rel="stylesheet" type="text/css" href="css/uploadify.css">
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<script type="text/javascript" src="js/jquery-1.10.2.js"></script>
		<script type="text/javascript" src="js/jquery.uploadify.min.js"></script>
	</head>
	<body>
		<div id="navi">
			<ul>
				<li><a href="index.jsp">首页</a></li>
				<li><a href="explore.jsp">发现</a></li>
				<li><a href="settings.jsp">设置</a></li>
				<li><%= profile.getName()%></li>
				<li><a href="">退出</a></li>
			</ul>
		</div>
		<div class="container">
			<h3>上传apk文件</h3>
			<form action="apk_uploadify.jsp" method="post" enctype="multipart/form-data">
				<div id="queue"></div>
				<input id="apk_upload" name="apk_upload" type="file">
			</form>
			<% if(appProfile.getUrl() != null) {
				out.println("<p>apk文件已上传</p>");
			} %>

			<h3>上传app图标</h3>
			<form action="icon_uploadify.jsp" method="post" enctype="multipart/form-data">
				<div id="queue"></div>
				<input id="icon_upload" name="icon_upload" type="file">
			</form>
			
			<% if(appProfile.getIcon() != null) {
				out.println("<p>app图标已上传</p>");
			} %>
			<form method="post" action="app_uploaded.jsp">
				<h3>App名称</h3><br/>
				<input type="text" name="name">

				<h3>App描述</h3><br/>
				<textarea name="description"></textarea>
				
				<h3>App任务</h3><br/>
				<textarea name="task"></textarea>

				<h3>App点数</h3><br/>
				<select name="point">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				</select>
				<br/>
				<input type="submit" name="完成" value="完成">
			</form>
		</div>

		<script type="text/javascript">
		$(function() {
			$('#apk_upload').uploadify({
				'swf'      : 'uploadify.swf',
				'uploader' : 'apk_uploadify.jsp',
				'auto'	   : 'true',
				'fileTypeDesc' : 'apk文件',
				'fileTypeExts'  : '*.apk',
			});
		});

		$(function() {
			$('#icon_upload').uploadify({
				'swf'      : 'uploadify.swf',
				'uploader' : 'icon_uploadify.jsp',
				'auto'	   : 'true',
				'fileTypeDesc' : 'jpg或png文件',
				'fileTypeExts'  : '*.jpg; *.jpeg; *.png',
			});
		});
	</script>
	</body>
</html>