package com.cnfa.parser;




import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.cnfa.model.SearchAdsModel;

public class SearchAdsParserHandler{
//	GetSetModel iModel = null;
//	GetSetModel.ITEM _item;
	public SearchAdsParserHandler(){

	}
	
	public ArrayList<SearchAdsModel> getParseDataByModel(String responce){
		int tagName = 0;
		SearchAdsModel iModel = null;
		ArrayList<SearchAdsModel> arr_adsList= new ArrayList<SearchAdsModel>();

		try {

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new StringReader(responce));
			int eventType = parser.getEventType();
		
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("post")) {
						iModel = new SearchAdsModel();
					}else if (parser.getName().equals("id")) {
						tagName = SearchAdsModel.ID;
					}
					else if (parser.getName().equals("ads_title")) {
						tagName = SearchAdsModel.ADS_TITLE;
					}
					else if (parser.getName().equals("ads_desc")) {
						tagName = SearchAdsModel.ADS_DESCRIPTION;
					}
					else if (parser.getName().equals("city")) {
						tagName = SearchAdsModel.CITY;
					}
					else if (parser.getName().equals("category_id")) {
						tagName = SearchAdsModel.CATEGORY_ID;
					}
					else if (parser.getName().equals("status")) {
						tagName = SearchAdsModel.STATUS;
					}
					else if (parser.getName().equals("creation_time")) {
						tagName = SearchAdsModel.CREATION_TIME;
					}
					else if (parser.getName().equals("update_time")) {
						tagName = SearchAdsModel.UPDATE_TIME;
					}
					else if (parser.getName().equals("city-name")) {
						tagName = SearchAdsModel.CITY_NAME;
					}
					else if (parser.getName().equals("newspaper_name")) {
						tagName = SearchAdsModel.NEWS_PAPER_NAME;
					}
				}
				if (eventType == XmlPullParser.TEXT) {
					switch (tagName) {
					case SearchAdsModel.ID:
						iModel.setId(parser.getText());
						break;
					case SearchAdsModel.ADS_TITLE:
						iModel.setAdsTitle(parser.getText());
						break;
					case SearchAdsModel.ADS_DESCRIPTION:
						iModel.setAdsDescription(parser.getText());
						break;
					case SearchAdsModel.CITY:
						iModel.setCity(parser.getText());
						break;
					case SearchAdsModel.CATEGORY_ID:
						iModel.setCategoryId(parser.getText());
						break;
					case SearchAdsModel.STATUS:
						iModel.setStatus(parser.getText());
						break;
					case SearchAdsModel.CREATION_TIME:
						iModel.setCreationTime(parser.getText());
						break;
					case SearchAdsModel.UPDATE_TIME:
						iModel.setUpdateTime(parser.getText());
						break;
					case SearchAdsModel.CITY_NAME:
						iModel.setCity(parser.getText());
						break;
					case SearchAdsModel.NEWS_PAPER_NAME:
						iModel.setNewspaperName(parser.getText());
						break;
					}
				}
				if (eventType == XmlPullParser.END_TAG) {
					if (parser.getName().equals("post")) {
						arr_adsList.add(iModel);
					}
				}
				eventType = parser.next();
			}

		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return arr_adsList;
	}
}
