package com.cnfa.tab;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.cnfa.R;
import com.cnfa.Activity.AboutUsActivity;
import com.cnfa.Activity.CityListActivity;
import com.cnfa.Activity.FavoriteAdsActivity;
import com.cnfa.Activity.NewspaperActivity;

/**
 * @author Sidharth
 * 
 */
public class TabbarActivity extends FragmentActivity {

	public RelativeLayout layout_newspaper, layout_city, layout_favourite,
			layout_aboutus;

	public LinearLayout layout_img_newspaper, layout_img_city,
			layout_img_favourite, layout_img_aboutus;
	//public static int SCREEN = -1;

	public void onCreate(Bundle savedInstanceState, int layoutResID) {
		super.onCreate(savedInstanceState);
		setContentView(layoutResID);

		layout_newspaper = (RelativeLayout) findViewById(R.id.layout_newpaper);
		layout_city = (RelativeLayout) findViewById(R.id.layout_city);
		layout_favourite = (RelativeLayout) findViewById(R.id.layout_Favourite);
		layout_aboutus = (RelativeLayout) findViewById(R.id.layout_aboutus);

		layout_img_newspaper = (LinearLayout) findViewById(R.id.layout_img_newspaper);
		layout_img_city = (LinearLayout) findViewById(R.id.layout_img_city);
		layout_img_favourite = (LinearLayout) findViewById(R.id.layout_img_favourite);
		layout_img_aboutus = (LinearLayout) findViewById(R.id.layout_img_aboutus);

		/*
		 * layout_newspaper.setBackgroundColor(color.footerBarColor);
		 * layout_city.setBackgroundColor(color.footerBarColor);
		 * layout_favourite.setBackgroundColor(color.footerBarColor);
		 * layout_aboutus.setBackgroundColor(color.footerBarColor);
		 */

		/*
		 * if(SCREEN == 1) layout_newspaper.setBackgroundColor(Color.DKGRAY);
		 * if(SCREEN == 2) layout_city.setBackgroundColor(Color.DKGRAY);
		 * if(SCREEN == 3) layout_favourite.setBackgroundColor(Color.DKGRAY);
		 * if(SCREEN == 4) layout_aboutus.setBackgroundColor(Color.DKGRAY);
		 */

		layout_newspaper.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				// finish();
				// layout_newspaper.setBackgroundDrawable(getResources().getDrawable(R.drawable.menuselector));
//				if (Constant.NEWS_SCREEN == 1) {
					Intent i = new Intent(getApplicationContext(),
							NewspaperActivity.class);
					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
					i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
					startActivity(i);
					finish();
//				} else if (Constant.NEWS_SCREEN == 2) {
//					Intent i = new Intent(getApplicationContext(),
//							CategoryActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				} else if (Constant.NEWS_SCREEN == 3) {
//					Intent i = new Intent(getApplicationContext(),
//							AdsActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				} else if (Constant.NEWS_SCREEN == 4) {
//					Intent i = new Intent(getApplicationContext(),
//							AdsDetailActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				}
				// overridePendingTransition(R.anim.slide_in_left,R.anim.slide_out_left);

			}
		});

		layout_city.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				// finish();'
//				if (Constant.CITY_SCREEN == 1) {
					Intent i = new Intent(getApplicationContext(),
							CityListActivity.class);
					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
					i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
					startActivity(i);
					finish();
//				} else if (Constant.CITY_SCREEN == 2) {
//					Intent i = new Intent(getApplicationContext(),
//							CityListToNewspaperActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				} else if (Constant.CITY_SCREEN == 3) {
//					Intent i = new Intent(getApplicationContext(),
//							CategoryActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				} else if (Constant.CITY_SCREEN == 4) {
//					Intent i = new Intent(getApplicationContext(),
//							AdsActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				}
//				else if (Constant.CITY_SCREEN == 5) {
//					Intent i = new Intent(getApplicationContext(),
//							AdsDetailActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				}
				// overridePendingTransition(R.anim.slide_in_left,R.anim.slide_out_left);

			}
		});

		layout_favourite.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				// finish();'layout_city.setBackgroundColor(Color.DKGRAY); '
				// finish();'
//				if (Constant.FAV_SCREEN == 1) {
					Intent i = new Intent(getApplicationContext(),
							FavoriteAdsActivity.class);
					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
					i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
					startActivity(i);
					finish();
//				} else if (Constant.FAV_SCREEN == 2) {
//					Intent i = new Intent(getApplicationContext(),
//							AdsDetailActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				}
				
				// overridePendingTransition(R.anim.slide_in_left,R.anim.slide_out_left);

			}
		});

		layout_aboutus.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				// finish();
//				if (Constant.INFO_SCREEN == 1) {
					Intent i = new Intent(getApplicationContext(),
							AboutUsActivity.class);
					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
					i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
					startActivity(i);
					finish();
//				} else if (Constant.INFO_SCREEN == 2) {
//					Intent i = new Intent(getApplicationContext(),
//							FeedbackActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				} else if (Constant.INFO_SCREEN == 3) {
//					Intent i = new Intent(getApplicationContext(),
//							ContactUsActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				} else if (Constant.INFO_SCREEN == 4) {
//					Intent i = new Intent(getApplicationContext(),
//							TermsOfUseActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				}
//				else if (Constant.INFO_SCREEN == 5) {
//					Intent i = new Intent(getApplicationContext(),
//							PrivacyActivity.class);
//					i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//					startActivity(i);
//				}
//			
				// overridePendingTransition(R.anim.slide_in_left,R.anim.slide_out_left);

			}
		});

	}
	
	
	
	

}