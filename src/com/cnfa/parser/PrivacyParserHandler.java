package com.cnfa.parser;




import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.cnfa.model.PrivacyModel;

public class PrivacyParserHandler{
//	GetSetModel iModel = null;
//	GetSetModel.ITEM _item;
	public PrivacyParserHandler(){

	}
	
	public ArrayList<PrivacyModel> getParseDataByModel(String responce){
		int tagName = 0;
		PrivacyModel iModel = null;
		ArrayList<PrivacyModel> arr_privacy= new ArrayList<PrivacyModel>();

		try {

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new StringReader(responce));
			int eventType = parser.getEventType();
		
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("posts")) {
						iModel = new PrivacyModel();
					}else if (parser.getName().equals("content")) {
						tagName = PrivacyModel.CONTENT;
					}
					else if (parser.getName().equals("update_time")) {
						tagName = PrivacyModel.LAST_UPDATED_TIME;
					}
				}
				if (eventType == XmlPullParser.TEXT) {
					switch (tagName) {
				
					case PrivacyModel.CONTENT:
						iModel.setContent(parser.getText());
						break;
					case PrivacyModel.LAST_UPDATED_TIME:
						iModel.setLastUpdateTime(parser.getText());
						break;
					}
				}
				if (eventType == XmlPullParser.END_TAG) {
					if (parser.getName().equals("posts")) {
						arr_privacy.add(iModel);
					}
				}
				eventType = parser.next();
			}

		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return arr_privacy;
	}
}
