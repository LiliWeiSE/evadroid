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
		out.println(usernameValidate);
		out.println(passwordValidate);
		out.println(passwordMatch);
		if(usernameValidate && passwordValidate && passwordMatch) {
			try {
				user = User.register(type, email, username, password);
			}
			catch(Exception e) {
				//register failed
				out.println("<script type=\"text/javascript\">");
				out.println("alert(\"数据库出错，请稍后重试\")");	
				out.println("location.href = '/index.jsp';");
				out.println("</script>");

				//response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
				//newLocn="../index.jsp";
				//response.setHeader("Location",newLocn);
			}
		}
		else {
			out.println("<script type=\"text/javascript\">");
			out.println("alert(\"用户信息出错，请检查:\\n1.用户名为4到32位英文字母、数字下划线组成\\n2.密码至少6位并两次输入一致\")");	
			out.println("location.href = '/index.jsp';");
			out.println("</script>");
			return;
		}
	}
	else {
		//validation failed
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"用户信息出错，请检查:\n1.用户名为4到32位英文字母、数字下划线组成\n2.密码至少6位并两次输入一致\")");	
		out.println("location.href = '/index.jsp';");
		out.println("</script>");
		return;
		//response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		//newLocn="../index.jsp";
		//response.setHeader("Location",newLocn);
	}
	if(user == null) {
		//register failed
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"数据库出错，请稍后重试\")");	
		out.println("location.href = '/index.jsp';");
		out.println("</script>");
		//response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
		//newLocn="../index.jsp";
		//response.setHeader("Location",newLocn);
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