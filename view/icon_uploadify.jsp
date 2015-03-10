<%@ page import="java.io.*,java.util.*, javax.servlet.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import = "evadroid.model.User"%>
<%@ page import = "evadroid.model.UserProfile"%>
<%@ page import = "evadroid.model.AppProfile"%>

<%
   User user = null;
   UserProfile profile = null;
   AppProfile appProfile = null;
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

   try {
      appProfile = (AppProfile)session.getAttribute("appProfile");
   }
   catch(Exception e) {
      out.println("<script type=\"text/javascript\">");
      out.println("alert(\"请重新上传！\")");   
      out.println("location.href = 'upload.jsp';");
      out.println("</script>");
      return;
   }
   File file ;
   int maxFileSize = 50000 * 1024;
   int maxMemSize = 50000 * 1024;
   ServletContext context = pageContext.getServletContext();
   //String filePath = context.getInitParameter("file-upload");
   String filePath = context.getRealPath("/") + "/files/icon/";
   //String filePath = "/tmp/";

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      //factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         while ( i.hasNext () ) 
         {
            out.println("inside while");
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )  
            {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();

               // Write the file
               //if( fileName.lastIndexOf("\\") >= 0 ){
               //   file = new File( filePath + 
               //  fileName.substring( fileName.lastIndexOf("\\"))) ;
               //}else{
               file = new File( filePath + 
               fileName.substring( fileName.lastIndexOf("\\") + 1)) ;
               //}
               fi.write( file ) ;
               appProfile.setIcon(filePath + fileName);
               out.println("Uploaded Filename: " + filePath + 
               fileName + "<br>");
            }
         }
         out.println("</body>");
         out.println("</html>");
      }catch(Exception ex) {
         out.println("<br>");
         out.println(ex);
      }
   }else{
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>