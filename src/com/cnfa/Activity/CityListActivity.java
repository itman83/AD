package com.cnfa.Activity;

import java.io.InputStream;
import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.KeyEvent;
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
import com.cnfa.db.DbSync;
import com.cnfa.model.CityListModel;
import com.cnfa.model.NewsPaperModel;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.parser.CityNameParserHandler;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.Utility;

/**
 * @author Sidharth
 * 
 */
public class CityListActivity extends TabbarActivity {
	private ListView listview;
	private MySearchListAdapter myadapter;
	private ArrayList<String> arrlist = new ArrayList<String>();
//	private static final int PROGRESS_DIALOG = 0;
	private InputStream in = null;
	private ArrayList<SearchAdsModel> searchAdsArraylist = new ArrayList<SearchAdsModel>();
	ArrayList<CityListModel> arr_citynamelist= new ArrayList<CityListModel>();
	private ArrayList<NewsPaperModel> newsPaperArraylist = new ArrayList<NewsPaperModel>();
	private EditText edSearch;
	private ImageView btnSearch;
	final int RESULT_CLOSE_ALL=1234;
Context c;
	@SuppressWarnings("deprecation")
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.citylist);
		// setContentView(R.layout.citylist);
	/*	getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
*/
		
		

		
		listview = (ListView) findViewById(R.id.newspaperlist);
		edSearch = (EditText)findViewById(R.id.edsearch);
		btnSearch = (ImageView)findViewById(R.id.btnsearch);

		btnSearch.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				/*ArrayList<CityListModel> al2 = new ArrayList<CityListModel>();

				al2 = performSearch(edSearch.getText().toString());
				myadapter = new MySearchListAdapter(CityListActivity.this,
						al2);
				listview.setAdapter(myadapter);*/
				if (edSearch.getText().toString().length() > 0) {
					Intent intent = new Intent(CityListActivity.this,
							SearchAdsActivity.class);
					intent.putExtra("ACTIVITY_NAME",Constant.ACTIVITY_CITY);
					intent.putExtra("SEARCH_WORD", edSearch.getText()
							.toString());
					startActivity(intent);
					
				}
//				if(edSearch.getText().toString().length()>0)
//				new searchAdsTask(Constant.SEARCH_FROM_NEWSPAPER,edSearch.getText().toString()).execute();
//				else
//					Constant.showMsg(getApplicationContext(), Constant.MSG_SEARCH_CONTENT);
			}
		});
		
		
		
		if (Utility.isOnline(getApplicationContext())) {
			new cityListTask(Constant.CITY_LIST_URL).execute();
		} else{
			Constant.showMsg(getApplicationContext(),
					Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);
			new cityListLoadLocalTask().execute();
		}
		
	}
	
	
	
	public class cityListLoadLocalTask extends AsyncTask<String, Integer, String> {
		ArrayList<CityListModel> listLocalData = null;

		protected void onPreExecute() {
			//showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(CityListActivity.this,"", true);
		}

		@Override
		protected String doInBackground(String... params) {
			listLocalData = new ArrayList<CityListModel>();
			listLocalData = DbSync.getCitylistlocalData(getApplicationContext(),"citylisttable");
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			//dismissDialog(PROGRESS_DIALOG);
			CustomProgressDialog.removeDialog();
			myadapter = new MySearchListAdapter(CityListActivity.this,
					listLocalData);
			listview.setAdapter(myadapter);
			
		}
	}

	public class MySearchListAdapter extends BaseAdapter {
		private final Activity context;
		ProgressDialog pd;
		ArrayList<CityListModel> list = new ArrayList<CityListModel>();

		public MySearchListAdapter(Activity context,
				ArrayList<CityListModel> description) {
			super();
			this.context = context;
			this.list = description;
		}

		@Override
		public View getView(final int position, View convertView,
				ViewGroup parent) {
			LayoutInflater inflater = context.getLayoutInflater();
			View rowView = inflater.inflate(R.layout.citylistrow, null, true);
			TextView txtView = (TextView) rowView.findViewById(R.id.newstxt);
			TextView txtlefttext = (TextView) rowView.findViewById(R.id.rowilefttext);
			txtView.setText(list.get(position).getCityname());
			txtlefttext.setText(list.get(position).getProvince());
			txtView.setTypeface(Utility.setRegularFont(getApplicationContext()));
			txtlefttext.setTypeface(Utility.setRegularFont(getApplicationContext()));
			
			rowView.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View v) {
					Intent intent = new Intent(getApplicationContext(),
							CityListToNewspaperActivity.class);
				//	intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
					intent.putExtra("cityid", list.get(position).getId());
					intent.putExtra("cityname", list.get(position).getCityname());
					startActivity(intent);
					/*overridePendingTransition(R.anim.slide_in_left,
							R.anim.slide_out_left);
				*/	
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
		public Object getItem(int position) {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public long getItemId(int position) {
			// TODO Auto-generated method stub
			return 0;
		}
	}
	
	public class cityListTask extends AsyncTask<String, Integer, String> {
		public String _url;

		public cityListTask(String url) {
			// TODO Auto-generated constructor stub
			_url=url;
		}

		protected void onPreExecute() {
			//showDialog(PROGRESS_DIALOG);
			CustomProgressDialog.showProgressDialog(CityListActivity.this,"", true);
		}

		@Override
		protected String doInBackground(String... params) {
			in=HttpConnection.connect(_url);
			String res = null;
			if(in!=null){ 
			res=Utility.getString(in); 
			CityNameParserHandler newsPaperparserHandler = new CityNameParserHandler();
			arr_citynamelist = newsPaperparserHandler.getParseDataByModel(res);
			}
			
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			//dismissDialog(PROGRESS_DIALOG);
			CustomProgressDialog.removeDialog();
			//check for updation
			ArrayList<CityListModel> listLocalData = new ArrayList<CityListModel>();
			listLocalData = DbSync.getCitylistlocalData(getApplicationContext(),"citylisttable");
			int check_for_deletion = 0;
			
			/*
			 * if record available in local data base then checking last updated time
			 */
			
			if(listLocalData.size()>0){
				if(listLocalData.size()>0 && listLocalData.size() == arr_citynamelist.size()){
			for(int i = 0;i<arr_citynamelist.size();i++){
				for(int j = 0; j<listLocalData.size();j++){
				if(arr_citynamelist.get(i).getId().equals(listLocalData.get(j).getId())){
					if(!arr_citynamelist.get(i).getLastUpdateTime().equals(listLocalData.get(j).getLastUpdateTime())){
						check_for_deletion = 1;
						break;
					}
				}
					
				}
			}
				}
				else
					check_for_deletion = 1;
			
			//remove all records
			if(check_for_deletion == 1){
			boolean b_delete = DbSync.deleteRecord(getApplicationContext(),"citylisttable");
			boolean b = false;
			b = DbSync.saveCitydata(getApplicationContext(),arr_citynamelist);
			arr_citynamelist.clear();
			arr_citynamelist = listLocalData;
			}
			}
			else{
				/*
				 * save recard in local
				 */
				boolean b = false;
				b = DbSync.saveCitydata(getApplicationContext(),arr_citynamelist);
		
			}
			if(listLocalData.size()>0){
				arr_citynamelist.clear();
				arr_citynamelist = listLocalData;
			}
			
			
			
			if(arr_citynamelist.size()>0){
			myadapter = new MySearchListAdapter(CityListActivity.this, arr_citynamelist);
			listview.setAdapter(myadapter);
			}
			else
				Constant.showMsg(getApplicationContext(), Constant.MSG_CONTENT_NOT_AVAILABLE);
		      
		
		}
	}
	
	
	
//	public class searchAdsTask extends AsyncTask<String, Integer, String> {
//		public String _url, _searchstring;
//
//		public searchAdsTask(String url, String searchString) {
//			// TODO Auto-generated constructor stub
//			_url = url;
//			_searchstring = searchString;
//		}
//
//		protected void onPreExecute() {
//			//showDialog(PROGRESS_DIALOG);
//			CustomProgressDialog.showProgressDialog(CityListActivity.this,"", true);
//		}
//
//		@Override
//		protected String doInBackground(String... params) {
//			in = HttpConnection.connect(_url+_searchstring);
//			String res = null;
//			if (in != null) {
//				res = Utility.getString(in);
//				SearchAdsParserHandler searchAdsparserHandler = new SearchAdsParserHandler();
//				searchAdsArraylist = searchAdsparserHandler
//						.getParseDataByModel(res);
//			}
//
//			return null;
//		}
//
//		protected void onProgressUpdate(Integer... progress) {
//
//		}
//
//		protected void onPostExecute(String result) {
//			//dismissDialog(PROGRESS_DIALOG);
//			CustomProgressDialog.removeDialog();
//			//check for updation
//			
//			Intent intent = new Intent(getApplicationContext(),
//					SearchAdsActivity.class);
//			intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//			intent.putExtra("searchads", searchAdsArraylist);
//			intent.putExtra("newspapername", "搜索关键词:"+_searchstring);
//			startActivity(intent);
//			overridePendingTransition(R.anim.slide_in_left,
//					R.anim.slide_out_left);
//			
//		}
//	}

	
//	
//	protected Dialog onCreateDialog(int id) {
//		switch (id) {
//
//		case PROGRESS_DIALOG:
//			ProgressDialog progDialog = new ProgressDialog(this);
//			progDialog.setMessage("Please Wait...");
//			progDialog.setCancelable(false);
//			progDialog.show();
//
//			return progDialog;
//
//		}
//		return null;
//	}
	
	@SuppressLint("DefaultLocale")
	public ArrayList<CityListModel> performSearch(String searchString) {
		ArrayList<CityListModel> filterData = new ArrayList<CityListModel>();
		for (int i = 0; i < arr_citynamelist.size(); i++) {
			if (arr_citynamelist.get(i).getCityname().toLowerCase().contains(searchString.toLowerCase())) {
				filterData.add(arr_citynamelist.get(i));
			}
		}
		return filterData;
	}

	@Override
	protected void onResume() {
	    super.onResume();
	   c= CityListActivity.this;
	   Constant.activity.add(c);
	   
	    layout_city.setBackgroundResource(R.drawable.menuselector);
		layout_img_city.setBackgroundResource(R.drawable.cityiconactive);
		return;
	}
	
	@Override
	public void onBackPressed() {
		// TODO Auto-generated method stub
		super.onBackPressed();

	}
	
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if ((keyCode == KeyEvent.KEYCODE_BACK)) {
			AlertDialog.Builder builder = new AlertDialog.Builder(CityListActivity.this);
		    builder.setTitle("您确定要退出《凡人凡事》吗？");
		    builder.setPositiveButton("是", new DialogInterface.OnClickListener() {

		        public void onClick(DialogInterface dialog, int which) {
		            // Do nothing but close the dialog

		            dialog.dismiss();
		           
					for(int i=0;i<Constant.activity.size();i++)	
					{
						((Activity) Constant.activity.get(i)).finish();

					}
					
					Constant.activity.clear();
					setResult(RESULT_CLOSE_ALL);
		            finish();
		        }

		    });

		    builder.setNegativeButton("否 ", new DialogInterface.OnClickListener() {

		        @Override
		        public void onClick(DialogInterface dialog, int which) {
		            // Do nothing
		            dialog.dismiss();
		        }
		    });

		    AlertDialog alert = builder.create();
		    alert.show();
		   
		}
		return super.onKeyDown(keyCode, event);

		}
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
	    switch(resultCode)
	    {
	    case RESULT_CLOSE_ALL:
	        setResult(RESULT_CLOSE_ALL);
	        finish();
	    }
	    super.onActivityResult(requestCode, resultCode, data);
	}
	
}