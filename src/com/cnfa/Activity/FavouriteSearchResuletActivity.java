package com.cnfa.Activity;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.util.Linkify;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.cnfa.R;
import com.cnfa.constant.Constant;
import com.cnfa.db.DbSync;
import com.cnfa.model.ADDetailComponent;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.StringUtils;
import com.cnfa.utility.Utility;

public class FavouriteSearchResuletActivity extends TabbarActivity {
	private MySearchListAdapter myadapter = null;
	private ArrayList<SearchAdsModel> searchAdsList;
	private ListView listView;
	private String _newsPaperName, bottomText;
//	String activity_source_name = null;
	private EditText edSearch;
	private ImageView btnSearch;
	String searchWord=null;
	Context c;
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.adlist_fav_search);
		layout_favourite.setBackgroundResource(R.drawable.menuselector);
		layout_img_favourite.setBackgroundResource(R.drawable.favouriteiconactive);
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
		edSearch = (EditText) findViewById(R.id.edt_search_fav);
		btnSearch = (ImageView) findViewById(R.id.img_search);

		listView = (ListView) findViewById(R.id.listView1);

		btnSearch.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {

				findViewById(R.id.txt_no_search_item).setVisibility(View.GONE);

				if (edSearch.getText().toString().length() > 0)
					new SearchAdsTaskfavourite(edSearch.getText().toString())
							.execute();
				else
					Constant.showMsg(getApplicationContext(),
							Constant.MSG_SEARCH_CONTENT);
			}
		});

		 searchWord = getIntent().getStringExtra("SEARCH_WORD");
		if (searchWord.length() > 0)
			new SearchAdsTaskfavourite(searchWord).execute();
		else
			Constant.showMsg(getApplicationContext(),
					Constant.MSG_SEARCH_CONTENT);
		
		
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
			btnShare.setVisibility(View.GONE);
			_newsPaperName = list.get(position).getNewspaperName();

			txtTitle.setText(list.get(position).getAdsTitle());
			String str = list.get(position).getAdsDescription();

//			txtdetail.setAutoLinkMask(Linkify.PHONE_NUMBERS);
//			txtdetail.setLinkTextColor(getResources().getColor(
//					R.color.linkcolor));
			StringUtils.popupDefinition(str,txtdetail,FavouriteSearchResuletActivity.this);
			txtcity.setText(list.get(position).getCity() + " | ");
			txtnews.setText(_newsPaperName + " | ");
			txtdate.setText(list.get(position).getCreationTime());

			bottomText = _newsPaperName + " | " + list.get(position).getCity()
					+ " | " + list.get(position).getCreationTime();

			txtTitle.setTypeface(Utility
					.setRegularFont(getApplicationContext()));
			txtdetail.setTypeface(Utility
					.setRegularFont(getApplicationContext()));
			txtcity.setTypeface(Utility.setRegularFont(getApplicationContext()));
			txtnews.setTypeface(Utility.setRegularFont(getApplicationContext()));
			txtdate.setTypeface(Utility.setRegularFont(getApplicationContext()));

			rowView.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View v) {

					ArrayList<ADDetailComponent> liArrayList = new ArrayList<ADDetailComponent>();
					for (int i = 0; i < list.size(); i++) {
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
					intent.putExtra("data", liArrayList);
					intent.putExtra("bottomtext", bottomText);
					intent.putExtra("breadcrumbtext", "喜爱");
					intent.putExtra("ACTIVITY_NAME", Constant.ACTIVITY_FAV);

					intent.putExtra("ADS_ROW_PRESSED", position);
					startActivity(intent);
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

	
	class SearchAdsTaskfavourite extends AsyncTask<String, Integer, String> {
		public String _searchstring;

		public SearchAdsTaskfavourite(String searchString) {
			_searchstring = searchString;
		}

		protected void onPreExecute() {
			CustomProgressDialog.showProgressDialog(
					FavouriteSearchResuletActivity.this, "", true);

		}

		@Override
		protected String doInBackground(String... params) {

			searchAdsList = DbSync.getSearchInFavoritedata(
					getApplicationContext(), _searchstring);

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			CustomProgressDialog.removeDialog();
			if (searchAdsList.size() > 0) {
				listView.setVisibility(View.VISIBLE);
				myadapter = new MySearchListAdapter(
						FavouriteSearchResuletActivity.this, searchAdsList);
				listView.setAdapter(myadapter);
				//listView.setAdapter(myadapter);
			//	myadapter.notifyDataSetChanged();
			} else {
			listView.setVisibility(View.GONE);
				findViewById(R.id.txt_no_search_item).setVisibility(View.VISIBLE);

			}

		
		}
	}
	@Override
	protected void onStart() {
		// TODO Auto-generated method stub
		super.onStart();
		System.out.println("staring calling");
	}
	
	@Override
	protected void onRestart() {
		// TODO Auto-generated method stub
		super.onRestart();
		searchAdsList = DbSync.getSearchInFavoritedata(
				getApplicationContext(), searchWord);
		if (searchAdsList.size() > 0) {
			listView.setVisibility(View.VISIBLE);
			myadapter = new MySearchListAdapter(
					FavouriteSearchResuletActivity.this, searchAdsList);
			listView.setAdapter(myadapter);
			
		} else {
		listView.setVisibility(View.GONE);
			findViewById(R.id.txt_no_search_item).setVisibility(View.VISIBLE);

		}

	}
	@Override
	protected void onResume() {
		super.onResume();
	
	    c = FavouriteSearchResuletActivity.this;
	    Constant.activity.add(c);

		layout_favourite.setBackgroundResource(R.drawable.menuselector);
		layout_img_favourite
				.setBackgroundResource(R.drawable.favouriteiconactive);
		return;
	}

}
