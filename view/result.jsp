<%@ page import = "evadroid.model.User" pageEncoding="UTF-8"%>
<%@ page import = "evadroid.model.UserProfile"%>
<%@ page import = "evadroid.model.App"%>
<%@ page import = "evadroid.model.AppProfile"
	import = "java.util.ArrayList"
	import = "evadroid.utils.*"
	import = "evadroid.graph.*"
	import = "java.util.ArrayList"
	import = "java.util.Iterator" %>

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

	String aidstr = request.getParameter("aid");
	int aid = Integer.parseInt(aidstr);
	App app = App.getAppById(aid);
	AppProfile appProfile = app.getAppProfile();
	boolean exist = appProfile.getResult() != null && appProfile.getResult() != "";
	ArrayList<ActivityNode> activityList = null;
	ArrayList<NodePair> pairList = new ArrayList<NodePair>();
	Iterator<ActivityNode> it = null;

	if (exist) {
		activityList = (ArrayList<ActivityNode>)ObjectIOUtil.read(appProfile.getResult());
		it = activityList.iterator();
	}

%>

<html>
	<head>
		<title>Evadroid | <%=appProfile.getName()%>测试结果</title>
		<link rel="stylesheet" type="text/css" href="css/general.css">
		<link rel="stylesheet" type="text/css" href="css/developer.css">
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<script type="text/javascript" src="js/jquery-1.10.2.js"></script>
		<!--  The Raphael JavaScript library for vector graphics display  -->
		<script type="text/javascript" src="js/raphael-min.js"></script>
		<!--  Dracula  -->
		<!--  An extension of Raphael for connecting shapes -->
		<script type="text/javascript" src="js/dracula_graffle.js"></script>
		<!--  Graphs  -->
		<script type="text/javascript" src="js/dracula_graph.js"></script>
		<script type="text/javascript" src="js/dracula_algorithms.js"></script>
	</head>
	<body>
		<div id="navi">
			<ul>
				<li><a href="myEvaDeveloper.jsp">首页</a></li>
				<li><a href="explore.jsp">发现</a></li>
				<li><a href="settings.jsp">设置</a></li>
				<li><a href="toolkit.jsp">安卓工具包下载</a></li>
				<li><a href="documentation.jsp">文档</a></li>
				<li><%= profile.getName()%></li>
				<li><a href="process/logout.jsp">退出</a></li>
			</ul>
		</div>
		<div class="container">
			<h4>App评分</h4>
			<h4>App使用交互信息</h4>
			<div id="canvas">
				<%if(!exist){
					out.println("此App暂时没有使用信息");
				}else {
					out.println("<br/>Looks ugly? Hit <button id=\"redraw\" onclick=\"redraw();\">redraw</button>!<br>");
			}%>
			</div>
		</div>
		<%if(exist) {%>
		<script type="text/javascript">
			g = new Graph();
			<%
			int i = 0;
			while(it.hasNext()){
				ActivityNode node = it.next();%>
				var label = {label:<%= "\"" + node.getName() + ": " + node.getCount() + "\""%>};
				g.addNode(<%="\"" + i + "\""%>, label);
			<%
				i++;}
			it = activityList.iterator();
			i = 0;
			while(it.hasNext()){
				ActivityNode node = it.next();
				ArrayList<EventEdge> edges = node.getEdges();
				Iterator<EventEdge> itEdge = edges.iterator();
				while(itEdge.hasNext()){
					EventEdge edge = itEdge.next();
					NodePair pair = new NodePair(i, edge.getDes());
					pairList.add(pair);
					String label = null;
					if (pairList.contains(pair.getReverse())) {
						label = "\".\\n.\\n(2)" + edge.getType() + ", " + edge.getName() + ": " + edge.getCount() + "\"";
					} else {
						label = "\""+ edge.getType() + ", " + edge.getName() + ": " + edge.getCount() + "\"";
					}%>
					var eLabel = {directed:true, label:<%=label %>}
					g.addEdge(<%= i%>, <%= edge.getDes()%>, eLabel)
			<%	}
			%>
			<%i++;}%>

			var layouter = new Graph.Layout.Spring(g);
			var renderer = new Graph.Renderer.Raphael('canvas', g, 1024, 500);
			layouter.layout();
			renderer.draw();
			redraw = function() {
			    layouter.layout();
			    renderer.draw();
			};
		</script>
		<%}%>
	</body>
</html>