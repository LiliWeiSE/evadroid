<%@ page import = "evadroid.model.User" pageEncoding="UTF-8"%>
<%@ page import = "evadroid.model.UserProfile"%>
<%@ page import = "evadroid.model.TestRecord"%>
<%@ page import = "evadroid.model.TestRecordDetail"%>

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
		out.println("location.href = '../index.jsp';");
		out.println("</script>");
		return;
	}
	String tidStr = request.getParameter("tid");
	String aidStr = request.getParameter("aid");
	int tid = Integer.parseInt(tidStr);
	int aid = Integer.parseInt(aidStr);
	TestRecord.insert(tid, aid);
	out.println("<script type=\"text/javascript\">");
		out.println("alert(\"此App已成功添加至我的App！\")");	
		out.println("location.href = '../myEvaTester.jsp';");
		out.println("</script>");
		return;
%>