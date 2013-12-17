package com.cnfa.category;

import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.cnfa.R;
import com.cnfa.Activity.AdsActivity;
import com.cnfa.constant.Constant;
import com.cnfa.model.CategoryModel;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.utility.Utility;


@SuppressLint("ValidFragment")
public class CategoryFragment extends Fragment {
	private Context mContext;
//	RadioAdapter adapter;
//	private GridView gridView;
	private ViewPager pager;
	private static final int PROGRESS_DIALOG = 0;
	private Context tempContext;
	private ArrayList<SearchAdsModel> searchAdsArraylist = new ArrayList<SearchAdsModel>();
	ProgressBar progress;
	private int _position = 0;
//	SessionManager prefMannager;
	private ArrayList<CategoryModel> categoryList;
	String activity_source_name=null;
	private String _newsPaperName;
	private String _cityName;
  
	public CategoryFragment(Context mContext2, ArrayList<CategoryModel> _list, int position, String newspapername,String cityName, String activity_name) {
    	categoryList = _list;
    	tempContext = mContext2;
    	_position = position;
    	_newsPaperName = newspapername;
    	this.activity_source_name=activity_name;
    	this._cityName = cityName;
	}
    

	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
      
    }
    
    public void SetContext(Context context){
    	this.mContext = context;
    }
 
   
    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
 
    }

	@Override
    public View onCreateView(LayoutInflater inflater, final ViewGroup container,
            Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.categorylayout, container, false);

    	progress = (ProgressBar)view.findViewById(R.id.progressBar1);;

        ImageView img1 = (ImageView)view.findViewById(R.id.imgelectronic);
        ImageView img2 = (ImageView)view.findViewById(R.id.imghome);
        ImageView img3 = (ImageView)view.findViewById(R.id.imgeducation);
        ImageView img4 = (ImageView)view.findViewById(R.id.imgjobs);
        ImageView img5 = (ImageView)view.findViewById(R.id.imgautomobiles);
        ImageView img6 = (ImageView)view.findViewById(R.id.imgservices);
        ImageView img7 = (ImageView)view.findViewById(R.id.imgelectronics2);
        ImageView img8 = (ImageView)view.findViewById(R.id.imghome2);
        ImageView img9 = (ImageView)view.findViewById(R.id.imgeducation2);
        
        TextView txt1 = (TextView)view.findViewById(R.id.txtelectronics);
        TextView txt2 = (TextView)view.findViewById(R.id.detailtxt);
        TextView txt3 = (TextView)view.findViewById(R.id.txtnews);
        TextView txt4 = (TextView)view.findViewById(R.id.txtdate);
        TextView txt5 = (TextView)view.findViewById(R.id.textView5);
        TextView txt6 = (TextView)view.findViewById(R.id.textView6);
        TextView txt7 = (TextView)view.findViewById(R.id.textView7);
        TextView txt8 = (TextView)view.findViewById(R.id.textView8);
        TextView txt9 = (TextView)view.findViewById(R.id.textView10);
        
        TextView txtCount1 = (TextView)view.findViewById(R.id.textcount1);
        TextView txtCount2 = (TextView)view.findViewById(R.id.textcount2);
        TextView txtCount3 = (TextView)view.findViewById(R.id.textcount3);
        TextView txtCount4 = (TextView)view.findViewById(R.id.textcount4);
        TextView txtCount5 = (TextView)view.findViewById(R.id.textcount5);
        TextView txtCount6 = (TextView)view.findViewById(R.id.textcount6);
        TextView txtCount7 = (TextView)view.findViewById(R.id.textcount7);
        TextView txtCount8 = (TextView)view.findViewById(R.id.textcount8);
        TextView txtCount9 = (TextView)view.findViewById(R.id.textcount9);
        
        txt1.setTypeface(Utility.setRegularFont(mContext));
        txt2.setTypeface(Utility.setRegularFont(mContext));
        txt3.setTypeface(Utility.setRegularFont(mContext));
        txt4.setTypeface(Utility.setRegularFont(mContext));
        txt5.setTypeface(Utility.setRegularFont(mContext));
        txt6.setTypeface(Utility.setRegularFont(mContext));
        txt7.setTypeface(Utility.setRegularFont(mContext));
        txt8.setTypeface(Utility.setRegularFont(mContext));
        txt9.setTypeface(Utility.setRegularFont(mContext));
        
        
        txtCount1.setTypeface(Utility.setRegularFont(mContext));
        txtCount2.setTypeface(Utility.setRegularFont(mContext));
        txtCount3.setTypeface(Utility.setRegularFont(mContext));
        txtCount4.setTypeface(Utility.setRegularFont(mContext));
        txtCount5.setTypeface(Utility.setRegularFont(mContext));
        txtCount6.setTypeface(Utility.setRegularFont(mContext));
        txtCount7.setTypeface(Utility.setRegularFont(mContext));
        txtCount8.setTypeface(Utility.setRegularFont(mContext));
        txtCount9.setTypeface(Utility.setRegularFont(mContext));
  
                
        RelativeLayout relNoficationCount1 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon1);
        RelativeLayout relNoficationCount2 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon2);
        RelativeLayout relNoficationCount3 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon3);
        RelativeLayout relNoficationCount4 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon4);
        RelativeLayout relNoficationCount5 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon5);
        RelativeLayout relNoficationCount6 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon6);
        RelativeLayout relNoficationCount7 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon7);
        RelativeLayout relNoficationCount8 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon8);
        RelativeLayout relNoficationCount9 = (RelativeLayout)view.findViewById(R.id.layoutnotificationicon9);

        		
        
    	LinearLayout layout_layoutelectronics = (LinearLayout)view.findViewById(R.id.layoutelectronics);
        LinearLayout layout_layouthome = (LinearLayout)view.findViewById(R.id.layouthome);
        LinearLayout layouteducation = (LinearLayout)view.findViewById(R.id.layouteducation);
        LinearLayout layout_layoutjob = (LinearLayout)view.findViewById(R.id.layoutjob);
        LinearLayout layout_layoutautomobiles = (LinearLayout)view.findViewById(R.id.layoutautomobiles);
        LinearLayout layout_layoutservice = (LinearLayout)view.findViewById(R.id.layoutservice);
        LinearLayout layout_layoutelectronics2 = (LinearLayout)view.findViewById(R.id.layoutelectronics2);
        LinearLayout layout_layouthome2 = (LinearLayout)view.findViewById(R.id.layouthome2);
        LinearLayout layout_layouteducation2 = (LinearLayout)view.findViewById(R.id.layouteducation2);
        
        
        
		 pager = (ViewPager) container.findViewById(R.id.view_pager);
		if(_position==2)
			_position=1;
		 for(int i=0;i<categoryList.size();i++){
			 final int index = i;
			 if(i==0){
			 img1.setImageBitmap(categoryList.get(i).getBitmap());
			 txt1.setText(categoryList.get(i).getCategory());
			 relNoficationCount1.setVisibility(View.VISIBLE);
			 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
				 txtCount1.setText("...");
			 else
			 txtCount1.setText(categoryList.get(i).getTotal_ads());
			  final String categoryName = categoryList.get(i).getCategory();
			 layout_layoutelectronics.setOnClickListener(new OnClickListener() {
					
					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

					}
				});
			 }
			 if(i==1){
				 img2.setImageBitmap(categoryList.get(i).getBitmap());
				 txt2.setText(categoryList.get(i).getCategory());
				 relNoficationCount2.setVisibility(View.VISIBLE);
				 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
					 txtCount2.setText("...");
				 else
					 txtCount2.setText(categoryList.get(i).getTotal_ads());
				  final String categoryName = categoryList.get(i).getCategory();

				 layout_layouthome.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// TODO Auto-generated method stub
							searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

						}
					});
			 }
			 if(i==2){
				 img3.setImageBitmap(categoryList.get(i).getBitmap());
				 txt3.setText(categoryList.get(i).getCategory());
				 relNoficationCount3.setVisibility(View.VISIBLE);
				 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
					 txtCount3.setText("...");
				 else
					 txtCount3.setText(categoryList.get(i).getTotal_ads());
				  final String categoryName = categoryList.get(i).getCategory();

				 layouteducation.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// TODO Auto-generated method stub
							searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

						}
					});
			 }
			 if(i==3){
				 img4.setImageBitmap(categoryList.get(i).getBitmap());
				 txt4.setText(categoryList.get(i).getCategory());
				 relNoficationCount4.setVisibility(View.VISIBLE);
				 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
					 txtCount4.setText("...");
				 else
					 txtCount4.setText(categoryList.get(i).getTotal_ads());				 
				  final String categoryName = categoryList.get(i).getCategory();

				 layout_layoutjob.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// TODO Auto-generated method stub
							searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

						}
					});
			 }
			 if(i==4){
				 img5.setImageBitmap(categoryList.get(i).getBitmap());
				 txt5.setText(categoryList.get(i).getCategory());
				 relNoficationCount5.setVisibility(View.VISIBLE);
				 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
					 txtCount5.setText("...");
				 else
					 txtCount5.setText(categoryList.get(i).getTotal_ads());				  final String categoryName = categoryList.get(i).getCategory();

				 layout_layoutautomobiles.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// TODO Auto-generated method stub
							searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

						}
					});
			 }
			 if(i==5){
				 img6.setImageBitmap(categoryList.get(i).getBitmap());
				 txt6.setText(categoryList.get(i).getCategory());
				 relNoficationCount6.setVisibility(View.VISIBLE);
				 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
					 txtCount6.setText("...");
				 else
					 txtCount6.setText(categoryList.get(i).getTotal_ads());				  final String categoryName = categoryList.get(i).getCategory();

				 layout_layoutservice.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// TODO Auto-generated method stub
							searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

						}
					});
			 }
			 if(i==6){
				 img7.setImageBitmap(categoryList.get(i).getBitmap());
				 txt7.setText(categoryList.get(i).getCategory());
				 relNoficationCount7.setVisibility(View.VISIBLE);
				 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
					 txtCount7.setText("...");
				 else
					 txtCount7.setText(categoryList.get(i).getTotal_ads());				  final String categoryName = categoryList.get(i).getCategory();

				 layout_layoutelectronics2.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// TODO Auto-generated method stub
							searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

						}
					});
			 }
			 if(i==7){
				 img8.setImageBitmap(categoryList.get(i).getBitmap());
				 txt8.setText(categoryList.get(i).getCategory());
				 relNoficationCount8.setVisibility(View.VISIBLE);
				 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
					 txtCount8.setText("...");
				 else
					 txtCount8.setText(categoryList.get(i).getTotal_ads());				  final String categoryName = categoryList.get(i).getCategory();

				 layout_layouthome2.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// TODO Auto-generated method stub
							searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

						}
					});
			 }
			 if(i==8){
				 img9.setImageBitmap(categoryList.get(i).getBitmap());
				 txt9.setText(categoryList.get(i).getCategory());
				 relNoficationCount9.setVisibility(View.VISIBLE);
				 if(Integer.parseInt(categoryList.get(i).getTotal_ads())>99)
					 txtCount9.setText("...");
				 else
					 txtCount9.setText(categoryList.get(i).getTotal_ads());				  final String categoryName = categoryList.get(i).getCategory();

				 layout_layouteducation2.setOnClickListener(new OnClickListener() {
						
						@Override
						public void onClick(View v) {
							// TODO Auto-generated method stub
							searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categoryList.get(index).getId(),categoryName);

						}
					});
			 }
			 
			 
		 }
		 
		 
		//adapter = new RadioAdapter(mContext, Constant.SEASON_ARRAY, RadioAdapter.LOGIN_SEASON_ADAPTER);
		
        
        return view;
    }
    
    public void searchAdsTask(String url, String searchString, String categoryName) {
		Intent intent = new Intent(tempContext,
				AdsActivity.class);
		
		intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
		intent.putExtra("searchads", searchAdsArraylist);
		intent.putExtra("newspapername", _newsPaperName);
		intent.putExtra("categoryname", categoryName);
		intent.putExtra("cityname", _cityName);
		intent.putExtra("ACTIVITY_NAME",activity_source_name);

		intent.putExtra("categroyId", searchString);
		startActivity(intent);
	}

	/*
	
	public class searchAdsTask extends AsyncTask<String, Integer, String> {
		public String _url, _searchstring,_categoryName;

		public searchAdsTask(String url, String searchString, String categoryName) {
			// TODO Auto-generated constructor stub
			_url = url;
			_searchstring = searchString;
			_categoryName = categoryName;
		}

		protected void onPreExecute() {
			//progress.setVisibility(View.VISIBLE);
			//((Activity) tempContext).showDialog(PROGRESS_DIALOG);
		}

		@Override
		protected String doInBackground(String... params) {
			InputStream in = HttpConnection.connect(_url+_searchstring);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);
				CategorySearchAdsParserHandler searchAdsparserHandler = new CategorySearchAdsParserHandler();
				searchAdsArraylist = searchAdsparserHandler
						.getParseDataByModel(res);
			}

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			//((Activity) tempContext).dismissDialog(PROGRESS_DIALOG);
			//progress.setVisibility(View.GONE);

			//check for updation
			
			Intent intent = new Intent(tempContext,
					AdsActivity.class);
			intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
			intent.putExtra("searchads", searchAdsArraylist);
			intent.putExtra("newspapername", _newsPaperName);
			intent.putExtra("categoryname", _categoryName);
			startActivity(intent);
			((Activity) tempContext).overridePendingTransition(R.anim.slide_in_left,
					R.anim.slide_out_left);
			
		}
	}*/
	
	
	protected Dialog onCreateDialog(int id) {
		switch (id) {
		case PROGRESS_DIALOG:
			ProgressDialog progDialog = new ProgressDialog(mContext);
			progDialog.setMessage("Please Wait...");
			progDialog.setCancelable(false);
			progDialog.show();

			return progDialog;

		}
		return null;
	}
}