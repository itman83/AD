package com.cnfa.model;

public class ContactUsModel {
	public static final int ADDRESS = 1;
	public static final int PHN_NO = 2;
	public static final int FAX_NO = 3;

	public static final int MAIL_ID = 4;

	public static final int WEBMAME = 5;

	public static final int URL1 = 6;

	public static final int URL2 = 7;

	private String phone_no = null;
	private String fax_no = null;
	private String mail_id = null;
	private String address = null;
	private String website_name = null;
	private String social_url1 = null;
	private String social_url2 = null;

	public String getPhoneNo() {
		return phone_no;
	}

	public void setPhoneNo(String phone_no) {
		this.phone_no = phone_no;
	}

	public String getFaxNo() {
		return fax_no;
	}

	public void setFaxNo(String fax_no) {
		this.fax_no = fax_no;
	}

	public String getMailId() {
		return mail_id;
	}

	public void setMailId(String mail_id) {
		this.mail_id = mail_id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getWebName() {
		return website_name;
	}

	public void setWebName(String website_name) {
		this.website_name = website_name;
	}

	public String getURL1() {
		return social_url1;
	}

	public void setURL1(String social_url1) {
		this.social_url1 = social_url1;
	}

	public String getURL2() {
		return social_url2;
	}

	public void setURL2(String social_url2) {
		this.social_url2 = social_url2;
	}
}
