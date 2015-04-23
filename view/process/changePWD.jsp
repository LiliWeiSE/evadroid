<%@ page import="evadroid.model.*" pageEncoding="UTF-8"
		import="evadroid.controller.RegisterValidate"%>
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
	String old_pwd = request.getParameter("old_pwd");
	String pwd = request.getParameter("pwd");
	String pwd_cfm = request.getParameter("pwd_cfm");

	boolean passwordValidate=false;
	boolean passwordMatch=false;
	if (old_pwd != null && pwd != null && pwd_cfm != null) {
		passwordValidate = RegisterValidate.validatePassword(pwd);
		passwordMatch = RegisterValidate.validatePasswordMatch(pwd, pwd_cfm);
		if (old_pwd.equals(profile.getPassword())){
			if(passwordValidate && passwordMatch) {
				profile.setPassword(pwd);
				user.update();
				out.println("<script type=\"text/javascript\">");
				out.println("alert(\"修改成功\")");	
				out.println("location.href = '/settings.jsp';");
				out.println("</script>");
				return;
			}
			else {
				out.println("<script type=\"text/javascript\">");
				out.println("alert(\"新密码输入有误，修改失败\")");	
				out.println("location.href = '/settings.jsp';");
				out.println("</script>");
				return;
			}
		}
		else {
			out.println("<script type=\"text/javascript\">");
			out.println("alert(\"旧密码输入有误，修改失败\")");	
			out.println("location.href = '/settings.jsp';");
			out.println("</script>");
			return;
		}
	}
	else {
		out.println("<script type=\"text/javascript\">");
		out.println("alert(\"未输入完整，修改失败\")");	
		out.println("location.href = '/settings.jsp';");
		out.println("</script>");
		return;
	}


%>