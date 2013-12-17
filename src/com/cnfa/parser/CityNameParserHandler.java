package com.cnfa.parser;




import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.cnfa.model.CityListModel;

public class CityNameParserHandler{
//	GetSetModel iModel = null;
//	GetSetModel.ITEM _item;
	public CityNameParserHandler(){

	}
	
	public ArrayList<CityListModel> getParseDataByModel(String responce){
		int tagName = 0;
		CityListModel iModel = null;
		ArrayList<CityListModel> arr_cityname= new ArrayList<CityListModel>();

		try {

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new StringReader(responce));
			int eventType = parser.getEventType();
		
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("post")) {
						iModel = new CityListModel();
					}else if (parser.getName().equals("id")) {
						tagName = CityListModel.ID;
					}
					else if (parser.getName().equals("city_name")) {
						tagName = CityListModel.CITY_NAME;
					}
					else if (parser.getName().equals("status")) {
						tagName = CityListModel.STATUS;
					}
					else if (parser.getName().equals("update_time")) {
						tagName = CityListModel.LAST_UPDATED_TIME;
					}
					else if (parser.getName().equals("province")) {
						tagName = CityListModel.PROVINCE;
					}
					
				}
				if (eventType == XmlPullParser.TEXT) {
					switch (tagName) {
					case CityListModel.ID:
						iModel.setId(parser.getText());
						break;
					case CityListModel.CITY_NAME:
						iModel.setCityname(parser.getText());
						break;
					case CityListModel.STATUS:
						iModel.setStatus(parser.getText());
						break;
					case CityListModel.LAST_UPDATED_TIME:
						iModel.setLastUpdateTime(parser.getText());
						break;
					case CityListModel.PROVINCE:
						iModel.setProvince(parser.getText());
						break;
					
					}
				}
				if (eventType == XmlPullParser.END_TAG) {
					if (parser.getName().equals("post")) {
						arr_cityname.add(iModel);
					}
				}
				eventType = parser.next();
			}

		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return arr_cityname;
	}
}
