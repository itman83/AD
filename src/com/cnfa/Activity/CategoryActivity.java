package com.cnfa.Activity;

import java.io.InputStream;
import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.ActionBar.LayoutParams;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.cnfa.R;
import com.cnfa.category.ViewPagerAdapter;
import com.cnfa.connection.HttpConnection;
import com.cnfa.constant.Constant;
import com.cnfa.model.CategoryModel;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.parser.SearchAdsParserHandler;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.Utility;

public class CategoryActivity extends TabbarActivity{
	private ViewPagerAdapter mAdapter;
	private ViewPager mPager;
	private LinearLayout layout_dots;   
	private String _newspaperName,_id;
	private ArrayList<CategoryModel> categoryList;
	private ArrayList<SearchAdsModel> searchAdsArraylist = new ArrayList<SearchAdsModel>();
	private static final int PROGRESS_DIALOG = 0;
	private ImageView btnSearch;
	private EditText edSearch;
	private String breadCrumbText;
	private String cityName;
	int totalPagesInPager=1;
	  String className=null;
	private TextView txtCity;
	String activity_source_name=null;
		public void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState,R.layout.category);
	       // setContentView(R.layout.citylist);   
			getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
			 className =getIntent().getStringExtra("ACTIVITY_NAME");
			edSearch = (EditText)findViewById(R.id.edsearch);
			btnSearch = (ImageView)findViewById(R.id.btnsearch);
			Constant.NEWS_SCREEN=2;
			Constant.CITY_SCREEN=3;
		     activity_source_name=getIntent().getStringExtra("ACTIVITY_NAME");
		

			
			txtCity = (TextView)findViewById(R.id.textcity);
			
			 Intent intent = getIntent();
		//	 categoryList = (ArrayList<CategoryModel>)intent.getSerializableExtra("categorydata");
			 categoryList = NewspaperActivity.categoryArraylist;
			 _newspaperName = getIntent().getStringExtra("newspapername"); 
			 _id = getIntent().getStringExtra("newspaperid"); 
			 cityName = getIntent().getStringExtra("cityname");
			 if(_newspaperName!=null){
				 if(cityName != null){
				//txtCity.setText(cityName +">>"+_newspaperName);
				String TAG_TEXT = getIntent().getStringExtra("TAG_FOR_BOTTOMTEXT"); 
				if(TAG_TEXT.equals("1"))
					breadCrumbText = cityName +">>"+_newspaperName;

				 }
				 else
					 breadCrumbText = _newspaperName;
				txtCity.setText(breadCrumbText);

				txtCity.setTypeface(Utility.setRegularFont(getApplicationContext()));

			 }
		//	secondDot_ImageView = (ImageView) findViewById(R.id.second_dot);

			 
			 
			 btnSearch.setOnClickListener(new OnClickListener() {
					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						/*if(edSearch.getText().toString().trim().length()>0){
						ArrayList<CategoryModel> al2 = new ArrayList<CategoryModel>();

						al2 = performSearch(edSearch.getText().toString());
						loadGridView(al2);
						}
						else{
								Constant.showMsg(getApplicationContext(), Constant.MSG_SEARCH_CONTENT);
						}*/
						
						if (edSearch.getText().toString().length() > 0) {
							Intent intent = new Intent(CategoryActivity.this,
									SearchAdsActivity.class);
							intent.putExtra("ACTIVITY_NAME",activity_source_name);
							intent.putExtra("SEARCH_WORD", edSearch.getText()
									.toString());
							startActivity(intent);
						}
//						if(edSearch.getText().toString().length()>0){
//							String str = _id+"&data="+edSearch.getText().toString();
//
//						new searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY_SEARCH_OPTION,str).execute();
//						}
//						else
//							Constant.showMsg(getApplicationContext(), Constant.MSG_SEARCH_CONTENT);
					}
				});
				
			 
			 

			if(categoryList.size() > 0)
			loadGridView(categoryList);
						
	 }
	 

		/*
		 * For local search
		 */
		
		@SuppressLint("DefaultLocale")
		public ArrayList<CategoryModel> performSearch(String searchString) {
			ArrayList<CategoryModel> filterData = new ArrayList<CategoryModel>();
			for (int i = 0; i < categoryList.size(); i++) {
				if (categoryList.get(i).getCategory().toLowerCase().contains(searchString.toLowerCase())) {
					filterData.add(categoryList.get(i));
				}
			}
			return filterData;
		}
	 
		@SuppressWarnings("unused")
		private void loadGridView(ArrayList<CategoryModel> categoryListtemp) {
		// TODO Auto-generated method stub
		/*	System.out.println("list size 1 => "+categoryListtemp.size());
			categoryListtemp.addAll(categoryList);
			categoryListtemp.addAll(categoryList);
			System.out.println("list size 2 => "+categoryListtemp.size());
*/
			layout_dots = (LinearLayout)findViewById(R.id.dots_layout);
			
			mAdapter = new ViewPagerAdapter(getSupportFragmentManager(), CategoryActivity.this,categoryListtemp,_newspaperName,cityName,className);
			mPager = (ViewPager) findViewById(R.id.view_pager);
			mPager.setAdapter(mAdapter);
			
			 totalPagesInPager= categoryListtemp.size()/9;
			if(categoryListtemp.size()%9!=0)
				totalPagesInPager++;
			
			/*if(categoryList.size()>0 && totalPages == 0)
				totalPages = 1;
		*/	
			for(int i=0;i<totalPagesInPager;i++){
				//firstDot_ImageView = (ImageView) findViewById(R.id.first_dot);
		//	layout_dots.removeView(firstDot_ImageView);

			if(i==0){
				LinearLayout.LayoutParams layoutParams=new LinearLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
				ImageView imgview = new ImageView(getApplicationContext());
				imgview.setBackgroundResource(R.drawable.selectdots);
				layoutParams.setMargins(0, 0, 10, 0);
				layout_dots.addView(imgview, layoutParams);
			//	firstDot_ImageView.setBackgroundResource(R.drawable.selectdots);
//				layout_dots.addView(imgview);
			}
			else
			{
				LinearLayout.LayoutParams layoutParams=new LinearLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
				ImageView imgview = new ImageView(getApplicationContext());
				imgview.setBackgroundResource(R.drawable.dots);
				layoutParams.setMargins(0, 0, 10, 0);
				layout_dots.addView(imgview, layoutParams);
			}

		}
			
			mPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
			    @Override
			    public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
			        //actions	    
			    }

			    @Override
			    public void onPageSelected(int position) {
			        //actions
			    //	mPager.setCurrentItem(1);
			    	
			    	
			    	for(int i=0;i<totalPagesInPager;i++){
						//firstDot_ImageView = (ImageView) findViewById(R.id.first_dot);
				//	layout_dots.removeView(firstDot_ImageView);

					if(i==position){
						layout_dots.removeViewAt(i);
						LinearLayout.LayoutParams layoutParams=new LinearLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
						ImageView imgview = new ImageView(getApplicationContext());
						imgview.setBackgroundResource(R.drawable.selectdots);
						layoutParams.setMargins(0, 0, 10, 0);
						layout_dots.addView(imgview, i, layoutParams);					
					}
					else
					{
						layout_dots.removeViewAt(i);
						LinearLayout.LayoutParams layoutParams=new LinearLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
						ImageView imgview = new ImageView(getApplicationContext());
						imgview.setBackgroundResource(R.drawable.dots);
						layoutParams.setMargins(0, 0, 10, 0);
						layout_dots.addView(imgview, i, layoutParams);					
					}

				}
//					switch(position){
//		
//					case 0:// For Season	
//						layout_dots.removeViewAt(position);
//						LinearLayout.LayoutParams layoutParams=new LinearLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
//						ImageView imgview = new ImageView(getApplicationContext());
//						imgview.setBackgroundResource(R.drawable.selectdots);
//						layoutParams.setMargins(0, 0, 10, 0);
//						layout_dots.addView(imgview, position, layoutParams);
//					    layout_dots.invalidate();
//						
//						ImageView imgview2 = new ImageView(getApplicationContext());
//						imgview2.setBackgroundResource(R.drawable.dots);
//					
//						//firstDot_ImageView = (ImageView) findViewById(R.id.first_dot);
//						//firstDot_ImageView.setBackgroundResource(R.drawable.dots);
//						layout_dots.removeViewAt(position+1);
//						layout_dots.addView(imgview2, position+1);
//						layout_dots.invalidate();
//						
//						/*TextView txt1 = (TextView)findViewById(R.id.txtelectronics);
//						txt1.setText(categoryList.get(position).getCategory());
//					*/	
//						
//						/*firstDot_ImageView.setBackgroundResource(R.drawable.selectdots);
//						secondDot_ImageView.setBackgroundResource(R.drawable.dots);*/
//						break;
//					case 1:// For Reason
//						
//						ImageView imgview3 = new ImageView(getApplicationContext());
//						imgview3.setBackgroundResource(R.drawable.dots);
//					
//					//	firstDot_ImageView.setBackgroundResource(R.drawable.selectdots);
//						layout_dots.removeViewAt(position-1);
//						layout_dots.addView(imgview3, position-1);
//						layout_dots.invalidate();
//						
//						ImageView imgview4 = new ImageView(getApplicationContext());
//						imgview4.setBackgroundResource(R.drawable.selectdots);
//					
//						//firstDot_ImageView = (ImageView) findViewById(R.id.first_dot);
//						//firstDot_ImageView.setBackgroundResource(R.drawable.dots);
//						layout_dots.removeViewAt(position);
//						layout_dots.addView(imgview4, position);
//						layout_dots.invalidate();
//						/*firstDot_ImageView.setBackgr
//						
//						/*firstDot_ImageView.setBackgroundResource(R.drawable.dots);
//						secondDot_ImageView.setBackgroundResource(R.drawable.selectdots);*/
//						break;
//					}
			    }

			    
			    @Override
			    public void onPageScrollStateChanged(int state) {
			        //actions
			    }
			});
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
				CustomProgressDialog.showProgressDialog(CategoryActivity.this,"", true);

			}

			@Override
			protected String doInBackground(String... params) {
				InputStream in = HttpConnection.connect(_url+_searchstring);
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
				//dismissDialog(PROGRESS_DIALOG);
				CustomProgressDialog.removeDialog();

				//check for updation
				
				Intent intent = new Intent(getApplicationContext(),
						SearchAdsActivity.class);
				//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				intent.putExtra("searchads", searchAdsArraylist);
				//intent.putExtra("adstitle", "test");
				startActivity(intent);
				overridePendingTransition(R.anim.slide_in_left,
						R.anim.slide_out_left);
				
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
		@Override
		protected void onResume() {
		    super.onResume();
		
		if(className != null){    
		   if(className.equals("2"))
		   {
		    layout_city.setBackgroundResource(R.drawable.menuselector);
			layout_img_city.setBackgroundResource(R.drawable.cityiconactive);
		   }
		   else if(className.equals("1"))
		   {
			   layout_newspaper.setBackgroundResource(R.drawable.menuselector);
				layout_img_newspaper.setBackgroundResource(R.drawable.newspapericonactive);
		   }
		}
		
		}
	 
}
