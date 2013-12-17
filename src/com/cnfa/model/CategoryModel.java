package com.cnfa.model;

import java.io.Serializable;

import android.graphics.Bitmap;

@SuppressWarnings("serial")
public class CategoryModel implements Serializable{
	
	public static final int ID = 1;
	public static final int TOTAL_ADS = 2;
	public static final int CATEGORY = 3;
	public static final int LOGO_URL = 4;
	public static final int IMAGE_NAME = 5;
	public static final int UPDATE_TIME = 6;
	
	private String id = null;
	private String category = null;
	private String logoUrl = null;
	private String imageName = null;
	private String update_time = null;
	private Bitmap bitmap = null;
	private String total_ads = null;
	
	public Bitmap getBitmap() {
		return bitmap;
	}
	public void setBitmap(Bitmap bitmap) {
		this.bitmap = bitmap;
	}

	public String getTotal_ads() {
		return total_ads;
	}
	public void setTotal_ads(String total_ads) {
		this.total_ads = total_ads;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getLogoUrl() {
		return logoUrl;
	}
	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public String getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(String update_time) {
		this.update_time = update_time;
	}

	
}
