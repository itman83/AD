package com.cnfa.Activity;


import java.util.ArrayList;

import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.view.ViewGroup.LayoutParams;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import com.cnfa.R;
import com.cnfa.category.ViewPagerADsDetailAdapter;
import com.cnfa.model.ADDetailComponent;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.tab.TabbarActivity;
import com.viewpagerindicator.CirclePageIndicator;
import com.viewpagerindicator.PageIndicator;

public class SearchAdsDetailActivity extends TabbarActivity
{
	TextView txtbreadcrumb;
	private SearchAdsModel obj = null;
	private ImageView imgFavorite, btnShare;
	private int check;
	int totalPagesInPager = 1;
	int adsPosition = 0;
	ScrollView dotsScrollView;
	//private LinearLayout layout_dots;
	private ViewPagerADsDetailAdapter mAdapter;
	private ViewPager mPager;
	ArrayList<ADDetailComponent> list = new ArrayList<ADDetailComponent>();
	String bottomtext;
	int countPageForDots = 1;
	int nowDots = 10;
	int pageCurrent = 0;
	boolean isRegion1 = false;
	boolean isRegion2 = false;
	static int region1 = 1;
	static int region2 = 2;
	int preRegion = region1;
	boolean isRegionChange = false;
	int region = 2;
	 PageIndicator mIndicator;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView( R.layout.copy_of_adslistdetail);
//		getWindow().setSoftInputMode(
//				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
//		Constant.FAV_SCREEN=2;
		// dotsScrollView=(ScrollView)findViewById(R.id.scrollview_dots);
//		txtbreadcrumb = (TextView) findViewById(R.id.txtbreadcrumb);
//		pageCurrent = getIntent().getIntExtra("CURR_PAGE", 0);
//		list = getIntent().getParcelableArrayListExtra("data");
//		bottomtext = getIntent().getExtras().getString("bottomtext");
//		adsPosition = getIntent().getIntExtra("ADS_ROW_PRESSED", 0);
//		String breadcrumbtext = getIntent().getExtras().getString(
//				"breadcrumbtext");

//		if (list.size() > 0)
//			loadGridView(list);
//
//		txtbreadcrumb.setText(breadcrumbtext);
//		txtbreadcrumb.setTypeface(Utility
//				.setRegularFont(getApplicationContext()));
	}
	void addDots(int initialDot, int region) {
		switch (region) {
		case 1:

			for (int i = 0; i <=9; i++) {

				if (i == initialDot) {
					LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
							LayoutParams.WRAP_CONTENT,
							LayoutParams.WRAP_CONTENT);
					ImageView imgview = new ImageView(getApplicationContext());
					imgview.setBackgroundResource(R.drawable.selectdots);
					layoutParams.setMargins(0, 0, 10, 0);
					//layout_dots.addView(imgview, i, layoutParams);

				} else {
					LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
							LayoutParams.WRAP_CONTENT,
							LayoutParams.WRAP_CONTENT);
					ImageView imgview = new ImageView(getApplicationContext());
					imgview.setBackgroundResource(R.drawable.dots);
					layoutParams.setMargins(0, 0, 10, 0);
					//layout_dots.addView(imgview, i, layoutParams);
				}

			}
			break;

		case 2:
			for (int i = 0; i < totalPagesInPager % 10; i++) {

				if (i == initialDot) {
					LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
							LayoutParams.WRAP_CONTENT,
							LayoutParams.WRAP_CONTENT);
					ImageView imgview = new ImageView(getApplicationContext());
					imgview.setBackgroundResource(R.drawable.selectdots);
					layoutParams.setMargins(0, 0, 10, 0);
					//layout_dots.addView(imgview, i, layoutParams);

				} else {
					LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
							LayoutParams.WRAP_CONTENT,
							LayoutParams.WRAP_CONTENT);
					ImageView imgview = new ImageView(getApplicationContext());
					imgview.setBackgroundResource(R.drawable.dots);
					layoutParams.setMargins(0, 0, 10, 0);
					//layout_dots.addView(imgview, i, layoutParams);
				}

			}
			break;
		}
		
	}

	private void loadGridView(ArrayList<ADDetailComponent> categoryListtemp) {
		//layout_dots = (LinearLayout) findViewById(R.id.dots_layout);

		mAdapter = new ViewPagerADsDetailAdapter(getSupportFragmentManager(),
				SearchAdsDetailActivity.this, list, bottomtext, pageCurrent);
		mPager = (ViewPager) findViewById(R.id.view_pager);

		mPager.setAdapter(mAdapter);
		mPager.setCurrentItem(pageCurrent);
		
		 mIndicator = (CirclePageIndicator)findViewById(R.id.indicator);
	     mIndicator.setViewPager(mPager);

		totalPagesInPager = categoryListtemp.size();
		if (pageCurrent < totalPagesInPager / 10 * 10) {
			region = region1;
		} else {
			region = region2;
		}
		addDots(pageCurrent % 10, region);
		

/*		mPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
			@Override
			public void onPageScrolled(int position, float positionOffset,
					int positionOffsetPixels) {

				int pos = position;
				if (pos < totalPagesInPager / 10 * 10) {
					
					//layout_dots.removeAllViews();
					addDots(pos % 10, region1);
				} else {
					
					//layout_dots.removeAllViews();
					addDots(pos % 10, region2);
				}

				

			}

			@Override
			public void onPageSelected(int position) {


			}

			@Override
			public void onPageScrollStateChanged(int state) {
			
			}
		});*/

	}
}