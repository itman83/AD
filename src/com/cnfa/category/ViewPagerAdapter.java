package com.cnfa.category;


import java.util.ArrayList;

import android.content.Context;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import com.cnfa.model.CategoryModel;

public class ViewPagerAdapter extends FragmentPagerAdapter {
	private Context mContext;
	private ArrayList<CategoryModel> _list;
	private int totalPages = 0;
	private String _newsPaperName;
	private String _cityName;
	String activity_name=null;
	public ViewPagerAdapter(FragmentManager fm, Context context,ArrayList<CategoryModel> list, String newspaperName,String cityName, String activity_name) {
		super(fm);
		this.mContext = context;
 		this._list = list;
		this._newsPaperName = newspaperName;
		this.activity_name=activity_name;
		this._cityName = cityName;
	}

	@Override
	public int getCount() {
		int totalPages = _list.size()/9;
		if(_list.size()%9!=0)
			totalPages++;
		return totalPages;
	}
	@Override
	public int getItemPosition(Object object) {
	    return POSITION_NONE;
	}

	@Override
	public Fragment getItem(int position) {
		/*ArrayList<CategoryModel> _list2 = new ArrayList<CategoryModel>();
		for(int i=9;i<_list.size();i++){
			_list2.add(_list.get(i));
		}
		Fragment sFragment = new  CategoryFragment(mContext,_list2,position,_newsPaperName);
*/		/*Bundle args = new Bundle();
        // Our object is just an integer :-P
        args.putInt("test", position);
        sFragment.setArguments(args);

		//sFragment.SetContext(mContext);
*/		
		
		ArrayList<CategoryModel> _list2 = new ArrayList<CategoryModel>();
		int counter = 0;
		for(int i=position*9;i<_list.size();i++){
			
			if(counter<9)
			_list2.add(_list.get(i));
			counter++;
		}
		Fragment sFragment1 = new  CategoryFragment(mContext,_list2,position,_newsPaperName,_cityName,activity_name);
		return sFragment1;

		
	}	 
}
