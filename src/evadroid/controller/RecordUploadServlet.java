package evadroid.controller;

//import java.io.File;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.io.InputStreamReader;
import java.io.*;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import evadroid.model.*;

@WebServlet("/RecordUploadServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)	// 50MB

public class RecordUploadServlet extends HttpServlet {
	private String filePath;

	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        System.out.println("inside doPost");
		

//        BufferedReader in = new BufferedReader(
//                   new InputStreamReader(request.getInputStream()));
//            
//        String line = null;
//        while((line = in.readLine()) != null) {
//           System.out.println(line);
//        }
//        in.close();
        // gets absolute path of the web application
        String appPath = request.getServletContext().getRealPath("/");
        // constructs path of the directory to save uploaded file
        String savePath = appPath + "myFile/record/";
        String resultPath = appPath + "myFile/result/";
         
        // creates the save directory if it does not exists
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        
        String fileName = "";
        for (Part part : request.getParts()) {
            System.out.println("inside for");
            DateFormat df = new SimpleDateFormat("yyMMddHHmmss");
            fileName = df.format(new Date()) + extractFileName(part);
            part.write(savePath + fileName);
            System.out.println(savePath + fileName);
        }
        System.out.println(savePath + fileName);
        
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        out.println(savePath + fileName);
        
        filePath = savePath + fileName;
        try{
        	execute(resultPath);
        } catch(Exception e) {
        	e.printStackTrace(out);
        }
    }
	
	private void execute(String resultPath) throws Exception{
		MyXMLParser parser = new MyXMLParser(filePath);
		int tid = parser.getTid();
		int aid = parser.getAid();
		User user = User.getById(tid);
		
		AppProfile ap = App.getAppById(aid).getAppProfile();
		
		int credit = ap.getPoint();
		user.getCredit(credit);
		
		parser.readAndSave(resultPath);
	}
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }
}