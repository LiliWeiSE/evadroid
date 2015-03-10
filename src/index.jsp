<%@ page import="evadroid.model.User" pageEncoding="UTF-8"%>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");

	User user = null;
	String newLocn = null;

	if (username != null && password != null) {
		try {
			user = User.login(username, password);
		}
		catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
			String newLocn="../index.jsp";
			response.setHeader("Location",newLocn);
		}
	}
	else {
		out.println("null");
	}
	if (user == null) {
		out.println("user == null");
		response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		String newLocn="../index.jsp";
		response.setHeader("Location",newLocn);*/
	}
	else {
		session.setAttribute("user",user);
		String name = user.getUserProfile().getName();
		response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);

		if(user.getUserProfile().getType() == 0)
			newLocn="../myEvaTester.jsp";
		else
			newLocn = "../myEvaDeveloper.jsp";

		response.setHeader("Location",newLocn);
	}
%>