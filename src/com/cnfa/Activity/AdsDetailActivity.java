package com.cnfa.Activity;

import java.util.ArrayList;

import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.view.ViewGroup.LayoutParams;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import com.cnfa.R;
import com.cnfa.category.ViewPagerADsDetailAdapter;
import com.cnfa.constant.Constant;
import com.cnfa.model.ADDetailComponent;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.Utility;

public class AdsDetailActivity extends TabbarActivity {
	// private TextView txtTitle, txtDetail, txtCityName, txtbreadcrumb,
	// txtHeading;
	TextView txtbreadcrumb;
	private SearchAdsModel obj = null;
	private ImageView imgFavorite, btnShare;
	private int check;
	int totalPagesInPager = 1;
	int adsPosition = 0;
	ScrollView dotsScrollView;
	private LinearLayout layout_dots;
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

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.adslistdetail);
		
		
		String className = getIntent().getStringExtra("ACTIVITY_NAME");
		if (className.equalsIgnoreCase(Constant.ACTIVITY_CITY)) {
			layout_city.setBackgroundResource(R.drawable.menuselector);
			layout_img_city.setBackgroundResource(R.drawable.cityiconactive);

		} else if (className.equalsIgnoreCase(Constant.ACTIVITY_NEWS)) {
			layout_newspaper.setBackgroundResource(R.drawable.menuselector);
			layout_img_newspaper
					.setBackgroundResource(R.drawable.newspapericonactive);

		} else if (className.equalsIgnoreCase(Constant.ACTIVITY_FAV)) {
			layout_favourite.setBackgroundResource(R.drawable.menuselector);
			layout_img_favourite
					.setBackgroundResource(R.drawable.favouriteiconactive);

		}
		// setContentView(R.layout.citylist);
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
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
		Constant.FAV_SCREEN=2;
		Constant.NEWS_SCREEN=4;
		// dotsScrollView=(ScrollView)findViewById(R.id.scrollview_dots);
		txtbreadcrumb = (TextView) findViewById(R.id.txtbreadcrumb);
		pageCurrent = getIntent().getIntExtra("CURR_PAGE", 0);
		list = getIntent().getParcelableArrayListExtra("data");
		bottomtext = getIntent().getExtras().getString("bottomtext");
		adsPosition = getIntent().getIntExtra("ADS_ROW_PRESSED", 0);
		String breadcrumbtext = getIntent().getExtras().getString(
				"breadcrumbtext");

		if (list.size() > 0)
			loadGridView(list);

		txtbreadcrumb.setText(breadcrumbtext);
		txtbreadcrumb.setTypeface(Utility
				.setRegularFont(getApplicationContext()));

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
					layout_dots.addView(imgview, i, layoutParams);

				} else {
					LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
							LayoutParams.WRAP_CONTENT,
							LayoutParams.WRAP_CONTENT);
					ImageView imgview = new ImageView(getApplicationContext());
					imgview.setBackgroundResource(R.drawable.dots);
					layoutParams.setMargins(0, 0, 10, 0);
					layout_dots.addView(imgview, i, layoutParams);
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
					layout_dots.addView(imgview, i, layoutParams);

				} else {
					LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(
							LayoutParams.WRAP_CONTENT,
							LayoutParams.WRAP_CONTENT);
					ImageView imgview = new ImageView(getApplicationContext());
					imgview.setBackgroundResource(R.drawable.dots);
					layoutParams.setMargins(0, 0, 10, 0);
					layout_dots.addView(imgview, i, layoutParams);
				}

			}
			break;
		}
		
	}

	private void loadGridView(ArrayList<ADDetailComponent> categoryListtemp) {
		layout_dots = (LinearLayout) findViewById(R.id.dots_layout);

		mAdapter = new ViewPagerADsDetailAdapter(getSupportFragmentManager(),
				AdsDetailActivity.this, list, bottomtext, pageCurrent);
		mPager = (ViewPager) findViewById(R.id.view_pager);

		mPager.setAdapter(mAdapter);
		mPager.setCurrentItem(pageCurrent);

		totalPagesInPager = categoryListtemp.size();
		if (pageCurrent < totalPagesInPager / 10 * 10) {
			region = region1;
		} else {
			region = region2;
		}
		addDots(pageCurrent % 10, region);
		

		mPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
			@Override
			public void onPageScrolled(int position, float positionOffset,
					int positionOffsetPixels) {

				int pos = position;
				if (pos < totalPagesInPager / 10 * 10) {
					
					layout_dots.removeAllViews();
					addDots(pos % 10, region1);
				} else {
					
					layout_dots.removeAllViews();
					addDots(pos % 10, region2);
				}

				

			}

			@Override
			public void onPageSelected(int position) {

				// System.out.println("position=" + position);
//				int pos = 0;
//				// if (position >= 20) {
//				// pos = position - 10 * 2;
//				// } else if (position >= 10) {
//				// pos = position - 10;
//				// } else {
//				// pos = position;
//				// }
//				if (pos < totalPagesInPager / 10 * 10
//						&& totalPagesInPager / 10 == 0)
//					region = region1;
//				else
//					region = region2;
//				switch (region) {
//				case 1:
//					for (int i = 0; i < 9; i++) {
//
//						if (i == pos % 10) {
//							layout_dots.getChildAt(i).setBackgroundResource(
//									R.drawable.selectdots);
//
//						} else {
//							layout_dots.getChildAt(i).setBackgroundResource(
//									R.drawable.dots);
//
//						}
//
//					}
//					break;
//
//				case 2:
//					for (int i = 0; i < totalPagesInPager % 10; i++) {
//
//						if (i == pos) {
//							layout_dots.getChildAt(i).setBackgroundResource(
//									R.drawable.selectdots);
//
//						} else {
//							layout_dots.getChildAt(i).setBackgroundResource(
//									R.drawable.dots);
//
//						}
//
//					}
//					break;
//				}

			}

			@Override
			public void onPageScrollStateChanged(int state) {
			
			}
		});

	}

}
