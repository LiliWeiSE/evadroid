package evatoolkit;

import android.os.AsyncTask;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.impl.client.DefaultHttpClient;

import java.io.File;
import java.io.FileInputStream;

/**
 * Created by weililie on 15/3/24.
 */
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
