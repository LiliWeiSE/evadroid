<%@ page import = "evadroid.model.User" pageEncoding="UTF-8"%>
<%@ page import = "evadroid.model.UserProfile"%>

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
				<li><a href="settings.jsp">修改密码</a></li>
				<li><a href="toolkit.jsp">安卓工具包下载</a></li>
				<li><a href="documentation.jsp">文档</a></li>
				<li><%= profile.getName()%></li>
				<li><a href="process/logout.jsp">退出</a></li>
			</ul>
		</div>
		<div class="container">
			<div id="left">
				<h4>上传apk文件</h4>
				<form action="apk_uploadify.jsp" method="post" enctype="multipart/form-data">
					<div id="queue"></div>
					<input id="apk_upload" name="apk_upload" type="file">
					<!--input type="submit"-->
				</form>

				<h4>上传app图标</h4>
				<form action="icon_uploadify.jsp" method="post" enctype="multipart/form-data">
					<div id="queue"></div>
					<input id="icon_upload" name="icon_upload" type="file">
					<!--input type="submit"-->
				</form>
			</div>
			<div id="right">
				<form method="post" action="app_uploaded.jsp">
					<input type="hidden" name="url" id="url">
					<input type="hidden" name="icon" id="icon">
					<h4>App名称</h4>
					<input class="textfield" type="text" name="name">

					<h4>App描述</h4>
					<textarea name="description"></textarea>
					
					<h4>App任务</h4>
					<textarea name="task"></textarea>

					<h4>App点数</h4>
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
		</div>

		<script type="text/javascript">
		$(function() {
			$('#apk_upload').uploadify({
				'successTimeout' : 100,
				'swf'      : 'uploadify.swf',
				'uploader' : 'apk_uploadify.jsp',
				'auto'	   : 'true',
				'fileTypeDesc' : 'apk文件',
				'fileTypeExts'  : '*.apk',
				'method'   : 'post',
				'onUploadSuccess' : function(file, data, response) {
				            if (response) {
				            	var newData=data.replace(/\r\n/g,'');
				            	$('#url').val(newData);
				            };
				        }
			});
		});

		$(function() {
			$('#icon_upload').uploadify({
				'swf'      : 'uploadify.swf',
				'uploader' : 'icon_uploadify.jsp',
				'auto'	   : 'true',
				'fileTypeDesc' : 'jpg或png文件',
				'fileTypeExts'  : '*.jpg; *.jpeg; *.png',
				'method'   : 'post',
				'onUploadSuccess' : function(file, data, response) {
				            if (response) {
				            	var newData=data.replace(/\r\n/g,'');
				            	$('#icon').val(newData);
				            };
				        }
			});
		});
	</script>
	</body>
</html>