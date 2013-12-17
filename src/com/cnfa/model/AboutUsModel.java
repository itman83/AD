package com.cnfa.model;

public class AboutUsModel {
	public static final byte CONTENT = 1;
	public static final byte LAST_UPDATED_TIME = 2;
	private String content = null;

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	private String lastUpdateTime = null;
 
	public String getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(String lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

}
