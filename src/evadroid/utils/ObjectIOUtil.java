package evadroid.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;

public class ObjectIOUtil {
	public static void write(String fileUrl, Object obj) throws IOException {
		File file = new File(fileUrl);
		OutputStream out = new FileOutputStream(file);
		ObjectOutputStream objOut = new ObjectOutputStream(out);
		objOut.writeObject(obj);
		objOut.flush();
		objOut.close();
	}
	
	public static Object read(String fileUrl) throws IOException{
		Object temp=null;
        File file =new File(fileUrl);
        if(!file.exists())
        	return null;
        FileInputStream in = new FileInputStream(file);
             
        ObjectInputStream objIn=new ObjectInputStream(in);
        try{
        	temp=objIn.readObject();
        }
        catch(ClassNotFoundException e) {
        	e.printStackTrace();
        	return null;
        }
        objIn.close();
        return temp;
	}
}
