package EvaToolkit;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.AsyncTask;
import android.os.Environment;
import android.view.View;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.impl.client.DefaultHttpClient;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by weililie on 15/3/19.
 */
public class EvaToolkit {
    private static String fileName = "evalog.xml";
    private static String filePath = null;
    public static void init(Context context, int aid) {
        filePath = Environment.getExternalStoragePublicDirectory(
                Environment.DIRECTORY_DOCUMENTS).toString() + "/Eva/";

        File dir = new File(filePath);
        if(!dir.exists())
            dir.mkdirs();

        String InitName = context.getClass().getSimpleName();
        System.out.println(filePath);
        int tid = 0;

        //get apk name(read tid)
        ArrayList<PackageInfo> res = new ArrayList<PackageInfo>();
        PackageManager pm = context.getPackageManager();
        List<PackageInfo> packs = pm.getInstalledPackages(0);

        for(int i=0;i<packs.size();i++) {
            PackageInfo p = packs.get(i);
            String description = (String) p.applicationInfo.loadDescription(pm);
            String  label= p.applicationInfo.loadLabel(pm).toString();
            //Continue to extract other info about the app...
        }

        String[] writeStr = {"<aid>" + aid +"</aid>", "<tid>" + tid + "</tid>", "<Activity> "+ InitName + " </Activity>"};


        FileUtil.writeLinesToFile(filePath + fileName, writeStr, false);
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

    public static void finish(){
        (new UploadTask()).execute(filePath + fileName);
    }
}
class UploadTask extends AsyncTask<String, Void, Void> {
    @Override
    protected Void doInBackground(String... params) {
        String url = "http://evadroid.liliecat.com/process/record_uploaded.jsp";
        String fileUrl = params[0];

        File file = new File(fileUrl);

        try {
            HttpClient httpClient = new DefaultHttpClient();
            HttpPost httpPost = new HttpPost(url);

            InputStreamEntity reqEntity = new InputStreamEntity(new FileInputStream(file), -1);
            reqEntity.setContentType("multipart/form-data");
            reqEntity.setChunked(true);

            httpPost.setEntity(reqEntity);
            HttpResponse response = httpClient.execute(httpPost);

            System.out.print(response.toString());
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}