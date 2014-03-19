package com.cnfa.Activity;

import java.io.InputStream;
import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
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
import com.cnfa.Activity.FavouriteSearchResuletActivity.SearchAdsTaskfavourite;
import com.cnfa.connection.HttpConnection;
import com.cnfa.constant.Constant;
import com.cnfa.model.ADDetailComponent;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.parser.SearchAdsParserHandler;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.StringUtils;
import com.cnfa.utility.Utility;

public class SearchAdsActivity extends TabbarActivity {
	InputStream in;
	private MySearchListAdapter myadapter = null;
	private ArrayList<SearchAdsModel> searchAdsList;
	private ListView listView;
	private ImageView btnSearch;
	private EditText edSearch;
	private TextView textcity;
	private String _newsPaperName;
	private String bottomText, breadcrumbtext;
	private ArrayList<SearchAdsModel> searchAdsArraylist = new ArrayList<SearchAdsModel>();
	String activity_source_name = null;
	String searchWord=null;
	TextView noIteTextView;
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.adslist);
		
		activity_source_name = getIntent().getStringExtra("ACTIVITY_NAME");
		if(activity_source_name.equals("2"))
		   {
		    layout_city.setBackgroundResource(R.drawable.menuselector);
			layout_img_city.setBackgroundResource(R.drawable.cityiconactive);
		   }
		   else if(activity_source_name.equals("1"))
		   {
			   layout_newspaper.setBackgroundResource(R.drawable.menuselector);
				layout_img_newspaper.setBackgroundResource(R.drawable.newspapericonactive);
		   }
		
		
		noIteTextView=(TextView)findViewById(R.id.txt_no_item);
		noIteTextView.setVisibility(View.GONE);
		_newsPaperName = getIntent().getExtras().getString("newspapername");
		//_categoryName = getIntent().getExtras().getString("categoryname");

		textcity = (TextView)findViewById(R.id.textcity);
        listView = (ListView)findViewById(R.id.listView1);
		edSearch = (EditText)findViewById(R.id.edt_search_adactivity);
		edSearch.setTypeface(Utility.setRegularFont(getApplicationContext()));
		btnSearch = (ImageView)findViewById(R.id.btnsearch_adlist);

		btnSearch.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				String searchWord = edSearch.getText().toString();
				breadcrumbtext = "搜索关键词:"+searchWord;
				 textcity.setText(breadcrumbtext);
					textcity.setTypeface(Utility.setRegularFont(getApplicationContext()));
				if (searchWord.length() > 0)
					new SearchAdsTask(Constant.SEARCH_FROM_NEWSPAPER,searchWord).execute();
				else
					Constant.showMsg(getApplicationContext(),
							Constant.MSG_SEARCH_CONTENT);

				// if(answerString.length() >= 0){
//				ArrayList<SearchAdsModel> al2 = new ArrayList<SearchAdsModel>();
//
//				al2 = performSearch(answerString);
//				myadapter = new MySearchListAdapter(SearchAdsActivity.this, al2);
//				listView.setAdapter(myadapter);

			}
		});
		 searchWord = getIntent().getStringExtra("SEARCH_WORD");
		 
		 if(searchWord != null)
			 textcity.setText("搜索关键词:"+searchWord);
			textcity.setTypeface(Utility.setRegularFont(getApplicationContext()));
		 
		if (searchWord.length() > 0)
			new SearchAdsTask(Constant.SEARCH_FROM_NEWSPAPER,searchWord).execute();
		else
			Constant.showMsg(getApplicationContext(),
					Constant.MSG_SEARCH_CONTENT);

//		Intent intent = getIntent();
//		searchAdsList = (ArrayList<SearchAdsModel>) intent
//				.getSerializableExtra("searchads");
//
		if (_newsPaperName != null)
			textcity.setText(_newsPaperName);
		textcity.setTypeface(Utility.setRegularFont(getApplicationContext()));
//
		breadcrumbtext = "搜索关键词:"+searchWord;
//
//		if (searchAdsList != null) {
//			myadapter = new MySearchListAdapter(SearchAdsActivity.this,
//					searchAdsList);
//			listView.setAdapter(myadapter);
//		}
		/*
		 * if (Utility.isOnline(getApplicationContext())) { new
		 * searchAdsTask(Constant
		 * .FIND_ADS_FROM_CATEGORY,categroyId,categoryName).execute(); } else{
		 * Constant.showMsg(getApplicationContext(),
		 * Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE); }
		 */

	}

	public class MySearchListAdapter extends BaseAdapter {
		private final Activity context;
		ArrayList<SearchAdsModel> list = new ArrayList<SearchAdsModel>();
		private SearchAdsModel obj = null;

		public MySearchListAdapter(Activity context,
				ArrayList<SearchAdsModel> description) {
			super();
			this.context = context;
			this.list = description;
		}

		@SuppressLint("CutPasteId")
		@Override
		public View getView(final int position, View convertView,
				ViewGroup parent) {
			LayoutInflater inflater = context.getLayoutInflater();
			View rowView = inflater.inflate(R.layout.adslistrow, null, true);

		
			final TextView txtTitle = (TextView) rowView
					.findViewById(R.id.txttitle);
			final TextView txtdetail = (TextView) rowView
					.findViewById(R.id.detailtxt);
			final TextView txtcity = (TextView) rowView
					.findViewById(R.id.txtcityname);
			final TextView txtnews = (TextView) rowView
					.findViewById(R.id.txtnews);
			final TextView txtdate = (TextView) rowView
					.findViewById(R.id.txtdate);
			final ImageView btnShare = (ImageView) rowView
					.findViewById(R.id.sharebutton);
			txtTitle.setText(list.get(position).getAdsTitle());
			//txtdetail.setText(list.get(position).getAdsDescription());
			StringUtils.popupDefinition(list.get(position).getAdsDescription(), txtdetail, SearchAdsActivity.this);
			txtcity.setText(list.get(position).getCity() + " | ");
			txtnews.setText(list.get(position).getNewspaperName() + " | ");
			txtdate.setText(list.get(position).getCreationTime());

			bottomText = list.get(position).getNewspaperName() + " | "
					+ list.get(position).getCity() + " | "
					+ list.get(position).getCreationTime();

			txtTitle.setTypeface(Utility
					.setRegularFont(getApplicationContext()));
//			txtdetail.setTypeface(Utility
//					.setRegularFont(getApplicationContext()));
			txtcity.setTypeface(Utility.setRegularFont(getApplicationContext()));
			txtnews.setTypeface(Utility.setRegularFont(getApplicationContext()));
			txtdate.setTypeface(Utility.setRegularFont(getApplicationContext()));

			// if(position%2!=0)
			rowView.setBackgroundResource(R.drawable.darkrow);

			btnShare.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					Constant.shareText(context, list.get(position)
							.getAdsTitle(), list.get(position)
							.getAdsDescription());
					/*
					 * Intent intent = new Intent(getApplicationContext(),
					 * ShareActivity.class);
					 * intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
					 * intent.putExtra("title",
					 * list.get(position).getAdsTitle());
					 * intent.putExtra("desc",
					 * list.get(position).getAdsDescription());
					 * startActivity(intent);
					 * overridePendingTransition(R.anim.slide_in_left,
					 * R.anim.slide_out_left);
					 */
				}
			});

			rowView.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					obj = list.get(position);
					ArrayList<ADDetailComponent> liArrayList = new ArrayList<ADDetailComponent>();
					for (int i = 0; i < Math.min(100,list.size()); i++) {
						obj = list.get(i);
						ADDetailComponent adDetailComponent = new ADDetailComponent();
						adDetailComponent.id = obj.getId();
						adDetailComponent.adsDescription = obj
								.getAdsDescription();
						adDetailComponent.adsTitle = obj.getAdsTitle();
						adDetailComponent.categoryId = obj.getCategoryId();
						adDetailComponent.city = obj.getCity();
						adDetailComponent.cityName = obj.getCityName();
						adDetailComponent.creationTime = obj.getCreationTime();
						adDetailComponent.status = obj.getStatus();
						adDetailComponent.newspaperName = obj
								.getNewspaperName();
						adDetailComponent.updateTime = obj.getUpdateTime();

						liArrayList.add(adDetailComponent);
					}
					Intent intent = new Intent(getApplicationContext(),
							AdsDetailActivity.class);
					//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
					intent.putParcelableArrayListExtra("data", liArrayList);
					intent.putExtra("bottomtext", bottomText);
					System.out.println(breadcrumbtext);
					intent.putExtra("breadcrumbtext", breadcrumbtext);
					intent.putExtra("ACTIVITY_NAME", activity_source_name);
					intent.putExtra("CURR_PAGE", position);
					/*
					 * intent.putExtra("detail",
					 * list.get(position).getAdsDescription());
					 * intent.putExtra("cityname",
					 * list.get(position).getCity()); intent.putExtra("date",
					 * list.get(position).getCreationTime());
					 */startActivity(intent);
					 finish();
					overridePendingTransition(R.anim.slide_in_left,
							R.anim.slide_out_left);

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

//	@SuppressLint("DefaultLocale")
//	public ArrayList<SearchAdsModel> performSearch(String searchString) {
//		ArrayList<SearchAdsModel> filterData = new ArrayList<SearchAdsModel>();
//		for (int i = 0; i < searchAdsList.size(); i++) {
//			if (searchAdsList.get(i).getAdsTitle().toLowerCase()
//					.contains(searchString.toLowerCase())
//					|| searchAdsList.get(i).getAdsDescription().toLowerCase()
//							.contains(searchString.toLowerCase())
//					|| searchAdsList.get(i).getCreationTime().toLowerCase()
//							.contains(searchString.toLowerCase())) {
//				filterData.add(searchAdsList.get(i));
//			}
//		}
//		return filterData;
//	}

	public class SearchAdsTask extends AsyncTask<String, Integer, String> {
		public String _url, _searchstring;

		public SearchAdsTask(String url, String searchString
				) {
			// TODO Auto-generated constructor stub
			_url = url;
			_searchstring = searchString;
	
		}

		protected void onPreExecute() {
			CustomProgressDialog.showProgressDialog(SearchAdsActivity.this, "",
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
//				CategorySearchAdsParserHandler searchAdsparserHandler = new CategorySearchAdsParserHandler();
//				searchAdsArraylist = searchAdsparserHandler
//						.getParseDataByModel(res, _newsPaperName);
			}

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			
			
			if (searchAdsArraylist.size() > 0) {
				listView.setVisibility(View.VISIBLE);
				myadapter = new MySearchListAdapter(
						SearchAdsActivity.this, searchAdsArraylist);
				listView.setAdapter(myadapter);
				myadapter.notifyDataSetChanged();
			} else {
				listView.setVisibility(View.GONE);
				noIteTextView.setVisibility(View.VISIBLE);
				noIteTextView.setText(R.string.no_result_found);
			}
			CustomProgressDialog.removeDialog();
		}
	}

	
	
	
	@Override
	protected void onResume() {
	    super.onResume();

	    
	   
	
	
	}
}
