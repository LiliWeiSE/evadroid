package evatoolkit;

import android.os.AsyncTask;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * Created by weililie on 15/3/24.
 */
class UploadTask extends AsyncTask<String, Void, HttpResponse> {
    //private static HttpClient httpClient = new DefaultHttpClient();
    @Override
    protected HttpResponse doInBackground(String... params) {
        String url = "http://evadroid.liliecat.com/RecordUpload";
        String fileUrl = params[0];
        System.out.println("1" + fileUrl);

        File file = new File(fileUrl);
        FileBody fb = new FileBody(file);
        HttpResponse response = null;
        String boundary = ""+System.currentTimeMillis();
            HttpClient httpClient = new DefaultHttpClient();
            HttpPost httpPost = new HttpPost(url);

            MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
            System.out.println("2" + file.toURI());
            entityBuilder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
           entityBuilder.setBoundary(boundary);
            //httpClient.


            //entityBuilder.addBinaryBody("record", file);
            entityBuilder.addPart("record",fb);

            HttpEntity entity = entityBuilder.build();


            httpPost.setEntity(entity);
            //httpPost.setHeader("Content-Type", "multipart/form-data; charset=utf-8");
        try {
            //entity.writeTo(System.out);

            response = httpClient.execute(httpPost);

            httpPost.getEntity().writeTo(System.out);
        } catch (IOException e) {
            System.out.println("in catch");
            System.out.println(e.getStackTrace().toString());
        }
        HttpEntity responseEntity = response.getEntity();
        System.out.println("after execute");
        int backCode = response.getStatusLine().getStatusCode();
        System.out.println(backCode);
        try {
            String result = EntityUtils.toString(responseEntity);
            System.out.println("4" + result);
        } catch (IOException e) {
            System.out.println("in catch");
            System.out.println(e.getStackTrace().toString());
        }

        try {
            responseEntity.consumeContent();
        } catch (IOException e) {
            System.out.println(e);
        }
        httpClient.getConnectionManager().closeExpiredConnections();
        return null;
    }
    @Override
    protected void onPostExecute(HttpResponse response){
        //System.out.println("3" + response);
    }
}
