package com.cnfa.Activity;

import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.KeyEvent;
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
import com.cnfa.swipetodelete.SwipeDismissListViewTouchListener;
import com.cnfa.swipetodelete.SwipeDismissTouchListener;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.StringUtils;
import com.cnfa.utility.Utility;

public class FavoriteAdsActivity extends TabbarActivity {
	private MySearchListAdapter myadapter = null;
	private ArrayList<SearchAdsModel> searchAdsList;
	private ArrayList<SearchAdsModel> searchAdsListTemp;

	private ListView listView;
	private String _newsPaperName, bottomText;

	private EditText edSearch;
	private ImageView btnSearch;
	TextView noIteTextView;
	Context c ;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.adslist);
		layout_favourite.setBackgroundResource(R.drawable.menuselector);
		layout_img_favourite
				.setBackgroundResource(R.drawable.favouriteiconactive);

		findViewById(R.id.view_divider).setVisibility(View.GONE);
		findViewById(R.id.llsearchbarlayout).setVisibility(View.GONE);
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
		edSearch = (EditText) findViewById(R.id.edt_search_adactivity);
		btnSearch = (ImageView) findViewById(R.id.btnsearch_adlist);
		listView = (ListView) findViewById(R.id.listView1);
		
		noIteTextView = (TextView) findViewById(R.id.txt_no_item);
		noIteTextView.setVisibility(View.GONE);

		searchAdsList = DbSync.getFavoritelocalData(getApplicationContext());
		if (searchAdsList.size() > 0) {
			listView.setVisibility(View.VISIBLE);
			myadapter = new MySearchListAdapter(FavoriteAdsActivity.this,
					searchAdsList);
			listView.setAdapter(myadapter);
			myadapter.notifyDataSetChanged();
		} else {
			listView.setVisibility(View.GONE);
			noIteTextView.setVisibility(View.VISIBLE);
			noIteTextView.setText(R.string.no_result_found);
		}

		btnSearch.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (edSearch.getText().toString().length() > 0) {
					Intent intent = new Intent(FavoriteAdsActivity.this,
							FavouriteSearchResuletActivity.class);
					intent.putExtra("SEARCH_WORD", edSearch.getText()
							.toString());
					startActivity(intent);
					// searchAdsList.clear();
					// searchAdsListTemp =
					// performSearch(edSearch.getText().toString());
					// if (searchAdsListTemp.size() > 0) {
					// listView.setVisibility(View.VISIBLE);
					// myadapter = new
					// MySearchListAdapter(FavoriteAdsActivity.this,searchAdsListTemp);
					// listView.setAdapter(myadapter);
					// myadapter.notifyDataSetChanged();
					// } else {
					// listView.setVisibility(View.GONE);
					// noIteTextView.setVisibility(View.VISIBLE);
					// noIteTextView.setText(R.string.no_result_found);
					// }

				}
			}
		});
//		SwipeDismissListViewTouchListener2 touchListener = new SwipeDismissListViewTouchListener2(
//				listView,
//				new SwipeDismissListViewTouchListener2.OnDismissCallback() {
//					@Override
//					public void onDismiss(ListView listView,
//							int reverseSortedPositions) {
//						System.out.println("position in dismiss="
//								+ reverseSortedPositions);
//						// myadapter..remove(myadapter.getItem(reverseSortedPositions));
//						// searchAdsList.remove(myadapter.getItem(reverseSortedPositions));
//						// myadapter.notifyDataSetChanged();
//						System.out.println("jjfijj");
//						// SetUpTotal();
//					}
//				});
//		listView.setOnTouchListener(touchListener);
//		 listView.setOnScrollListener(touchListener.makeScrollListener());

	}

	@Override
	protected void onResume() {
    super.onResume();
    c = FavoriteAdsActivity.this;
    Constant.activity.add(c);
	   
	}

	@SuppressLint("DefaultLocale")
	public ArrayList<SearchAdsModel> performSearch(String searchString) {
		ArrayList<SearchAdsModel> filterData = new ArrayList<SearchAdsModel>();
		for (int i = 0; i < searchAdsList.size(); i++) {
			if (searchAdsList.get(i).getAdsTitle().toLowerCase()
					.contains(searchString.toLowerCase())
					|| searchAdsList.get(i).getAdsDescription().toLowerCase()
							.contains(searchString.toLowerCase())
					|| searchAdsList.get(i).getAdsDescription().toLowerCase()
							.contains(searchString.toLowerCase())) {
				filterData.add(searchAdsList.get(i));
			}
		}
		return filterData;
	}

	public class MySearchListAdapter extends BaseAdapter {
		private final Activity context;

		private SearchAdsModel obj = null;
		private ArrayList<SearchAdsModel> _searchAdsList;

		public MySearchListAdapter(Activity context,
				ArrayList<SearchAdsModel> searchAdsList) {
			super();
			this.context = context;
			this._searchAdsList = searchAdsList;

		}

		@Override
		public View getView(final int position, View convertView,
				final ViewGroup parent) {
			LayoutInflater inflater = context.getLayoutInflater();
			final View rowView = inflater.inflate(R.layout.adslistrow, null,
					true);

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
			_newsPaperName = _searchAdsList.get(position).getNewspaperName();

			txtTitle.setText(_searchAdsList.get(position).getAdsTitle());
			String str = _searchAdsList.get(position).getAdsDescription();
			StringUtils.popupDefinition(str, txtdetail,
					FavoriteAdsActivity.this);
			txtcity.setText(_searchAdsList.get(position).getCity() + " | ");
			txtnews.setText(_newsPaperName + " | ");
			txtdate.setText(_searchAdsList.get(position).getCreationTime());

			bottomText = _newsPaperName + " | "
					+ searchAdsList.get(position).getCity() + " | "
					+ _searchAdsList.get(position).getCreationTime();

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
					for (int i = 0; i < _searchAdsList.size(); i++) {
						obj = _searchAdsList.get(i);
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
					// intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
					intent.putExtra("data", liArrayList);
					intent.putExtra("bottomtext", bottomText);
					intent.putExtra("breadcrumbtext", "喜爱");
					intent.putExtra("ACTIVITY_NAME", Constant.ACTIVITY_FAV);
					intent.putExtra("CURR_PAGE", position);

					intent.putExtra("ADS_ROW_PRESSED", position);

					/*
					 * intent.putExtra("detail",
					 * list.get(position).getAdsDescription());
					 * intent.putExtra("cityname",
					 * list.get(position).getCity()); intent.putExtra("date",
					 * list.get(position).getCreationTime());
					 */startActivity(intent);
					overridePendingTransition(R.anim.slide_in_left,
							R.anim.slide_out_left);

				}
			});

		//  final ViewGroup dismissableContainer = (ViewGroup) findViewById(R.id.mainlayout);

			
			  SwipeDismissListViewTouchListener touchListener =
	              new SwipeDismissListViewTouchListener(
	                      listView,
	                      new SwipeDismissListViewTouchListener.DismissCallbacks() {
	                          @Override
	                          public boolean canDismiss(int position) {
	                              return true;
	                          }

	                          @Override
	                          public void onDismiss(ListView listView, int[] reverseSortedPositions) {
	                              for (int position : reverseSortedPositions) {
	                            	 remove(position);
	                              }
	                              myadapter.notifyDataSetChanged();
	                          }
	                      });
	      listView.setOnTouchListener(touchListener);
	      // Setting this scroll listener is required to ensure that during ListView scrolling,
	      // we don't look for swipes.
	      listView.setOnScrollListener(touchListener.makeScrollListener());
			
			
			
			
	      rowView.setOnTouchListener(new SwipeDismissTouchListener(
	    		  rowView,
              null,
              new SwipeDismissTouchListener.DismissCallbacks() {
                  @Override
                  public boolean canDismiss(Object token) {
                      return true;
                  }

                  @Override
                  public void onDismiss(View view, Object token) {
                	  remove(position);
                	  try{
                	  parent.removeView(rowView);
                	  }
                	  catch (UnsupportedOperationException e) {
							// TODO: handle exception
						}
                  }
              }));
    //  dismissableContainer.addView(txtdetail);

			return rowView;
		}

		@Override
		public int getCount() {
			// TODO Auto-generated method stub
			return _searchAdsList.size();
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

	protected void remove(int position) {
		// TODO Auto-generated method stub
		// Constant.showMsg(getApplicationContext(),position+" position");

		boolean delCheck = DbSync.deleteFavoriteRecord(getApplicationContext(),
				"favoritetable", searchAdsList.get(position).getId());
		if (delCheck == true) {
			searchAdsList.remove(position);
			// Constant.showMsg(getApplicationContext(),Constant.MSG_REMOVE_FAVORITE);
		}
		myadapter.notifyDataSetChanged();
	}

	// class SearchAdsTaskfavourite extends AsyncTask<String, Integer, String> {
	// public String _searchstring;
	//
	// public SearchAdsTaskfavourite(String searchString) {
	// _searchstring = searchString;
	// }
	//
	// protected void onPreExecute() {
	// CustomProgressDialog.showProgressDialog(FavoriteAdsActivity.this,
	// "", true);
	//
	// }
	//
	// @Override
	// protected String doInBackground(String... params) {
	//
	// searchAdsList = DbSync.getSearchInFavoritedata(
	// getApplicationContext(), _searchstring);
	//
	// return null;
	// }
	//
	// protected void onProgressUpdate(Integer... progress) {
	//
	// }
	//
	// protected void onPostExecute(String result) {
	// // dismissDialog(PROGRESS_DIALOG);
	// CustomProgressDialog.removeDialog();
	// if (searchAdsList.size() > 0) {
	// myadapter = new MySearchListAdapter(
	// FavoriteAdsActivity.this, searchAdsList);
	// listView.setAdapter(myadapter);
	// } else {
	// myadapter.notifyDataSetChanged();
	// noIteTextView.setVisibility(View.VISIBLE);
	// noIteTextView.setText(Utility.getVal("NO_RESULT_FOUND"));
	//
	// }
	// // check for updation
	//
	// // Intent intent = new Intent(getApplicationContext(),
	// // SearchAdsActivity.class);
	// // intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
	// // intent.putExtra("searchads", searchAdsArraylist);
	// // intent.putExtra("newspapername", "搜索关键词:"+_searchstring);
	// // startActivity(intent);
	// // overridePendingTransition(R.anim.slide_in_left,
	// // R.anim.slide_out_left);
	// //
	// }
	// }
	@Override
	protected void onRestart() {
		// TODO Auto-generated method stub
		super.onRestart();
		searchAdsList = DbSync.getFavoritelocalData(getApplicationContext());
		if (searchAdsList.size() > 0) {
			listView.setVisibility(View.VISIBLE);
			myadapter = new MySearchListAdapter(FavoriteAdsActivity.this,
					searchAdsList);
			listView.setAdapter(myadapter);
			myadapter.notifyDataSetChanged();
		} else {
			listView.setVisibility(View.GONE);
			noIteTextView.setVisibility(View.VISIBLE);
			noIteTextView.setText(R.string.no_result_found);
		}
	}
	
	@Override
	public void onBackPressed() {
		// TODO Auto-generated method stub
		super.onBackPressed();

	}
	
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if ((keyCode == KeyEvent.KEYCODE_BACK)) {
			AlertDialog.Builder builder = new AlertDialog.Builder(FavoriteAdsActivity.this);
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
					//setResult(RESULT_CLOSE_ALL);
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
}
