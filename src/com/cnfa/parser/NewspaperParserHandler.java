package com.cnfa.parser;




import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.cnfa.model.NewsPaperModel;

public class NewspaperParserHandler{
//	GetSetModel iModel = null;
//	GetSetModel.ITEM _item;
	public NewspaperParserHandler(){

	}
	
	public ArrayList<NewsPaperModel> getParseDataByModel(String responce){
		int tagName = 0;
		NewsPaperModel iModel = null;
		ArrayList<NewsPaperModel> arr_newspaper= new ArrayList<NewsPaperModel>();

		try {

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new StringReader(responce));
			int eventType = parser.getEventType();
		
			while (eventType != XmlPullParser.END_DOCUMENT) {
				if (eventType == XmlPullParser.START_TAG) {
					if (parser.getName().equals("post")) {
						iModel = new NewsPaperModel();
					}else if (parser.getName().equals("id")) {
						tagName = NewsPaperModel.ID;
					}
					else if (parser.getName().equals("new")) {
						tagName = NewsPaperModel.TITLE;
					}
					else if (parser.getName().equals("logo")) {
						tagName = NewsPaperModel.IMAGE_URL;
					}
					else if (parser.getName().equals("update_time")) {
						tagName = NewsPaperModel.LAST_UPDATED_TIME;
					}
					else if (parser.getName().equals("image")) {
						tagName = NewsPaperModel.IMAGE;
					}
				}
				if (eventType == XmlPullParser.TEXT) {
					switch (tagName) {
					case NewsPaperModel.ID:
						iModel.setId(parser.getText());
						break;
					case NewsPaperModel.TITLE:
						iModel.setTitle(parser.getText());
						break;
					case NewsPaperModel.IMAGE_URL:
						iModel.setLogoUrl(parser.getText());
						break;
					case NewsPaperModel.LAST_UPDATED_TIME:
						iModel.setLastUpdateTime(parser.getText());
						break;
					case NewsPaperModel.IMAGE:
						iModel.setImage(parser.getText());
						break;
					}
				}
				if (eventType == XmlPullParser.END_TAG) {
					if (parser.getName().equals("post")) {
						arr_newspaper.add(iModel);
					}
				}
				eventType = parser.next();
			}

		} catch (XmlPullParserException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return arr_newspaper;
	}
}
