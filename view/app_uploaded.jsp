<%@ page import = "evadroid.model.User" pageEncoding="UTF-8"%>
<%@ page import = "evadroid.model.UserProfile"%>
<%@ page import = "evadroid.model.App"%>
<%@ page import = "evadroid.model.AppProfile"%>
<%@ page import = "java.sql.Date"%>

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
	AppProfile appProfile = (AppProfile)session.getAttribute("appProfile");

	if (appProfile == null) {
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"上传出错，请重新上传！\")");	
		out.println("location.href = 'upload.jsp';");
		out.println("</script>");
		return;
	}
	String name = request.getParameter("name");
	String description = request.getParameter("description");
	String task = request.getParameter("task");
	String point = request.getParameter("point");
	int intPoint = Integer.parseInt(point);
	if (name == null || description == null || task == null || point == null) {
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"请将所有App信息填写完整！\")");	
		out.println("location.href = 'upload.jsp';");
		out.println("</script>");
		return;
	}
	appProfile.setDate(new Date());
	appProfile.setName(name);
	appProfile.setDescription(description);
	appProfile.setTask(task);
	appProfile.setPoint(point);

	App.insertApp(appProfile);
	out.println("finish");
%>