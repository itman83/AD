package com.cnfa.db;

import java.io.File;
import java.util.ArrayList;

import android.content.Context;
import android.database.sqlite.SQLiteException;
import android.os.Environment;

public class DbQuery {
	public static final String DB_PATH = "/data/data/";
	public static final String DB_NAME = "/databases/cnfadb.sqlite";
	public static final String DB_GET_BOOK_BY_SUBJECT = "select * from ET_Book_Table";
	public static final String DB_GET_DIGI_BOOK_BY_SUBJECT = "select * from ET_Digitally_Book";
	public static final String DB_GET_TOC_BOOK = "select * from ET_Book_Toc where bookId = ?";
	public static final String DB_GET_TASK = "Select * from ET_Calender where Start_Date = ?";
	public static final String DB_USER_INFO = "Select * from ET_UserInfo";
	public static final String DB_INFO = "Select * from ET_Info";
	public static final String DB_Grade = "Select * from ET_Grade";
	//	public static String DB_SD_PATH = Environment.getExternalStorageDirectory().toString()+"/Android/data/pearsonalfa/EduApp/DB/EduTab.sqlite";
	//	public static String DB_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/Android/data/pearsonalfa/EduApp/BookCovers/";

	// For /mnt/extsd
	//	public static String DB_SD_PATH = "/mnt/extsd"+"/pearson/activeteach/DB/EduTab.sqlite";
	//	public static String DB_BOOK_PATH = "/mnt/extsd"+"/pearson/activeteach/BookCovers/";
	//	public static String DB_DIGI_BOOK_PATH = "/mnt/extsd"+"/pearson/digiconnect/";

	public static String DB_SD_PATH = "";
	public static String DB_BOOK_PATH = "";
	public static String DB_DIGI_BOOK_PATH = "";

	public static void DBPathInit(Context context){
		DB_SD_PATH = DB_PATH+context.getPackageName()+ DB_NAME;
	}
	
	public static void checkExDb() {
		boolean isSDPresent = android.os.Environment.getExternalStorageState().equals(android.os.Environment.MEDIA_MOUNTED);
		File storageDir = new File("/mnt/");
		if(storageDir.isDirectory()){
			String[] dirList1 = storageDir.list();
			ArrayList<String> dirList = null;
			dirList = new ArrayList<String>();
			
			for(int i=0;i<dirList1.length;i++){
				dirList.add(dirList1[i]);
			}
			if(dirList != null && dirList.contains("extsd")){
				String str = "/mnt/extsd/pearson/activeteach/BookCovers/";
				if(checkDataBase(str)){
					DB_BOOK_PATH = "/mnt/extsd/pearson/activeteach/BookCovers/";
					DB_DIGI_BOOK_PATH = "/mnt/extsd/pearson/digiconnect/";
				}else{
					DB_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/activeteach/BookCovers/";
					DB_DIGI_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/digiconnect/";
				}
			}else if(dirList != null && dirList.contains("ext_sd")){
				String str = "/mnt/ext_sd/pearson/activeteach/BookCovers/";
				if(checkDataBase(str)){
					DB_BOOK_PATH = "/mnt/ext_sd/pearson/activeteach/BookCovers/";
					DB_DIGI_BOOK_PATH = "/mnt/ext_sd/pearson/digiconnect/";
				}else{
					DB_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/activeteach/BookCovers/";
					DB_DIGI_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/digiconnect/";
				}
			}else if(dirList != null && dirList.contains("extSdCard")){
				String str = "/mnt/extSdCard/pearson/activeteach/BookCovers/";
				if(checkDataBase(str)){
					DB_BOOK_PATH = "/mnt/extSdCard/pearson/activeteach/BookCovers/";
					DB_DIGI_BOOK_PATH = "/mnt/extSdCard/pearson/digiconnect/";
				}else{
					DB_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/activeteach/BookCovers/";
					DB_DIGI_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/digiconnect/";
				}
			}else if(dirList != null && dirList.contains("external_sd")){
				String str = "/mnt/external_sd/pearson/activeteach/BookCovers/";
				if(checkDataBase(str)){
					DB_BOOK_PATH = "/mnt/external_sd/pearson/activeteach/BookCovers/";
					DB_DIGI_BOOK_PATH = "/mnt/external_sd/pearson/digiconnect/";
				}else{
					DB_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/activeteach/BookCovers/";
					DB_DIGI_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/digiconnect/";
				}
			}else{
				DB_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/activeteach/BookCovers/";
				DB_DIGI_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/digiconnect/";
			}
		}
	}

	public static boolean checkDataBase(String dB_SD_PATH) {
		try {
			File dir = new File(dB_SD_PATH);
			if(dir.exists() && dir.isDirectory()) {
				return true;
			}else{
				return false;
			}
		} catch (SQLiteException e) {
			e.printStackTrace();
		}
		return false;
	}

	//	public static String DB_SD_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/activeteach/DB/EduTab.sqlite";
	//	public static String DB_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/activeteach/BookCovers/";
	//	public static String DB_DIGI_BOOK_PATH = Environment.getExternalStorageDirectory().toString()+"/pearson/digiconnect/";
	//	


		/*public static String DB_SD_PATH = "/pearson/activeteach/DB/EduTab.sqlite";
		public static String DB_BOOK_PATH = "/pearson/activeteach/BookCovers/";
		public static String DB_DIGI_BOOK_PATH = "/pearson/digiconnect/";
*/
	//	public static String DB_SD_PATH = "/pearsonalfa/EduApp/DB/EduTab.sqlite";




}
