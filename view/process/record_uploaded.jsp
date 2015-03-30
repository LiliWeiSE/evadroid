<%@ page import = "java.io.*,java.util.*, javax.servlet.*" pageEncoding="UTF-8"
         import = "javax.servlet.http.*"
         import = "org.apache.commons.fileupload.*"
         import = "org.apache.commons.fileupload.FileItemFactory"
         import = "org.apache.commons.fileupload.disk.*" 
         import = "org.apache.commons.fileupload.servlet.*"
         import = "org.apache.commons.io.output.*"
         import = "evadroid.model.User"
         import = "evadroid.model.UserProfile"
         import = "evadroid.model.AppProfile"
         import = "java.text.DateFormat"
         import = "java.text.SimpleDateFormat"
         import = "java.util.Date"
         import = "java.util.Collection"%>
<%
   File file ;
   int maxFileSize = 50000 * 1024;
   int maxMemSize = 50000 * 1024;
   ServletContext context = pageContext.getServletContext();
   //String filePath = context.getInitParameter("file-upload");
   String filePath = context.getRealPath("/") + "myFile/record/";
   //String filePath = "/tmp/";

   // Verify the content type
   String contentType = request.getContentType();
   System.out.println("you are in");
   System.out.println(request.getContentLength());
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      System.out.println("inside if");

      //DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      //factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.

      // Create a new file upload handler
      //ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      //upload.setSizeMax( maxFileSize );
      /*try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         while ( i.hasNext () ) 
         {
            System.out.println("inside while");
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )  
            {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
               DateFormat df = new SimpleDateFormat("yyMMddHHmmss");
               fileName = df.format(new Date()) + fileName.substring( fileName.lastIndexOf("\\") + 1);

               file = new File(filePath + fileName);
               
               fi.write( file ) ;
               System.out.println("myFile/record/"+ fileName);
               // todo: read and get tid and aid and save to the database

               //todo: parse the xml file and save update the results
            }
         }*/
      /*}catch(Exception ex) {
        out.println("<br>");
         out.println(ex);
      }*/

      /*Part part = request.getPart("record");
      if(part == null)
         System.out.println("fuck you!");
      else {
         String fileName = null;
         DateFormat df = new SimpleDateFormat("yyMMddHHmmss");
         fileName = df.format(new Date()) + ".xml";
         part.write(filePath + fileName);

      }*/
      
      Collection<Part> c = request.getParts();
      if(c == null)
         System.out.println("fuck you!");
      else {
         System.out.println("wtf?");
         System.out.println(c.isEmpty());
         for (Part p: c) {
            System.out.println(p.toString());
            System.out.println(p.getName());
         }
      }
   }else{
   out.println("somethingwrong!!");
   }
%>