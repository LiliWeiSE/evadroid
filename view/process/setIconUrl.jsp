<%@ page import = "evadroid.model.App" pageEncoding="UTF-8"%>
<%@ page import = "evadroid.model.AppProfile"%>
<%
	String aidstr = request.getParameter("id");
	int aid = Integer.parseInt(aidstr);
	String url = request.getParameter("url");
	App app = App.getAppById(aid);
	app.getAppProfile().setIcon(url);
	app.update();
%>