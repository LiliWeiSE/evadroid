<%@ page import="evadroid.model.User" pageEncoding="UTF-8"%>
<%@ page import="evadroid.controller.RegisterValidate"%>
<%
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String passwordcfm = request.getParameter("passwordcfm");
	String stype = request.getParameter("mytype");
	int type = 0;
	if(stype != null && stype.equals("developer"))
		type = 1;
	
	boolean usernameValidate=false;
	boolean passwordValidate=false;
	boolean passwordMatch=false;
	
	User user = null;
	String newLocn = null;
	if(username != null && password != null && passwordcfm != null){
		usernameValidate = RegisterValidate.validateUsername(username);
		passwordValidate = RegisterValidate.validatePassword(password);
		passwordMatch = RegisterValidate.validatePasswordMatch(password, passwordcfm);
		if(usernameValidate && passwordValidate && passwordMatch) {
			try {
				user = User.register(type, email, username, password);
			}
			catch(Exception e) {
				//register failed
				response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
				newLocn="../index.jsp";
				response.setHeader("Location",newLocn);
			}
		}
	}
	else {
		//validation failed
		response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		newLocn="../index.jsp";
		response.setHeader("Location",newLocn);
	}
	if(user == null) {
		//register failed
		response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		newLocn="../index.jsp";
		response.setHeader("Location",newLocn);
	}
	else {
		//register succeeded
		session.setAttribute("user",user);
		response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		
		if(type == 0)
			newLocn="../myEvaTester.jsp";
		else
			newLocn = "../myEvaDeveloper.jsp";			
		response.setHeader("Location",newLocn);
	}
%>