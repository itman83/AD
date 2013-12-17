package com.cnfa.parser;




import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.cnfa.model.ContactUsModel;

public class ContactUsParserHandler{
//	GetSetModel iModel = null;
//	GetSetModel.ITEM _item;
	public ContactUsParserHandler(){

	}
	
	public ArrayList<ContactUsModel> getParseDataByModel(String responce){
		int tagName = 0;
		String address = "";
		ContactUsModel iModel = null;
		ArrayList<ContactUsModel> arr_aboutUs= new ArrayList<ContactUsModel>();

		try {

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new StringReader(responce));
			int eventType = parser.getEventType();
		
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("posts")) {
						iModel = new ContactUsModel();
					}else if (parser.getName().equals("address")) {
						tagName = ContactUsModel.ADDRESS;
					}
					else if (parser.getName().equals("phone_no")) {
						tagName = ContactUsModel.PHN_NO;
					}
					else if (parser.getName().equals("fax_no")) {
						tagName = ContactUsModel.FAX_NO;
					}
					else if (parser.getName().equals("mail_id")) {
						tagName = ContactUsModel.MAIL_ID;
					}
					else if (parser.getName().equals("website_name")) {
						tagName = ContactUsModel.WEBMAME;
					}
					else if (parser.getName().equals("social_url1")) {
						tagName = ContactUsModel.URL1;
					}
					else if (parser.getName().equals("social_url2")) {
						tagName = ContactUsModel.URL2;
					}
				}
				if (eventType == XmlPullParser.TEXT) {
					switch (tagName) {
				
					case ContactUsModel.ADDRESS:
						address = parser.getText();
						iModel.setAddress(address);
						break;
					case ContactUsModel.PHN_NO:
						String phnno = parser.getText();
						iModel.setPhoneNo(phnno);
						break;
					case ContactUsModel.FAX_NO:
						String faxno = parser.getText();
						iModel.setFaxNo(faxno);
						break;
					case ContactUsModel.MAIL_ID:
						String mailid = parser.getText();
						iModel.setMailId(mailid);
						break;
					case ContactUsModel.WEBMAME:
						String webname = parser.getText();
						iModel.setWebName(webname);
						break;
					case ContactUsModel.URL1:
						String url1 = parser.getText();
						iModel.setURL1(url1);
						break;
					case ContactUsModel.URL2:
						String url2 = parser.getText();
						iModel.setURL2(url2);
						break;
					}
				}
				if (eventType == XmlPullParser.END_TAG) {
					if (parser.getName().equals("posts")) {
						arr_aboutUs.add(iModel);
					}
				}
				eventType = parser.next();
			}

		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return arr_aboutUs;
	}
}
