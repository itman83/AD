package com.cnfa.Activity;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.cnfa.R;
import com.cnfa.connection.HttpConnection;
import com.cnfa.constant.Constant;
import com.cnfa.db.DBAdapter;
import com.cnfa.db.DbSync;
import com.cnfa.model.CategoryModel;
import com.cnfa.model.NewsPaperModel;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.parser.NewspaperCitylistParserHandler;
import com.cnfa.parser.NewspaperToCategoryParserHandler;
import com.cnfa.parser.SearchAdsParserHandler;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.Utility;

/**
 * @author Sidharth
 * 
 */
public class CityListToNewspaperActivity extends TabbarActivity {
	private ListView listview;
	private MySearchListAdapter myadapter;
	private ArrayList<String> arrlist = new ArrayList<String>();
	private static final int PROGRESS_DIALOG = 0;
	private InputStream in = null;
	private ArrayList<NewsPaperModel> newsPaperArraylist = new ArrayList<NewsPaperModel>();
	private ArrayList<CategoryModel> categoryArraylist = new ArrayList<CategoryModel>();
	private ArrayList<SearchAdsModel> searchAdsArraylist = new ArrayList<SearchAdsModel>();

	private String _cityId = "";
	private String _cityName = "";
	private TextView txtCity,btntext;
	private EditText edSearch;
	private ImageView btnSearch;
	Context c;
	//String classname=null;
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.citylistnewspaper);
		layout_city.setBackgroundResource(R.drawable.menuselector);
		layout_img_city.setBackgroundResource(R.drawable.cityiconactive);
		// setContentView(R.layout.arrowspage);
	/*	getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
*/
//		classname=getClass().getSimpleName();
//		System.out.println(classname);

//		SCREEN = 1; 
//		if(SCREEN == 1){
//			layout_newspaper.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
//			layout_img_newspaper.setBackgroundDrawable(getResources().getDrawable(R.drawable.newspapericonactive));
//		}
//		if(SCREEN == 2){
//			layout_city.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
//			layout_img_city.setBackgroundDrawable(getResources().getDrawable(R.drawable.cityiconactive));
//		}
//		if(SCREEN == 3){
//			layout_favourite.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
//			layout_img_favourite.setBackgroundDrawable(getResources().getDrawable(R.drawable.favouriteiconactive));
//		}
//		if(SCREEN == 4){
//			layout_aboutus.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
//			layout_img_aboutus.setBackgroundDrawable(getResources().getDrawable(R.drawable.aboutusiconactive));
//		}
//		
		/*if(SCREEN == 1)
			layout_newspaper.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
		if(SCREEN == 2)
			layout_city.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
		if(SCREEN == 3)
			layout_favourite.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
		if(SCREEN == 4)
			layout_aboutus.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
	*/	
		
		listview = (ListView) findViewById(R.id.newspaperlist);
		txtCity = (TextView) findViewById(R.id.textcity);

		edSearch = (EditText) findViewById(R.id.edsearch);
		btnSearch = (ImageView) findViewById(R.id.btnsearch);
		
		btntext = (TextView)findViewById(R.id.textcount2);

		_cityId = getIntent().getStringExtra("cityid");
		_cityName = getIntent().getStringExtra("cityname");
		Constant.CITY_ID=_cityId;

		if (_cityName != null)
			txtCity.setText( _cityName); 
//			txtCity.setTypeface(Utility.setRegularFont(getApplicationContext()));
   
//			edSearch.setTypeface(Utility.setRegularFont(getApplicationContext()));
//			btntext.setTypeface(Utility.setRegularFont(getApplicationContext()));

			btnSearch.setOnClickListener(new OnClickListener() {

			@Override   
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (edSearch.getText().toString().length() > 0) {
					Intent intent = new Intent(CityListToNewspaperActivity.this,
							SearchAdsActivity.class);
					intent.putExtra("ACTIVITY_NAME",Constant.ACTIVITY_CITY);
					intent.putExtra("SEARCH_WORD", edSearch.getText()
							.toString());
					startActivity(intent);
				}
//				if (edSearch.getText().toString().length() > 0)
//					new searchAdsTask(Constant.SEARCH_FROM_CITY_TO_NEWSPAPER,"action=searchbycity&city_id=" + _cityId
//							+ "&data=" + edSearch.getText().toString()).execute();   
//				else
//					Constant.showMsg(getApplicationContext(),
//							Constant.MSG_SEARCH_CONTENT);
			}
		});

		// Copy Database if it does not exist
		DBAdapter dbAdapter = DBAdapter
				.getDBAdapterInstance(getApplicationContext());
		try {
			dbAdapter.createDataBase();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if (Utility.isOnline(getApplicationContext())) {
			// if(newsPaperArraylist == null)
			new newsPaperTask(Constant.NEWSPAPER_CITY_LIST, _cityId).execute();
			/*
			 * else{ myadapter = new MySearchListAdapter(NewspaperActivity.this,
			 * newsPaperArraylist); listview.setAdapter(myadapter);
			 * 
			 * if (newsPaperArraylist.size() > 0 ) new
			 * ImageDownloadAsync("newspapercitylist").execute("Start");
			 * 
			 * }
			 */
		} else {
			Constant.showMsg(getApplicationContext(),
					Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);
			new newsPaperLoadLocalTask().execute();
		}
	}

	@Override
	protected void onResume() {
    super.onResume();
    c = CityListToNewspaperActivity.this;
    Constant.activity.add(c);
	   
	}
	public class newsPaperLoadLocalTask extends
			AsyncTask<String, Integer, String> {
		ArrayList<NewsPaperModel> listLocalData = null;

		protected void onPreExecute() {
			//showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(CityListToNewspaperActivity.this,"", true);
		}

		@Override
		protected String doInBackground(String... params) {
			listLocalData = new ArrayList<NewsPaperModel>();
			listLocalData = DbSync.getCityListNewspaperlocalData(
					getApplicationContext(), "newspapercitylist", _cityId);
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			//dismissDialog(PROGRESS_DIALOG);
			CustomProgressDialog.removeDialog();
			myadapter = new MySearchListAdapter(
					CityListToNewspaperActivity.this, listLocalData);
			listview.setAdapter(myadapter);

		}
	}

	public class MySearchListAdapter extends BaseAdapter {
		private final Activity context;
		ProgressDialog pd;
		String giftID;
		ArrayList<NewsPaperModel> list = new ArrayList<NewsPaperModel>();

		public MySearchListAdapter(Activity context,
				ArrayList<NewsPaperModel> description) {
			super();
			this.context = context;
			this.list = description;
		}

		@Override
		public View getView(final int position, View convertView,
				ViewGroup parent) {
			LayoutInflater inflater = context.getLayoutInflater();
			View rowView = inflater.inflate(R.layout.searchlistrow, null, true);
			TextView txtView = (TextView) rowView.findViewById(R.id.newstxt);
			final ImageView image = (ImageView) rowView
					.findViewById(R.id.rowimage);

			txtView.setText(list.get(position).getTitle());
			txtView.setTypeface(Utility.setRegularFont(getApplicationContext()));

			if (!(list.get(position).getImageBitmap() == null)) {
				Drawable d = new BitmapDrawable(context.getResources(), list
						.get(position).getImageBitmap());
				image.setBackgroundDrawable(d);
			} else {
				// image.setBackgroundResource(R.drawable.ic_launcher);
			}

			rowView.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					// finish();

					new categoryListTask(Constant.NEWSPAPER_TO_CATEGORY
							+ list.get(position).getId(), list.get(position)
							.getTitle(),list.get(position).getId()).execute();

				}
			});

			return rowView;
		}

		@Override
		public int getCount() {
			// TODO Auto-generated method stub
			return list.size();
		}

		@Override
		public Object getItem(int arg0) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public long getItemId(int arg0) {
			// TODO Auto-generated method stub
			return 0;
		}
	}

	public class newsPaperTask extends AsyncTask<String, Integer, String> {
		public String _url;
		public String _cityId;

		public newsPaperTask(String url, String cityID) {
			// TODO Auto-generated constructor stub
			_url = url;
			_cityId = cityID;
		}

		protected void onPreExecute() {
			//showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(CityListToNewspaperActivity.this,"", true);
		}

		@Override
		protected String doInBackground(String... params) {
			in = HttpConnection.connect(_url + _cityId);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);
				NewspaperCitylistParserHandler newsPaperparserHandler = new NewspaperCitylistParserHandler();
				newsPaperArraylist = newsPaperparserHandler
						.getParseDataByModel(res);
			}

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		@SuppressWarnings("unchecked")
		protected void onPostExecute(String result) {
			//dismissDialog(PROGRESS_DIALOG);
			CustomProgressDialog.removeDialog();
			// check for updation
			ArrayList<NewsPaperModel> listLocalData = new ArrayList<NewsPaperModel>();
			listLocalData = DbSync.getCityListNewspaperlocalData(
					getApplicationContext(), "newspapercitylist", _cityId);
			int check_for_deletion = 0;

			/*
			 * if record available in local data base then checking last updated
			 * time
			 */

			if (listLocalData.size() > 0) {
				if (listLocalData.size() > 0
						&& listLocalData.size() == newsPaperArraylist.size()) {
					for (int i = 0; i < newsPaperArraylist.size(); i++) {
						for (int j = 0; j < listLocalData.size(); j++) {
							if (newsPaperArraylist.get(i).getId()
									.equals(listLocalData.get(j).getId())) {
								if (!newsPaperArraylist
										.get(i)
										.getLastUpdateTime()
										.equals(listLocalData.get(j)
												.getLastUpdateTime())) {
									check_for_deletion = 1;
									break;
								}
							}

						}
					}
				} else
					check_for_deletion = 1;

				// remove all records
				if (check_for_deletion == 1) {
					boolean b_delete = DbSync.deleteRecord(
							getApplicationContext(), "newspapercitylist");
					boolean b = false;
					b = DbSync.saveNewspaperCitylistdata(
							getApplicationContext(), newsPaperArraylist,
							_cityId);
					newsPaperArraylist.clear();
					newsPaperArraylist = listLocalData;
				}
			} else {
				/*
				 * save recard in local
				 */
				boolean b = false;
				b = DbSync.saveNewspaperCitylistdata(getApplicationContext(),
						newsPaperArraylist, _cityId);

			}
			if (listLocalData.size() > 0) {
				newsPaperArraylist.clear();
				newsPaperArraylist = listLocalData;
			}

			myadapter = new MySearchListAdapter(
					CityListToNewspaperActivity.this, newsPaperArraylist);
			listview.setAdapter(myadapter);

			if (newsPaperArraylist.size() > 0)
				new ImageDownloadAsync("newspapercitylist").execute("Start");

		}

	}

	protected Dialog onCreateDialog(int id) {
		switch (id) {
		case PROGRESS_DIALOG:
			ProgressDialog progDialog = new ProgressDialog(this);
			progDialog.setMessage("Please Wait...");
			progDialog.setCancelable(false);
			progDialog.show();

			return progDialog;

		}
		return null;
	}

	private class ImageDownloadAsync extends AsyncTask<String, Integer, String> {
		private String tableName;

		public ImageDownloadAsync(String table) {
			// TODO Auto-generated constructor stub
			tableName = table;
		}

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
		}

		@Override
		protected String doInBackground(String... params) {
			String url = params[0];
			Log.i("", url);
			for (int i = 0; i < newsPaperArraylist.size(); i++) {
				NewsPaperModel gdet = newsPaperArraylist.get(i);
				URL urlimage;
				try {
					urlimage = new URL(gdet.getLogoUrl().replace(" ", "%20"));
					Bitmap bm = null;  
					try {
						bm = Utility.getImageBitmap(urlimage);
					} catch (FileNotFoundException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					gdet.setImageBitmap(bm);
					try {
						ByteArrayOutputStream boas = new ByteArrayOutputStream();
						bm.compress(Bitmap.CompressFormat.JPEG, 100, boas);
						byte[] byteArrayImage = boas.toByteArray();
						DbSync.syncBitmap(getApplicationContext(), tableName,
								newsPaperArraylist.get(i).getId(),
								byteArrayImage);
					} catch (Exception e) {
						e.printStackTrace();
					}
					newsPaperArraylist.set(i, gdet);
				} catch (MalformedURLException e) {
					e.printStackTrace();
				}
				publishProgress(0);
			}
			System.gc();
			return "Done";
		}

		@Override
		protected void onProgressUpdate(Integer... values) {
			super.onProgressUpdate(values);
			myadapter.notifyDataSetChanged();
		}

		@Override
		protected void onPostExecute(String result) {
			super.onPostExecute(result);
			myadapter = new MySearchListAdapter(
					CityListToNewspaperActivity.this, newsPaperArraylist);
			listview.setAdapter(myadapter);
		}
	}

	/*
	 * Task for getting category list
	 */

	public class categoryListTask extends AsyncTask<String, Integer, String> {
		public String _url;
		public String _newsPaper,_id;

		public categoryListTask(String url, String newsPaperName, String id) {
			// TODO Auto-generated constructor stub
			_url = url;
			_newsPaper = newsPaperName;
			_id = id;
		}

		protected void onPreExecute() {
			//showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(CityListToNewspaperActivity.this,"", true);
		}

		@Override
		protected String doInBackground(String... params) {
			in = HttpConnection.connect(_url);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);
				System.out.println("Response==> " + res);
				NewspaperToCategoryParserHandler newsPaperToCategoryparserHandler = new NewspaperToCategoryParserHandler();
				categoryArraylist = newsPaperToCategoryparserHandler
						.getParseDataByModel(res);
			}

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			//dismissDialog(PROGRESS_DIALOG);
			CustomProgressDialog.removeDialog();
			Intent intent = new Intent(getApplicationContext(),
					CategoryActivity.class);
			//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			/*intent.putExtra("categorydata", categoryArraylist);*/
			
			intent.putExtra("cityname", _cityName);
			intent.putExtra("newspapername", _newsPaper);
			intent.putExtra("newspaperid", _id);
			intent.putExtra("TAG_FOR_BOTTOMTEXT", "1");
			intent.putExtra("ACTIVITY_NAME",Constant.ACTIVITY_CITY);

			startActivity(intent);
			/*// check for updation
			ArrayList<CategoryModel> listLocalData = new ArrayList<CategoryModel>();
			listLocalData = DbSync.getCategorylocalData(
					getApplicationContext(), "categorytable");

			int check_for_deletion = 0;

			
			 * if record available in local data base then checking last updated
			 * time
			 

			if (listLocalData.size() > 0) {
				if (listLocalData.size() > 0
						&& listLocalData.size() == categoryArraylist.size()) {
					for (int i = 0; i < categoryArraylist.size(); i++) {
						for (int j = 0; j < listLocalData.size(); j++) {
							if (categoryArraylist.get(i).getId()
									.equals(listLocalData.get(j).getId())) {
								if (!categoryArraylist
										.get(i)
										.getUpdate_time()
										.equals(listLocalData.get(j)
												.getUpdate_time())) {
									check_for_deletion = 1;
									break;
								}
							}

						}
					}
				} else
					check_for_deletion = 1;

				// remove all records
				if (check_for_deletion == 1) {
					boolean b_delete = DbSync.deleteRecord(
							getApplicationContext(), "categorytable");
					boolean b = false;
					b = DbSync.saveCategorydata(getApplicationContext(),
							categoryArraylist);
					categoryArraylist.clear();
					categoryArraylist = listLocalData;
				}
			} else {
				
				 * save recard in local
				 
				boolean b = false;
				b = DbSync.saveCategorydata(getApplicationContext(),
						categoryArraylist);

			}
			if (listLocalData.size() > 0) {
				categoryArraylist.clear();
				categoryArraylist = listLocalData;
			}
			
			 * if (categoryArraylist.size() > 0 ) new
			 * ImageDownloadAsync().execute("Start");
			 

			if(NewspaperActivity.categoryArraylist != null)
				NewspaperActivity.categoryArraylist.clear();
			NewspaperActivity.categoryArraylist = categoryArraylist;
			
			Intent intent = new Intent(getApplicationContext(),
					CategoryActivity.class);
			//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			intent.putExtra("categorydata", categoryArraylist);
			
			intent.putExtra("cityname", _cityName);
			intent.putExtra("newspapername", _newsPaper);
			intent.putExtra("newspaperid", _id);
			intent.putExtra("TAG_FOR_BOTTOMTEXT", "1");
			intent.putExtra("ACTIVITY_NAME",Constant.ACTIVITY_CITY);

			startActivity(intent);
		
			overridePendingTransition(R.anim.slide_in_left,
					R.anim.slide_out_left);*/
		}
	}

	public class searchAdsTask extends AsyncTask<String, Integer, String> {
		public String _url, _searchstring;

		public searchAdsTask(String url, String searchString) {
			// TODO Auto-generated constructor stub
			_url = url;
			_searchstring = searchString;
		}

		protected void onPreExecute() {
			//showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(CityListToNewspaperActivity.this,"", true);
		}

		@Override
		protected String doInBackground(String... params) {
			in = HttpConnection.connect(_url + _searchstring);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);
				System.out.println(res);
				SearchAdsParserHandler searchAdsparserHandler = new SearchAdsParserHandler();
				searchAdsArraylist = searchAdsparserHandler
						.getParseDataByModel(res);
			}

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			//dismissDialog(PROGRESS_DIALOG);
			CustomProgressDialog.removeDialog();
			// check for updation

			Intent intent = new Intent(getApplicationContext(),
					SearchAdsActivity.class);
			//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			intent.putExtra("searchads", searchAdsArraylist);
			intent.putExtra("newspapername", "搜索关键词:"+_searchstring);
			startActivity(intent);
			overridePendingTransition(R.anim.slide_in_left,
					R.anim.slide_out_left);

		}
	}

	

//	@Override
//	protected void onResume() {
//	    super.onResume();
//	    layout_city.invalidate();
//	    layout_city.refreshDrawableState();
//	    layout_newspaper.setBackgroundResource(R.drawable.menuselector);
//		layout_img_newspaper.setBackgroundResource(R.drawable.cityiconactive);
//		
//		
//	    return;
//	}
//	@Override
//	protected void onResume() {
//	    super.onResume();
//	   
//	    layout_city.setBackgroundResource(R.drawable.menuselector);
//		layout_img_city.setBackgroundResource(R.drawable.cityiconactive);
//		return;
//	}
	
}