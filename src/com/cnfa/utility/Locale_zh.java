package com.cnfa.utility;

import java.util.HashMap;

public class Locale_zh {

	private static Locale_zh instance = null;	
	public HashMap<String, String> list = new HashMap<String, String>();
	
	protected Locale_zh() {
		// Exists only to defeat instantiation.
		setVal();
	}

	public static Locale_zh getInstance() {
		if (instance == null) {
			instance = new Locale_zh();
		}
		return instance;
	}	
	
	public String getVal(String key) {
		return list.get(key);
	}
	
	public void setVal() {
		// lang: zh
		
	
		list.put("Global_Label_Loading_1", "Please wait...");
		list.put("Alert_OK", "Ok");
		list.put("CALL", "取消");
		list.put("CANCEL", "确认");
		list.put("NO_RESULT_FOUND", "对不起！没有找到你需要的信息");
	}
}
