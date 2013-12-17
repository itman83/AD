package com.cnfa.utility;

import java.util.HashMap;

public class Locale_en {
	
	private static Locale_en instance = null;	
	public HashMap<String, String> list = new HashMap<String, String>();
	
	protected Locale_en() {
		// Exists only to defeat instantiation.
		setVal();
	}

	public static Locale_en getInstance() {
		if (instance == null) {
			instance = new Locale_en();
		}
		return instance;
	}
		
	public String getVal(String key) {
		return list.get(key);
	}
	
	public void setVal() {
		// lang: en
	
		
		list.put("Global_Label_Loading_1", "Please wait...");
		list.put("Alert_OK", "Ok");
		

	
		list.put("CALL", "Call");
		list.put("CANCEL", "Cancel");
		list.put("NO_RESULT_FOUND", "No Result Found");

//		list.put("AVG_PRICE", "Avg. Price:");
	}

}
