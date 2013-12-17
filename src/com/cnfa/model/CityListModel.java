package com.cnfa.model;


public class CityListModel {
	public static final byte ID = 1;
	public static final byte CITY_NAME = 2;
	public static final byte STATUS = 3;
	public static final byte LAST_UPDATED_TIME = 4;
	public static final byte PROVINCE = 5;
	private String cityname = null;
	private String status = null;
	private String lastUpdateTime = null;
	private String id = null;
	private String province = null;
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCityname() {
		return cityname;
	}
	public void setCityname(String cityname) {
		this.cityname = cityname;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(String lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}


}
