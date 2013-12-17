package com.cnfa.Activity;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
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
import com.cnfa.parser.NewspaperParserHandler;
import com.cnfa.parser.NewspaperToCategoryParserHandler;
import com.cnfa.parser.SearchAdsParserHandler;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.Utility;

public class NewspaperActivity extends TabbarActivity {
	private ListView listview;
	private MySearchListAdapter myadapter;
	private ArrayList<String> arrlist = new ArrayList<String>();
	private static final int PROGRESS_DIALOG = 0;
	private InputStream in = null;
	private ArrayList<NewsPaperModel> newsPaperArraylist = new ArrayList<NewsPaperModel>();
	private ArrayList<SearchAdsModel> searchAdsArraylist = new ArrayList<SearchAdsModel>();
	public static ArrayList<CategoryModel> categoryArraylist = new ArrayList<CategoryModel>();
	private EditText edSearch;
	private ImageView btnSearch;
	public String _newsPaper, _id;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.newspaper);

		edSearch = (EditText) findViewById(R.id.edsearch);
		btnSearch = (ImageView) findViewById(R.id.btnsearch);
		listview = (ListView) findViewById(R.id.newspaperlist);

		Utility.initFonts(getApplicationContext());

		edSearch.setTypeface(Utility.setRegularFont(getApplicationContext()));

		btnSearch.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {

				if (edSearch.getText().toString().length() > 0) {
					Intent intent = new Intent(NewspaperActivity.this,
							SearchAdsActivity.class);
//					intent.putExtra("newspapername", _newsPaper);
//					intent.putExtra("categoryname", "####");
					intent.putExtra("ACTIVITY_NAME", Constant.ACTIVITY_NEWS);
					intent.putExtra("SEARCH_WORD", edSearch.getText()
							.toString());
					startActivity(intent);
				}

			}
		});

		DBAdapter dbAdapter = DBAdapter
				.getDBAdapterInstance(getApplicationContext());
		try {
			dbAdapter.createDataBase();
		} catch (IOException e) {
			e.printStackTrace();
		}

		if (Utility.isOnline(getApplicationContext())) {
			new newsPaperTask(Constant.NEWS_PAPER_URL).execute();

		} else {
			Constant.showMsg(getApplicationContext(),
					Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);
			new newsPaperLoadLocalTask().execute();

		}
	}

	public class newsPaperLoadLocalTask extends
			AsyncTask<String, Integer, String> {
		ArrayList<NewsPaperModel> listLocalData = null;

		protected void onPreExecute() {
			CustomProgressDialog.showProgressDialog(NewspaperActivity.this, "",
					true);
		}

		@Override
		protected String doInBackground(String... params) {
			listLocalData = new ArrayList<NewsPaperModel>();
			listLocalData = DbSync.getNewspaperlocalData(
					getApplicationContext(), "newspaper");
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			CustomProgressDialog.removeDialog();
			myadapter = new MySearchListAdapter(NewspaperActivity.this,
					listLocalData);
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
							.getId(), list.get(position).getTitle()).execute();

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

		public newsPaperTask(String url) {
			// TODO Auto-generated constructor stub
			_url = url;
		}

		protected void onPreExecute() {
			// showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(NewspaperActivity.this, "",
					true);

		}

		@Override
		protected String doInBackground(String... params) {
			in = HttpConnection.connect(_url);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);
				NewspaperParserHandler newsPaperparserHandler = new NewspaperParserHandler();
				newsPaperArraylist = newsPaperparserHandler
						.getParseDataByModel(res);
			}

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			CustomProgressDialog.removeDialog();
			ArrayList<NewsPaperModel> listLocalData = new ArrayList<NewsPaperModel>();
			listLocalData = DbSync.getNewspaperlocalData(
					getApplicationContext(), "newspaper");
			int check_for_deletion = 0;

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
							getApplicationContext(), "newspaper");
					boolean b = false;
					b = DbSync.saveNewspaperdata(getApplicationContext(),
							newsPaperArraylist);
					newsPaperArraylist.clear();
					newsPaperArraylist = listLocalData;
				}
			} else {
				/*
				 * save recard in local
				 */
				boolean b = false;
				b = DbSync.saveNewspaperdata(getApplicationContext(),
						newsPaperArraylist);

			}
			if (listLocalData.size() > 0) {
				newsPaperArraylist.clear();
				newsPaperArraylist = listLocalData;
			}
			myadapter = new MySearchListAdapter(NewspaperActivity.this,
					newsPaperArraylist);
			listview.setAdapter(myadapter);

			if (newsPaperArraylist.size() > 0)
				new ImageDownloadAsync("newspaper").execute("Start");
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
						if (byteArrayImage != null)
							DbSync.syncBitmap(getApplicationContext(),
									tableName, newsPaperArraylist.get(i)
											.getId(), byteArrayImage);
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
			myadapter = new MySearchListAdapter(NewspaperActivity.this,
					newsPaperArraylist);
			listview.setAdapter(myadapter);
		}
	}

	/*
	 * Task for getting category list
	 */

	public class categoryListTask extends AsyncTask<String, Integer, String> {
		public String _url;

		public categoryListTask(String url, String newspaperID,
				String newsPaperName) {
			// TODO Auto-generated constructor stub
			_url = url;
			_newsPaper = newsPaperName;
			_id = newspaperID;
		}

		protected void onPreExecute() {
			// showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(NewspaperActivity.this, "",
					true);

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
			// check for updation
			ArrayList<CategoryModel> listLocalData = new ArrayList<CategoryModel>();
			listLocalData = DbSync.getCategorylocalData(
					getApplicationContext(), "categorytable");

			int check_for_deletion = 0;

			/*
			 * if record available in local data base then checking last updated
			 * time
			 */

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
				/*
				 * save recard in local
				 */
				boolean b = false;
				b = DbSync.saveCategorydata(getApplicationContext(),
						categoryArraylist);

			}
			if (listLocalData.size() > 0) {
				categoryArraylist.clear();
				categoryArraylist = listLocalData;
				CustomProgressDialog.removeDialog();
				Intent intent = new Intent(getApplicationContext(),
						CategoryActivity.class);
				//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				intent.putExtra("newspaperid", _id);
				intent.putExtra("ACTIVITY_NAME", Constant.ACTIVITY_NEWS);
				intent.putExtra("newspapername", _newsPaper);
				startActivity(intent);
			} else {
				if (categoryArraylist.size() > 0)
					new CategoryImageDownloadAsync().execute("Start");
			}

			// dismissDialog(PROGRESS_DIALOG);

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
			// showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(NewspaperActivity.this, "",
					true);

		}

		@Override
		protected String doInBackground(String... params) {
			in = HttpConnection.connect(_url + _searchstring);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);
				SearchAdsParserHandler searchAdsparserHandler = new SearchAdsParserHandler();
				searchAdsArraylist = searchAdsparserHandler
						.getParseDataByModel(res);
			}

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			// dismissDialog(PROGRESS_DIALOG);
			CustomProgressDialog.removeDialog();

			// check for updation

			Intent intent = new Intent(getApplicationContext(),
					SearchAdsActivity.class);
			//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			intent.putExtra("searchads", searchAdsArraylist);
			intent.putExtra("newspapername", "搜索关键词:" + _searchstring);
			intent.putExtra("ACTIVITY_NAME", Constant.ACTIVITY_NEWS);

			startActivity(intent);
			overridePendingTransition(R.anim.slide_in_left,
					R.anim.slide_out_left);

		}
	}

	private class CategoryImageDownloadAsync extends
			AsyncTask<String, Integer, String> {
		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			// showDialog(PROGRESS_DIALOG);

		}

		@Override
		protected String doInBackground(String... params) {
			String url = params[0];
			Log.i("", url);

			for (int i = 0; i < categoryArraylist.size(); i++) {
				CategoryModel gdet = categoryArraylist.get(i);
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
					gdet.setBitmap(bm);
					try {
						ByteArrayOutputStream boas = new ByteArrayOutputStream();
						bm.compress(Bitmap.CompressFormat.JPEG, 100, boas);
						byte[] byteArrayImage = boas.toByteArray();
						DbSync.syncBitmap(getApplicationContext(),
								"categorytable", categoryArraylist.get(i)
										.getId(), byteArrayImage);
					} catch (Exception e) {
						e.printStackTrace();
					}
					categoryArraylist.set(i, gdet);
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
			// myadapter.notifyDataSetChanged();
		}

		@Override
		protected void onPostExecute(String result) {
			super.onPostExecute(result);
			// dismissDialog(PROGRESS_DIALOG);
			CustomProgressDialog.removeDialog();

			Intent intent = new Intent(getApplicationContext(),
					CategoryActivity.class);
			intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			intent.putExtra("newspaperid", _id);
			intent.putExtra("ACTIVITY_NAME", Constant.ACTIVITY_NEWS);
			intent.putExtra("newspapername", _newsPaper);
			startActivity(intent);
			/*
			 * overridePendingTransition(R.anim.slide_in_left,
			 * R.anim.slide_out_left);
			 */

		}
	}

	/*
	 * For local search
	 */

	@SuppressLint("DefaultLocale")
	public ArrayList<NewsPaperModel> performSearch(String searchString) {
		ArrayList<NewsPaperModel> filterData = new ArrayList<NewsPaperModel>();
		for (int i = 0; i < newsPaperArraylist.size(); i++) {
			if (newsPaperArraylist.get(i).getTitle().toLowerCase()
					.contains(searchString.toLowerCase())) {
				filterData.add(newsPaperArraylist.get(i));
			}
		}
		return filterData;
	}

	@Override
	protected void onResume() {
		super.onResume();
//		layout_city.invalidate();
//		layout_city.refreshDrawableState();
		layout_newspaper.setBackgroundResource(R.drawable.menuselector);
		layout_img_newspaper
				.setBackgroundResource(R.drawable.newspapericonactive);
		return;
	}

}