package com.cnfa.model;

import android.graphics.Bitmap;
import android.os.Parcel;
import android.os.Parcelable;

public class NewsPaperModel implements Parcelable{
	public static final byte ID = 1;
	public static final byte TITLE = 2;
	public static final byte IMAGE_URL = 3;
	public static final byte LAST_UPDATED_TIME = 4;
	public static final byte IMAGE = 5;

	private String id = null;
	private String title = null;
	private String logoUrl = null;
	private String lastUpdateTime = null;
	private String image = null;
	private Bitmap imageBitmap = null;

	public Bitmap getImageBitmap() {
		return imageBitmap;
	}
	public void setImageBitmap(Bitmap imageBitmap) {
		this.imageBitmap = imageBitmap;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLogoUrl() {
		return logoUrl;
	}
	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}
	public String getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(String lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	@Override
	public int describeContents() {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public void writeToParcel(Parcel dest, int flags) {
		// TODO Auto-generated method stub
		
	}

}
