package com.cnfa.parser;




import java.io.IOException;
import java.io.StringReader;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.cnfa.model.ContactUsFeedbackModel;

public class FeedbackParserHandler{
//	GetSetModel iModel = null;
//	GetSetModel.ITEM _item;
	public FeedbackParserHandler(){

	}
	
	public String getParseDataByModel(String responce){
		int tagName = 0;
		String result = null;
		try {
 
			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new StringReader(responce));
			int eventType = parser.getEventType();
		
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("posts")) {

					}else if (parser.getName().equals("result")) {
						tagName = 1;
					}
					else if (parser.getName().equals("update_time")) {
						tagName = ContactUsFeedbackModel.LAST_UPDATED_TIME;
					}
				}
				if (eventType == XmlPullParser.TEXT) {
					switch (tagName) {
				
					case 1:
						result = parser.getText();
						break;
					
					}
				}
				if (eventType == XmlPullParser.END_TAG) {
					
				}
				eventType = parser.next();
			}

		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return result;
	}
}
