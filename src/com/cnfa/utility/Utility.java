package com.cnfa.utility;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.Random;
import java.util.UUID;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Typeface;
import android.net.ConnectivityManager;
import android.widget.Toast;

public class Utility {
	public static Typeface tfRegular = null;

	public static boolean isOnline(Context ctx) 
	{
		boolean isConnected = false;
		try
		{
			ConnectivityManager cm = (ConnectivityManager) ctx.getSystemService(Context.CONNECTIVITY_SERVICE);
			isConnected = cm.getActiveNetworkInfo().isConnectedOrConnecting();
		}
		catch(Exception ex)
		{
			isConnected = false;
		}
		return isConnected;
	}

	public static int getRandomNumber(){
		int result=0;
		int max=9999;
		int min=9;
		String UNIQUEID="";
		Random foo = new Random();
		result = foo.nextInt((max + 1) - min) + min;
	    //  System.out.println(randomNumber);
		return result;
	}
	
	public static String replace(String _text, String _searchStr,String _replacementStr) {
		// String buffer to store str
		StringBuffer sb = new StringBuffer();

		// Search for search
		int searchStringPos = _text.indexOf(_searchStr);
		int startPos = 0;
		int searchStringLength = _searchStr.length();

		// Iterate to add string
		while (searchStringPos != -1) {
			sb.append(_text.substring(startPos, searchStringPos)).append(
					_replacementStr);
			startPos = searchStringPos + searchStringLength;
			searchStringPos = _text.indexOf(_searchStr, startPos);
		}

		// Create string
		sb.append(_text.substring(startPos, _text.length()));

		return sb.toString();

	} 
	public static Typeface setRegularFont(Context context) {
		return tfRegular;
	}
	
	public static void showToast(Context applicationContext, String string) {
		Toast.makeText(applicationContext, string, Toast.LENGTH_LONG).show();
	}

	
	
	
	public static void initFonts(Context context) {
		tfRegular = Typeface.createFromAsset(context.getAssets(), "chinesefont.ttf");
	}
	public static String getString(InputStream in) {
		StringBuilder sb = null;
		try{
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			sb = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			System.out.println("Response = >"+sb.toString());
		}catch (Exception e) {e.printStackTrace();}
		return sb.toString();
	}
	
	public static Bitmap getImageBitmap(URL url) throws FileNotFoundException {
		Bitmap bitmap = null;
		URLConnection connection = null;
		try {
			connection = url.openConnection();
		} catch (IOException e1) {e1.printStackTrace();}
		try {
			connection.connect();
		} catch (IOException e1) {e1.printStackTrace();}
		InputStream is = null;
		try {
			is = connection.getInputStream();
		} catch (IOException e1) {e1.printStackTrace();}
		BufferedInputStream bis = new BufferedInputStream(is);

		try{
			bitmap = BitmapFactory.decodeStream(bis);
		}catch (OutOfMemoryError e) {bitmap = null;}
		bis = null;
		is = null;
		Runtime.getRuntime().gc();
		System.gc();
		return bitmap;
	}
	
	public static String generateUniqueId(){
		String uuid = UUID.randomUUID().toString();
		String[] uid=uuid.split("-");
		uuid=uid[0];
		System.out.println("uuid = " + uuid);
		return uuid;
	}
	public static String getVal(String key) {
		String output = "";
		try
		{
			if(Cache.language == "en") {
				output = Locale_en.getInstance().getVal(key).toString();
			} else if(Cache.language == "zh") {
				output = Locale_zh.getInstance().getVal(key).toString();
			}
		}catch (Exception e) {
		}
		return output;
	}
	
}