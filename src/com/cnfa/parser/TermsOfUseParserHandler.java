package com.cnfa.parser;




import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.cnfa.model.TermsOfUseModel;

public class TermsOfUseParserHandler{
//	GetSetModel iModel = null;
//	GetSetModel.ITEM _item;
	public TermsOfUseParserHandler(){

	}
	
	public ArrayList<TermsOfUseModel> getParseDataByModel(String responce){
		int tagName = 0;
		TermsOfUseModel iModel = null;
		ArrayList<TermsOfUseModel> arr_term= new ArrayList<TermsOfUseModel>();

		try {

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new StringReader(responce));
			int eventType = parser.getEventType();
		
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("posts")) {
						iModel = new TermsOfUseModel();
					}else if (parser.getName().equals("content")) {
						tagName = TermsOfUseModel.CONTENT;
					}
					else if (parser.getName().equals("update_time")) {
						tagName = TermsOfUseModel.LAST_UPDATED_TIME;
					}
				}
				if (eventType == XmlPullParser.TEXT) {
					switch (tagName) {
				
					case TermsOfUseModel.CONTENT:
						iModel.setContent(parser.getText());
						break;
					case TermsOfUseModel.LAST_UPDATED_TIME:
						iModel.setLastUpdateTime(parser.getText());
						break;
					}
				}
				if (eventType == XmlPullParser.END_TAG) {
					if (parser.getName().equals("posts")) {
						arr_term.add(iModel);
					}
				}
				eventType = parser.next();
			}

		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return arr_term;
	}
}
