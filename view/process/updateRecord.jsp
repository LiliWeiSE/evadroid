<%@ page import = "evadroid.model.*" pageEncoding="UTF-8"%>
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
	String idstr = request.getParameter("id");
	String scorestr = request.getParameter("score");
	int id = Integer.parseInt(idstr);
	int score = Integer.parseInt(scorestr);
	TestRecord record = TestRecord.getById(id);
	record.getTestRecordDetail().setScore(score);
	if(record.update()) {
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"评分修改成功！\")");	
		out.println("location.href = '../myEvaTester.jsp';");
		out.println("</script>");
		return;
	}
	else {
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"修改失败，请重试！\")");	
		out.println("location.href = '../myEvaTester.jsp';");
		out.println("</script>");
		return;
	}
%>