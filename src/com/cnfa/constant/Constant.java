package com.cnfa.constant;

import java.lang.reflect.Array;
import java.util.ArrayList;

import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

public class Constant {

	public static final String MSG_NETWORK_CONNECTION_NOT_AVAILABLE="Network connection not available.";
	public static final String MSG_CONTENT_NOT_AVAILABLE = "Content not available.";
	public static final String MSG_SEARCH_CONTENT = "Enter text";
	public static final String MSG_ADD_TO_FAVORITE = "Record added to favorite successfully.";
	public static final String MSG_REMOVE_FAVORITE = "Record remove from favorite.";
	public static final String MSG_SENT_SUCCESSFULLY = "Message send successfully.";

	//public static final String BASE_URL_TEMP = "http://204.197.244.110/~cnfanews/webservices/index.php";
	public static final String BASE_URL_LIVE = "http://www.cnfanads.com/webservices/index.php";
	//http://www.cnfanads.com/webservices/index.php?action=findads&category_id=1
	
	
/*	public static final String NEWS_PAPER_URL = BASE_URL_LIVE+"?action=newspapers";
	public static final String ABOUT_US_URL = BASE_URL_LIVE+"?action=aboutus";
	public static final String PRIVACY_URL = BASE_URL_LIVE+"?action=privacy";
	public static final String TERMS_OF_USE_URL = BASE_URL_LIVE+"?action=termsofuse";
	public static final String CONTACT_US_URL = BASE_URL_LIVE+"?action=contact_detail";
	public static final String CITY_LIST_URL = BASE_URL_LIVE+"?action=city";
	public static final String FEED_BACK_URL = BASE_URL_LIVE+"?action=contactus";
	public static final String NEWSPAPER_TO_CATEGORY = BASE_URL_LIVE+"?action=findcat&newspaper_id=";
	public static final String NEWSPAPER_CITY_LIST = BASE_URL_LIVE+"?action=findnews&city_id=";
	public static final String SEARCH_FROM_NEWSPAPER = BASE_URL_LIVE+"?action=search_all&ads=";
	public static final String FIND_ADS_FROM_CATEGORY= BASE_URL_LIVE+"?action=findads&category_id=";
	public static final String FIND_ADS_FROM_CATEGORY_SEARCH_OPTION= BASE_URL_LIVE+"?action=searchbynewspaper&newspaper_id=";
*/
	
	
	
	//FOR LOCAL SERVER
	public static final String NEWS_PAPER_URL = BASE_URL_LIVE+"?action=newspapers";
	public static final String ABOUT_US_URL = BASE_URL_LIVE+"?action=aboutus";
	public static final String PRIVACY_URL = BASE_URL_LIVE+"?action=privacy";
	public static final String TERMS_OF_USE_URL = BASE_URL_LIVE+"?action=termsofuse";
	public static final String CONTACT_US_URL = BASE_URL_LIVE+"?action=contact_detail";
	public static final String CITY_LIST_URL = BASE_URL_LIVE+"?action=city";
	public static final String FEED_BACK_URL = BASE_URL_LIVE+"?action=contactus";
	public static final String NEWSPAPER_TO_CATEGORY = BASE_URL_LIVE+"?action=findcat&newspaper_id=";
	public static final String NEWSPAPER_CITY_LIST = BASE_URL_LIVE+"?action=findnews&city_id=";
	public static final String SEARCH_FROM_NEWSPAPER = BASE_URL_LIVE+"?action=search_all&ads=";
	public static final String FIND_ADS_FROM_CATEGORY= BASE_URL_LIVE+"?action=findads&category_id=";
	public static final String FIND_ADS_FROM_CATEGORY_SEARCH_OPTION= BASE_URL_LIVE+"?action=searchbynewspaper&newspaper_id=";

	
	
	public static ArrayList<Context>activity = new ArrayList<Context>();
	
	public static String DB_PATH = "";
	
	public static String CITY_ID="";
	

	public static final String URL_WEIBO = "http://e.weibo.com/3272098172/profile";
	public static final String URL_TENCENT = "http://t.qq.com/fs2043525960";
	
	public static final String ACTIVITY_NEWS = "1";
	public static final String ACTIVITY_CITY = "2";
	public static final String ACTIVITY_FAV = "3";
	public static final String ACTIVITY_ABOUT_US = "4";
	public static  int NEWS_SCREEN = 1;
	public static  int CITY_SCREEN = 1;
	public static  int FAV_SCREEN = 1;
	public static  int INFO_SCREEN = 1;
	public static void showMsg(Context context, String msg) {
		Toast.makeText(context, msg, Toast.LENGTH_SHORT).show();
	}
	public static String getDB_PATH(Context myContext){
		return DB_PATH = "/data/data/"+myContext.getPackageName()+"/databases/cnfadb.sqlite";
		
	}
	
	
	public static boolean validateEmailID(String email) {

        if (email == null || email.length() == 0 || email.indexOf("@") == -1 || email.indexOf(" ") != -1) {
            return false;
        }
        int emailLenght = email.length();
        int atPosition = email.indexOf("@");

        String beforeAt = email.substring(0, atPosition);
        String afterAt = email.substring(atPosition + 1, emailLenght);

        if (beforeAt.length() == 0 || afterAt.length() == 0) {
            return false;
        }
        if (email.charAt(atPosition - 1) == '.') {
            return false;
        }
        if (email.charAt(atPosition + 1) == '.') {
            return false;
        }
        if (afterAt.indexOf(".") == -1) {
            return false;
        }
        char dotCh = 0;
        for (int i = 0; i < afterAt.length(); i++) {
            char ch = afterAt.charAt(i);
            if ((ch == 0x2e) && (ch == dotCh)) {
                return false;
            }
            dotCh = ch;
        }
        if (afterAt.indexOf("@") != -1) {
            return false;
        }
        int ind = 0;
        do {
            int newInd = afterAt.indexOf(".", ind + 1);

            if (newInd == ind || newInd == -1) {
                String prefix = afterAt.substring(ind + 1);
                if (prefix.length() > 1 && prefix.length() < 6) {
                    break;
                } else {
                    return false;
                }
            } else {
                ind = newInd;
            }
        } while (true);
        dotCh = 0;
        for (int i = 0; i < beforeAt.length(); i++) {
            char ch = beforeAt.charAt(i);
            if (!((ch >= 0x30 && ch <= 0x39) || (ch >= 0x41 && ch <= 0x5a) || (ch >= 0x61 && ch <= 0x7a)
                    || (ch == 0x2e) || (ch == 0x2d) || (ch == 0x5f))) {
                return false;
            }
            if ((ch == 0x2e) && (ch == dotCh)) {
                return false;
            }
            dotCh = ch;
        }
        return true;
    }
	
	public static void shareText(Context context, String title, String description){
		Intent i = new Intent(Intent.ACTION_SEND);
		i.setType("text/plain");
		i.putExtra(Intent.EXTRA_EMAIL  , new String[]{""});
		i.putExtra(Intent.EXTRA_SUBJECT, title);
		i.putExtra(Intent.EXTRA_TEXT   , description);
		try {
			context.startActivity(Intent.createChooser(i, "Share"));
		} catch (android.content.ActivityNotFoundException ex) {
		    Toast.makeText(context, "There are no email clients installed.", Toast.LENGTH_SHORT).show();
		}
	}
	
	
}
