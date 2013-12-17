package com.cnfa.parser;




import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.cnfa.model.CategoryModel;
import com.cnfa.model.CityListModel;

public class NewspaperToCategoryParserHandler{
//	GetSetModel iModel = null;
//	GetSetModel.ITEM _item;
	public NewspaperToCategoryParserHandler(){

	} 
	
	public ArrayList<CategoryModel> getParseDataByModel(String responce){
		int tagName = 0;
		CategoryModel iModel = null;
		ArrayList<CategoryModel> arr_category= new ArrayList<CategoryModel>();

		try {

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new StringReader(responce));
			int eventType = parser.getEventType();
		
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("post")) {
						iModel = new CategoryModel();
					}else if (parser.getName().equals("id")) {
						tagName = CategoryModel.ID;
					}
					else if (parser.getName().equals("total_ads")) {
						tagName = CategoryModel.TOTAL_ADS;
					}
					else if (parser.getName().equals("category")) {
						tagName = CategoryModel.CATEGORY;
					}
					else if (parser.getName().equals("logo")) {
						tagName = CategoryModel.LOGO_URL;
					}
					else if (parser.getName().equals("image")) {
						tagName = CategoryModel.IMAGE_NAME;
					}
					else if (parser.getName().equals("update_time")) {
						tagName = CategoryModel.UPDATE_TIME;
					}
					
				}
				if (eventType == XmlPullParser.TEXT) {
					switch (tagName) {
					case CityListModel.ID:
						iModel.setId(parser.getText());
						break;
					case CategoryModel.TOTAL_ADS:
						iModel.setTotal_ads(parser.getText());
						break;
					case CategoryModel.CATEGORY:
						iModel.setCategory(parser.getText());
						break;
					case CategoryModel.LOGO_URL:
						iModel.setLogoUrl(parser.getText());
						break;
					case CategoryModel.IMAGE_NAME:
						iModel.setImageName(parser.getText());
						break;
					case CategoryModel.UPDATE_TIME:
						iModel.setUpdate_time(parser.getText());
						break;
					
					}
				}
				if (eventType == XmlPullParser.END_TAG) {
					if (parser.getName().equals("post")) {
						arr_category.add(iModel);
					}
				}
				eventType = parser.next();
			}

		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return arr_category;
	}
}
