<%
	session.invalidate();
	response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
	String newLocn="../index.jsp";
	response.setHeader("Location",newLocn);
%>