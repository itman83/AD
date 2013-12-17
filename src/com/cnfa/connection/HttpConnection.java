package com.cnfa.connection;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HTTP;
import org.json.JSONObject;

import android.util.Log;

public class HttpConnection {
	private static final int TIMEOUT_MILLISEC = 0;

	    public static InputStream connect(String url)
	    {
	        InputStream in = null;
	        try
	        {
	        	System.out.println("Request-- > "+url);
	            HttpClient httpclient = new DefaultHttpClient();
	            HttpGet httpget = new HttpGet(url);
	            HttpResponse response = httpclient.execute(httpget);
	            HttpEntity entity = response.getEntity();
	            if (entity != null) {
	                HttpEntity httpEntity = response.getEntity();
	                in = httpEntity.getContent();
	               
	              //  String response1=Utility.getString(in);
	            }

	        }catch (Exception e) {e.printStackTrace();}

	        return in;
	    }    
	    
		public static void sendOrderDetails(JSONObject strjson, String url){
			
			//strjson = strjson.replaceAll("\"", "");
			
			try {
				HttpParams httpParams = new BasicHttpParams();
				HttpConnectionParams.setConnectionTimeout(httpParams,TIMEOUT_MILLISEC);
				HttpConnectionParams.setSoTimeout(httpParams, TIMEOUT_MILLISEC);
				HttpClient client = new DefaultHttpClient(httpParams);
				HttpPost httpPost = new HttpPost(url);
				StringEntity entity = new StringEntity(strjson.toString(), HTTP.UTF_8);
				//		entity.setContentType("application/x-www-form-urlencoded;charset=UTF-8");
				entity.setContentType("application/json;charset=UTF-8");
				httpPost.setEntity(entity);
				//	HttpClient client = new DefaultHttpClient();
				HttpResponse response = client.execute(httpPost);

				/*		HttpPost request = new HttpPost(url);
				request.setEntity(new ByteArrayEntity(json.toString().getBytes("UTF8")));
				request.setHeader("json", json.toString());
				HttpResponse response = client.execute(request);*/

				HttpEntity entity1 = response.getEntity();
				// If the response does not enclose an entity, there is no need
				if (entity1 != null) {
					InputStream instream = entity1.getContent();
					BufferedReader br = new BufferedReader(new InputStreamReader(instream));
					StringBuilder sb = new StringBuilder();
					String line;
					while ((line = br.readLine()) != null) {
						sb.append(line);
					} 
					Log.i("","response  xml file:" +sb.toString()); 
				}
			} catch (Exception e) {
				e.printStackTrace();
				//Toast.makeText(this, "Request failed: " + t.toString(),Toast.LENGTH_LONG).show();
			}
		}
	    
}
