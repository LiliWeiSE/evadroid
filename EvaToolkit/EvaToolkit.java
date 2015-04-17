package evatoolkit;

import android.content.Context;
import android.content.Intent;
import android.os.Environment;
import java.io.File;


/**
 * Created by weililie on 15/3/19.
 */
public class EvaToolkit {
    private static String fileName = "evalog.xml";
    private static String filePath = null;
    private static boolean flag = true;

    public static String getFilePath() {
        return filePath;
    }

    public static String getFileName() {
        return fileName;
    }

    public static void init(Context context, int aid) {
        filePath = Environment.getExternalStoragePublicDirectory(
                Environment.DIRECTORY_DOCUMENTS).toString() + "/Eva/";

        File dir = new File(filePath);
        if(!dir.exists())
            dir.mkdirs();

        String InitName = context.getClass().getSimpleName();
        System.out.println(filePath);

        if(flag) {
            Intent intent = new Intent(context, GetTid.class);
            context.startActivity(intent);
            String[] writeStr = {"<record>", "<aid>" + aid +"</aid>"};
            FileUtil.writeLinesToFile(filePath + fileName, writeStr, false);
        }
        String[] writeStr2 = {"<Activity>" + InitName +"</Activity>"};
        FileUtil.writeLinesToFile(filePath + fileName, writeStr2, true);
        flag = false;
    }

    public static void addActivity(Context context) {
        String activityName = context.getClass().getSimpleName();
        String[] writeStr = {"<Activity>"+ activityName + "</Activity>"};

        FileUtil.writeLinesToFile(filePath + fileName, writeStr, true);
    }

    public static void addClick(String name){
        String[] writeStr = {"<Event>","<type>Click</type>","<name>" + name + "</name>", "</Event>"};

        FileUtil.writeLinesToFile(filePath + fileName, writeStr, true);
    }

    public static void addClickMenu(String name) {
        String[] writeStr = {"<Event>", "<type>MenuItemClick</type>", "<name>" + name + "</name>", "</Event>"};

        FileUtil.writeLinesToFile(filePath + fileName, writeStr, true);
    }

    public static void addKeyDown(String name) {
        String[] writeStr = {"<Event>", "<type>KeyDown</type>", "<name>" + name + "</name>", "</Event>"};

        FileUtil.writeLinesToFile(filePath + fileName, writeStr, true);
    }

    public static void finish(){
        System.out.println("0" + filePath + fileName);
        String[] writeStr = {"</record>"};
        FileUtil.writeLinesToFile(filePath + fileName, writeStr, true);

        (new UploadTask()).execute(new String[]{filePath + fileName});
    }
}
