<%@ page import = "evadroid.model.*" pageEncoding="UTF-8"%>
<%@ page
	import = "java.util.ArrayList"
	import = "evadroid.utils.*"
	import = "evadroid.graph.*"
	import = "evadroid.controller.*"
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
	boolean exist = appProfile.getResult() != null && !appProfile.getResult().equals("");
	boolean exist_xml = appProfile.getXml() != null && !appProfile.getXml().equals("");
	ArrayList<ActivityNode> activityList = null, activityList_xml = null;
	ArrayList<NodePair> pairList = new ArrayList<NodePair>(), pairList_xml = new ArrayList<NodePair>();
	Iterator<ActivityNode> it = null, it_xml = null;
	MyXMLParser parser = null;

	if (exist) {
		activityList = (ArrayList<ActivityNode>)ObjectIOUtil.read(appProfile.getResult());
		it = activityList.iterator();
	}

	if (exist_xml) {
		try{
			parser = new MyXMLParser(request.getServletContext().getRealPath("/") + appProfile.getXml());
			activityList_xml = parser.readSingleFile();
			it_xml = activityList_xml.iterator();
		}
		catch(Exception e) {
			out.println("<script type=\"text/javascript\">");
			out.println("alert(\"标准图xml文件格式有误，请重新上传！\")");	
			out.println("</script>");
			exist_xml = false;
		}
	}

%>

<html>
	<head>
		<title>Evadroid | <%=appProfile.getName()%>测试结果</title>
		<link rel="stylesheet" type="text/css" href="css/general.css">
		<link rel="stylesheet" type="text/css" href="css/upload.css">
		<link rel="stylesheet" type="text/css" href="css/uploadify.css">
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
		<script type="text/javascript" src="js/jquery.uploadify.min.js"></script>
	</head>
	<body>
		<div id="navi">
			<ul>
				<li><a href="myEvaDeveloper.jsp">首页</a></li>
				<li><a href="explore.jsp">发现</a></li>
				<li><a href="settings.jsp">修改密码</a></li>
				<li><a href="toolkit.jsp">安卓工具包下载</a></li>
				<li><a href="documentation.jsp">文档</a></li>
				<li><%= profile.getName()%></li>
				<li><a href="process/logout.jsp">退出</a></li>
			</ul>
		</div>
		<div class="container">
			<div id="left">
				<h4>App信息</h4>
				<p>名称: <%= appProfile.getName()%></p>
				<p>id: <%= appProfile.getId()%> (请在使用安卓工具包时传入此参数)</p>
				<a href=<%="\"analysis.jsp?aid=" + aid + "\""%> class="download_button">查看分析结果</a>
				<h4>上传apk文件</h4>
				<form action="apk_uploadify.jsp" method="post" enctype="multipart/form-data">
					<div id="queue"></div>
					<input id="apk_upload" name="apk_upload" type="file">
					<!--input type="submit"-->
				</form>
				<h4>上传app图标</h4>
				<form action="icon_uploadify.jsp" method="post" enctype="multipart/form-data">
					<div id="queue"></div>
					<input id="icon_upload" name="icon_upload" type="file">
					<!--input type="submit"-->
				</form>
				<h4>上传理想xml文件</h4>
				<form action="xml_uploadify.jsp" method="post" enctype="multipart/form-data">
					<div id="queue"></div>
					<input id="xml_upload" name="xml_upload" type="file">
					<!--input type="submit"-->
				</form>
			</div>
			
			<div id="right">
				<h4>App评分</h4>
				<p>评分次数: <%= TestRecord.getCount(aid)%></p>
				<p>平均分: <%= TestRecord.getAverage(aid)%></p>
				<h4>App实际 Event Activity 图</h4>
				<div id="canvas1">
					<%if(!exist){
						out.println("此App暂时没有使用信息");
					}else {
						out.println("<br/>Looks ugly? Hit <button id=\"redraw\" onclick=\"redraw();\">redraw</button>!<br>");
				}%>
				</div>
				<h4>App标准 Event Activity 图</h4>
				<div id="canvas2">
					<%if(!exist_xml){
						out.println("还没有标准图信息，请点击左侧图标上传");
					}else {
						out.println("<br/>Looks ugly? Hit <button id=\"redraw_xml\" onclick=\"redraw_xml();\">redraw</button>!<br>");
				}%>
				</div>
			</div>
		</div>
		<script type="text/javascript">
		<%if(exist) {%>
		
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
					var eLabel = {directed:true, label:<%=label %>};
					g.addEdge(<%= i%>, <%= edge.getDes()%>, eLabel);
			<%}i++;}%>
			var layouter = new Graph.Layout.Spring(g);
			var renderer = new Graph.Renderer.Raphael('canvas1', g, 730, 500);
			layouter.layout();
			renderer.draw();
			redraw = function() {
			    layouter.layout();
			    renderer.draw();
			};
				<%}%>
			<%if(exist_xml) {%>
		
			g_xml = new Graph();
			<%
			int i_xml = 0;
			while(it_xml.hasNext()){
				ActivityNode node = it_xml.next();%>
				var label = {label:<%= "\"" + node.getName() + ": " + node.getCount() + "\""%>};
				g_xml.addNode(<%="\"" + i_xml + "\""%>, label);
			<%
				i_xml++;}
			it_xml = activityList_xml.iterator();
			i_xml = 0;
			while(it_xml.hasNext()){
				ActivityNode node = it_xml.next();
				ArrayList<EventEdge> edges = node.getEdges();
				Iterator<EventEdge> itEdge = edges.iterator();
				while(itEdge.hasNext()){
					EventEdge edge = itEdge.next();
					NodePair pair = new NodePair(i_xml, edge.getDes());
					pairList_xml.add(pair);
					String label = null;
					if (pairList_xml.contains(pair.getReverse())) {
						label = "\".\\n.\\n(2)" + edge.getType() + ", " + edge.getName() + ": " + edge.getCount() + "\"";
					} else {
						label = "\""+ edge.getType() + ", " + edge.getName() + ": " + edge.getCount() + "\"";
					}%>
					var eLabel = {directed:true, label:<%=label %>};
					g_xml.addEdge(<%= i_xml%>, <%= edge.getDes()%>, eLabel);
			
			<%}i_xml++;}
			%>

			var layouter_xml = new Graph.Layout.Spring(g_xml);
			var renderer_xml = new Graph.Renderer.Raphael('canvas2', g_xml, 730, 500);
			layouter_xml.layout();
			renderer_xml.draw();
			redraw_xml = function() {
			    layouter_xml.layout();
			    renderer_xml.draw();
			};
				<%}%>
			$(function() {
			$('#apk_upload').uploadify({
				'successTimeout' : 100,
				'swf'      : 'uploadify.swf',
				'uploader' : 'apk_uploadify.jsp',
				'auto'	   : 'true',
				'fileTypeDesc' : 'apk文件',
				'fileTypeExts'  : '*.apk',
				'method'   : 'post',
				'onUploadSuccess' : function(file, data, response) {
				            if (response) {
				            	var newData=data.replace(/\r\n/g,'');
				            	$.get("process/setApkUrl.jsp",{id:<%="\"" + appProfile.getId() + "\""%>, url: newData});
				            };
				        }
			});
		});

		$(function() {
			$('#icon_upload').uploadify({
				'swf'      : 'uploadify.swf',
				'uploader' : 'icon_uploadify.jsp',
				'auto'	   : 'true',
				'fileTypeDesc' : 'jpg或png文件',
				'fileTypeExts'  : '*.jpg; *.jpeg; *.png',
				'method'   : 'post',
				'onUploadSuccess' : function(file, data, response) {
				            if (response) {
				            	var newData=data.replace(/\r\n/g,'');
				            	$('#icon').val(newData);
				            	$.get("process/setIconUrl.jsp",{id:<%="\"" + appProfile.getId() + "\""%>, url: newData});
				            };
				        }
			});
		});

		$(function() {
			$('#xml_upload').uploadify({
				'swf'      : 'uploadify.swf',
				'uploader' : 'xml_uploadify.jsp',
				'auto'	   : 'true',
				'fileTypeDesc' : 'xml文件',
				'fileTypeExts'  : '*.xml',
				'method'   : 'post',
				//'debug'	   : 'true',
				'onUploadSuccess' : function(file, data, response) {
				            if (response) {
				            	var newData=data.replace(/\r\n/g,'');
				            	$('#icon').val(newData);
				            	$.get("process/setXML.jsp",{id:<%="\"" + appProfile.getId() + "\""%>, xml: newData});
				            };
				        }
			});
		});
		</script>
	</body>
</html>