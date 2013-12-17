package com.cnfa.db;

import java.util.ArrayList;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import com.cnfa.constant.Constant;
import com.cnfa.model.CategoryModel;
import com.cnfa.model.CityListModel;
import com.cnfa.model.ContactUsFeedbackModel;
import com.cnfa.model.DbUpdate;
import com.cnfa.model.NewsPaperModel;
import com.cnfa.model.PrivacyModel;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.model.TermsOfUseModel;

public class DbSync {
	static SQLiteDatabase db = null;

	public static boolean saveNewspaperdata(Context context,
			ArrayList<NewsPaperModel> newsPaperArraylist) {
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		boolean b = false;
		try {
			for (int i = 0; i < newsPaperArraylist.size(); i++) {
				String id = newsPaperArraylist.get(i).getId();
				String title = newsPaperArraylist.get(i).getTitle();
				String logourl = newsPaperArraylist.get(i).getLogoUrl();
				String lastUpdatedtime = newsPaperArraylist.get(i)
						.getLastUpdateTime();
				String imagename = newsPaperArraylist.get(i).getImage();

				ContentValues initialValues = new ContentValues();
				initialValues.put("id", id);
				initialValues.put("title", title);
				initialValues.put("logourl", logourl);
				initialValues.put("lastupdatedtime", lastUpdatedtime);
				initialValues.put("imagename", imagename);
				db.insert("newspaper", null, initialValues);
				b = true;
			}

		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}

	public static boolean saveNewspaperCitylistdata(Context context,
			ArrayList<NewsPaperModel> newsPaperArraylist, String cityid) {
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		boolean b = false;
		try {
			for (int i = 0; i < newsPaperArraylist.size(); i++) {
				String id = newsPaperArraylist.get(i).getId();
				String title = newsPaperArraylist.get(i).getTitle();
				String logourl = newsPaperArraylist.get(i).getLogoUrl();
				String lastUpdatedtime = newsPaperArraylist.get(i)
						.getLastUpdateTime();
				String imagename = newsPaperArraylist.get(i).getImage();

				ContentValues initialValues = new ContentValues();
				initialValues.put("id", id);
				initialValues.put("title", title);
				initialValues.put("logourl", logourl);
				initialValues.put("lastupdatedtime", lastUpdatedtime);
				initialValues.put("imagename", imagename);
				initialValues.put("cityid", cityid);
				db.insert("newspapercitylist", null, initialValues);
				b = true;
			}

		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}

	public static boolean saveCategorydata(Context context,
			ArrayList<CategoryModel> list) {
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		boolean b = false;
		try {
			for (int i = 0; i < list.size(); i++) {
				String id = list.get(i).getId();
				String category = list.get(i).getCategory();
				String logourl = list.get(i).getLogoUrl();
				String lastUpdatedtime = list.get(i).getUpdate_time();
				String imagename = list.get(i).getImageName();
				String totalads = list.get(i).getTotal_ads();

				ContentValues initialValues = new ContentValues();
				initialValues.put("id", id);
				initialValues.put("categoryname", category);
				initialValues.put("logourl", logourl);
				initialValues.put("updatedtime", lastUpdatedtime);
				initialValues.put("imagename", imagename);
				initialValues.put("totalads", totalads);
				db.insert("categorytable", null, initialValues);
				b = true;
			}

		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}

	public static boolean saveCitydata(Context context,
			ArrayList<CityListModel> cityArraylist) {
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		boolean b = false;
		try {
			for (int i = 0; i < cityArraylist.size(); i++) {
				String id = cityArraylist.get(i).getId();
				String cityname = cityArraylist.get(i).getCityname();
				String status = cityArraylist.get(i).getStatus();
				String lastUpdatedtime = cityArraylist.get(i)
						.getLastUpdateTime();
				String province = cityArraylist.get(i).getProvince();

				ContentValues initialValues = new ContentValues();
				initialValues.put("id", id);
				initialValues.put("city_name", cityname);
				initialValues.put("status", status);
				initialValues.put("updated_time", lastUpdatedtime);
				initialValues.put("province", province);
				db.insert("citylisttable", null, initialValues);
				b = true;
			}

		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}

	public static boolean saveAboutUsdata(Context context,
			ArrayList<ContactUsFeedbackModel> aboutUsArraylist, String serviceName) {
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		boolean b = false;
		try {
			for (int i = 0; i < aboutUsArraylist.size(); i++) {
				String content = aboutUsArraylist.get(i).getContent();
				String lastUpdatedtime = aboutUsArraylist.get(i)
						.getLastUpdateTime();

				ContentValues initialValues = new ContentValues();
				initialValues.put("servicename", serviceName);
				initialValues.put("content", content);
				initialValues.put("update_time", lastUpdatedtime);
				db.insert("aboutustable", null, initialValues);
				b = true;
			}

		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}

	public static boolean savePrivacydata(Context context,
			ArrayList<PrivacyModel> privacyArraylist, String serviceName) {
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		boolean b = false;
		try {
			for (int i = 0; i < privacyArraylist.size(); i++) {
				String content = privacyArraylist.get(i).getContent();
				String lastUpdatedtime = privacyArraylist.get(i)
						.getLastUpdateTime();

				ContentValues initialValues = new ContentValues();
				initialValues.put("servicename", serviceName);
				initialValues.put("content", content);
				initialValues.put("update_time", lastUpdatedtime);
				db.insert("aboutustable", null, initialValues);
				b = true;
			}

		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}

	public static boolean saveTermsandconditiondata(Context context,
			ArrayList<TermsOfUseModel> termsArraylist, String serviceName) {
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		boolean b = false;
		try {
			for (int i = 0; i < termsArraylist.size(); i++) {
				String content = termsArraylist.get(i).getContent();
				String lastUpdatedtime = termsArraylist.get(i)
						.getLastUpdateTime();

				ContentValues initialValues = new ContentValues();
				initialValues.put("servicename", serviceName);
				initialValues.put("content", content);
				initialValues.put("update_time", lastUpdatedtime);
				db.insert("aboutustable", null, initialValues);
				b = true;
			}

		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}

	public static ArrayList<DbUpdate> getLastUpdatedTime(Context context,
			String tableName) {
		ArrayList<DbUpdate> list = new ArrayList<DbUpdate>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from " + tableName, null);
			if (cursor.moveToFirst()) {
				do {
					DbUpdate dbupdate = new DbUpdate();
					dbupdate.setId(cursor.getString(0));
					dbupdate.setLastUpdatedTime(cursor.getString(3));
					list.add(dbupdate);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static ArrayList<NewsPaperModel> getNewspaperlocalData(
			Context context, String tableName) {
		ArrayList<NewsPaperModel> list = new ArrayList<NewsPaperModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from " + tableName, null);
			if (cursor.moveToFirst()) {
				do {
					NewsPaperModel newspapermodel = new NewsPaperModel();
					newspapermodel.setId(cursor.getString(0));
					newspapermodel.setTitle(cursor.getString(1));
					newspapermodel.setLogoUrl(cursor.getString(2));
					newspapermodel.setLastUpdateTime(cursor.getString(3));
					newspapermodel.setImage(cursor.getString(4));
					byte[] byteArray = cursor.getBlob(5);
					if(byteArray!=null){
					Bitmap bm = BitmapFactory.decodeByteArray(byteArray, 0,
							byteArray.length);
					newspapermodel.setImageBitmap(bm);
					}
					else
						newspapermodel.setImageBitmap(null);

					list.add(newspapermodel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static ArrayList<NewsPaperModel> getCityListNewspaperlocalData(
			Context context, String tableName, String cityId) {
		ArrayList<NewsPaperModel> list = new ArrayList<NewsPaperModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from " + tableName
					+ " where cityid = '" + cityId + "'", null);
			if (cursor.moveToFirst()) {
				do {
					NewsPaperModel newspapermodel = new NewsPaperModel();
					newspapermodel.setId(cursor.getString(0));
					newspapermodel.setTitle(cursor.getString(1));
					newspapermodel.setLogoUrl(cursor.getString(2));
					newspapermodel.setLastUpdateTime(cursor.getString(3));
					newspapermodel.setImage(cursor.getString(4));
					byte[] byteArray = cursor.getBlob(5);
					Bitmap bm = BitmapFactory.decodeByteArray(byteArray, 0,
							byteArray.length);
					newspapermodel.setImageBitmap(bm);
					list.add(newspapermodel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static ArrayList<CategoryModel> getCategorylocalData(
			Context context, String tableName) {
		ArrayList<CategoryModel> list = new ArrayList<CategoryModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from " + tableName, null);
			if (cursor.moveToFirst()) {
				do {
					CategoryModel categorymodel = new CategoryModel();
					categorymodel.setId(cursor.getString(0));
					categorymodel.setCategory(cursor.getString(1));
					categorymodel.setLogoUrl(cursor.getString(2));
					categorymodel.setImageName(cursor.getString(3));
					categorymodel.setUpdate_time(cursor.getString(4));
					byte[] byteArray = cursor.getBlob(5);
					categorymodel.setTotal_ads(cursor.getString(6));
					if(byteArray != null){
					Bitmap bm = BitmapFactory.decodeByteArray(byteArray, 0,
							byteArray.length);
					categorymodel.setBitmap(bm);
					}
					list.add(categorymodel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static ArrayList<ContactUsFeedbackModel> getAboutUslocalData(Context context,
			String tableName, String serviceName) {
		ArrayList<ContactUsFeedbackModel> list = new ArrayList<ContactUsFeedbackModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from " + tableName
					+ " where servicename='" + serviceName + "'", null);
			if (cursor.moveToFirst()) {
				do {
					ContactUsFeedbackModel aboutusModel = new ContactUsFeedbackModel();
					aboutusModel.setContent(cursor.getString(1));
					aboutusModel.setLastUpdateTime(cursor.getString(2));
					list.add(aboutusModel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static ArrayList<PrivacyModel> getPrivacylocalData(Context context,
			String tableName, String serviceName) {
		ArrayList<PrivacyModel> list = new ArrayList<PrivacyModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from " + tableName
					+ " where servicename='" + serviceName + "'", null);
			if (cursor.moveToFirst()) {
				do {
					PrivacyModel privacyModel = new PrivacyModel();
					privacyModel.setContent(cursor.getString(1));
					privacyModel.setLastUpdateTime(cursor.getString(2));
					list.add(privacyModel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static ArrayList<TermsOfUseModel> getTermslocalData(Context context,
			String tableName, String serviceName) {
		ArrayList<TermsOfUseModel> list = new ArrayList<TermsOfUseModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from " + tableName
					+ " where servicename='" + serviceName + "'", null);
			if (cursor.moveToFirst()) {
				do {
					TermsOfUseModel termsModel = new TermsOfUseModel();
					termsModel.setContent(cursor.getString(1));
					termsModel.setLastUpdateTime(cursor.getString(2));
					list.add(termsModel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static ArrayList<CityListModel> getCitylistlocalData(
			Context context, String tableName) {
		ArrayList<CityListModel> list = new ArrayList<CityListModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from " + tableName, null);
			if (cursor.moveToFirst()) {
				do {
					CityListModel citylistmodel = new CityListModel();
					citylistmodel.setId(cursor.getString(0));
					citylistmodel.setCityname(cursor.getString(1));
					citylistmodel.setStatus(cursor.getString(2));
					citylistmodel.setLastUpdateTime(cursor.getString(3));
					citylistmodel.setProvince(cursor.getString(4));
					list.add(citylistmodel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static boolean deleteRecord(Context context, String tableName) {
		boolean b = false;
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			db.execSQL("delete from " + tableName);
			b = true;
		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}

		return b;
	}
	

	public static boolean syncBitmap(Context context, String tableName,
			String id, byte[] imgByte) {
		boolean b = false;
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		String where = "id='" + id + "'";
		try {
			ContentValues initialValues = new ContentValues();
			initialValues.put("imagebitmap", imgByte);
			db.update(tableName, initialValues, where, null);
			b = true;
		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}

	public static boolean saveFavoritedata(Context context, String id,
			String adstitle, String description, String city,
			String categoryid, String status, String creationtime,
			String updatetime, String cityname, String newspapername) {
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		boolean b = false;
		try {
			ContentValues initialValues = new ContentValues();
			initialValues.put("id", id);
			initialValues.put("title", adstitle);
			initialValues.put("description", description);
			initialValues.put("city", city);
			initialValues.put("categoryid", categoryid);
			initialValues.put("status", status);
			initialValues.put("creationtime", creationtime);
			initialValues.put("updatetime", updatetime);
			initialValues.put("cityname", cityname);
			initialValues.put("newspapername", newspapername);
			db.insert("favoritetable", null, initialValues);
			b = true;

		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}
		return b;
	}
	
	public static boolean deleteFavoriteRecord(Context context, String tableName, String id) {
		boolean b = false;
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			db.execSQL("delete from " + tableName + " where id='"+id+"'");
			b = true;
		} catch (Exception e) {
			b = false;
			e.printStackTrace();
		} finally {
			db.close();
		}

		return b;
	}

	public static int isFavouriteAvailable(Context context, String id) {
		int check = 0;
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery(
					"select * from favoritetable where id ='" + id + "'", null);
			check = cursor.getCount();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return check;
	}
	
	public static ArrayList<SearchAdsModel> getFavoritelocalData(
			Context context) {
		ArrayList<SearchAdsModel> list = new ArrayList<SearchAdsModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		try {
			Cursor cursor = db.rawQuery("select * from favoritetable", null);
			if (cursor.moveToFirst()) {
				do {
					SearchAdsModel searchAdsmodel = new SearchAdsModel();
					searchAdsmodel.setId(cursor.getString(0));
					searchAdsmodel.setAdsTitle(cursor.getString(1));
					searchAdsmodel.setAdsDescription(cursor.getString(2));
					searchAdsmodel.setCity(cursor.getString(3));
					searchAdsmodel.setCategoryId(cursor.getString(4));
					searchAdsmodel.setStatus(cursor.getString(5));
					searchAdsmodel.setCreationTime(cursor.getString(6));
					searchAdsmodel.setUpdateTime(cursor.getString(7));
					searchAdsmodel.setCityName(cursor.getString(8));
					searchAdsmodel.setNewspaperName(cursor.getString(9));
					list.add(searchAdsmodel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}

	public static ArrayList<SearchAdsModel> getSearchInFavoritedata(
			Context context,String searchWord) {
		ArrayList<SearchAdsModel> list = new ArrayList<SearchAdsModel>();
		db = SQLiteDatabase.openDatabase(Constant.getDB_PATH(context), null,
				SQLiteDatabase.OPEN_READWRITE);
		String selection="where title like '%"+searchWord+"%' OR description like '%"+searchWord+"%' OR city like '%"+searchWord+"%'";
		try {
			Cursor cursor = db.rawQuery("select * from favoritetable "+selection, null);
			if (cursor.moveToFirst()) {
				String name[]=cursor.getColumnNames();
				do {
					SearchAdsModel searchAdsmodel = new SearchAdsModel();
					searchAdsmodel.setId(cursor.getString(0));
					searchAdsmodel.setAdsTitle(cursor.getString(1));
					searchAdsmodel.setAdsDescription(cursor.getString(2));
					searchAdsmodel.setCity(cursor.getString(3));
					searchAdsmodel.setCategoryId(cursor.getString(4));
					searchAdsmodel.setStatus(cursor.getString(5));
					searchAdsmodel.setCreationTime(cursor.getString(6));
					searchAdsmodel.setUpdateTime(cursor.getString(7));
					searchAdsmodel.setCityName(cursor.getString(8));
					searchAdsmodel.setNewspaperName(cursor.getString(9));
					list.add(searchAdsmodel);
				} while (cursor.moveToNext());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return list;
	}
}
