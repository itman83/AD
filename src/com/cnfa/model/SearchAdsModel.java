package com.cnfa.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class SearchAdsModel implements Serializable{
	
	public static final byte ID = 1;
	public static final byte ADS_TITLE = 2;
	public static final byte ADS_DESCRIPTION = 3;
	public static final byte CITY = 4;
	public static final byte CATEGORY_ID = 5;
	public static final byte STATUS = 6;
	public static final byte CREATION_TIME = 7;
	public static final byte UPDATE_TIME = 8;
	public static final byte CITY_NAME = 9;
	public static final byte NEWS_PAPER_NAME =10;
	
	private String id = null;
	private String adsTitle = null;
	private String adsDescription = null;
	private String city = null;
	private String categoryId = null;
	private String status = null;
	private String creationTime = null;
	private String updateTime = null;
	private String cityName = null;
	private String newspaperName = null;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAdsTitle() {
		return adsTitle;
	}
	public void setAdsTitle(String adsTitle) {
		this.adsTitle = adsTitle;
	}
	public String getAdsDescription() {
		return adsDescription;
	}
	public void setAdsDescription(String adsDescription) {
		this.adsDescription = adsDescription;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreationTime() {
		return creationTime;
	}
	public void setCreationTime(String creationTime) {
		this.creationTime = creationTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getNewspaperName() {
		return newspaperName;
	}
	public void setNewspaperName(String newspaperName) {
		this.newspaperName = newspaperName;
	}

}
