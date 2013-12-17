package com.cnfa.category;

import java.util.ArrayList;

import android.content.Context;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;

import com.cnfa.model.ADDetailComponent;
import com.viewpagerindicator.IconPagerAdapter;

public class ViewPagerADsDetailAdapter extends FragmentStatePagerAdapter implements IconPagerAdapter {
	private ArrayList<ADDetailComponent> _list;
	Context mContext;
	String btext;
	int adsPosition;
	int totalPages;
	public ViewPagerADsDetailAdapter(FragmentManager fm,Context context,ArrayList<ADDetailComponent> list,String btext,int adsPosition) {
		super(fm);
 		this._list = list;
 		this.mContext=context;
 		this.btext=btext;
 		this.adsPosition=adsPosition;
	}

	@Override
	public Fragment getItem(int position) {
		   return new AdsDetailFragment(mContext,_list.get(position),btext);

	}

	@Override
	public int getCount() {
	 totalPages = _list.size();
		return totalPages;
	}

	@Override
	public int getIconResId(int index) {
		// TODO Auto-generated method stub
		return 0;
	}
	 public void setCount(int count) {
	        if (count > 0 && count <= 10) {
	        	totalPages = count;
	            notifyDataSetChanged();
	        }
	    }
	

}
