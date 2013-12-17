package com.cnfa.Activity;

import java.io.InputStream;
import java.util.ArrayList;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.DisplayMetrics;
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
import com.cnfa.connection.HttpConnection;
import com.cnfa.constant.Constant;
import com.cnfa.model.ADDetailComponent;
import com.cnfa.model.SearchAdsModel;
import com.cnfa.parser.CategorySearchAdsParserHandler;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.StringUtils;
import com.cnfa.utility.Utility;

public class AdsActivity extends TabbarActivity{
	private MySearchListAdapter myadapter = null;
	private ArrayList<SearchAdsModel> searchAdsList;
	private ListView listView;
	private ImageView btnSearch;
	private EditText edSearch;
	private TextView textcity;
	private String _newsPaperName,_categoryName;
	private String bottomText,breadcrumbtext;
	private ArrayList<SearchAdsModel> searchAdsArraylist = new ArrayList<SearchAdsModel>();
	String activity_source_name=null;
	DisplayMetrics metrics;
	private String cityName;
	@SuppressWarnings({ "deprecation", "unchecked" })
		public void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState,R.layout.adslist);
	        Constant.NEWS_SCREEN=3;
			Constant.CITY_SCREEN=4;
	        activity_source_name=getIntent().getStringExtra("ACTIVITY_NAME");
		
				_newsPaperName = getIntent().getExtras().getString("newspapername");
				_categoryName = getIntent().getExtras().getString("categoryname");
				 cityName = getIntent().getExtras().getString("cityname");

			
			textcity = (TextView)findViewById(R.id.textcity);
	        listView = (ListView)findViewById(R.id.listView1);
			edSearch = (EditText)findViewById(R.id.edt_search_adactivity);
			edSearch.setTypeface(Utility.setRegularFont(getApplicationContext()));
			btnSearch = (ImageView)findViewById(R.id.btnsearch_adlist);

			 btnSearch.setOnClickListener(new OnClickListener() {
				
				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					if (edSearch.getText().toString().length() > 0) {
						Intent intent = new Intent(AdsActivity.this,
								SearchAdsActivity.class);
						intent.putExtra("ACTIVITY_NAME",activity_source_name);
						intent.putExtra("SEARCH_WORD", edSearch.getText()
								.toString());
						startActivity(intent);
					}
//					String answerString = edSearch.getText().toString();
//					// if(answerString.length() >= 0){
//					ArrayList<SearchAdsModel> al2 = new ArrayList<SearchAdsModel>();
//
//					al2 = performSearch(answerString);
//					myadapter = new MySearchListAdapter(AdsActivity.this,
//							al2);
//					 listView.setAdapter(myadapter);
					 
				}
			});
			 
			 
			 Intent intent = getIntent();
			 searchAdsList = (ArrayList<SearchAdsModel>)intent.getSerializableExtra("searchads");
			
			 
			 
			 if(_newsPaperName != null){
				 if(cityName != null)
			 breadcrumbtext = cityName+">>"+_newsPaperName+">>"+_categoryName;
			 else
				 breadcrumbtext = _newsPaperName+">>"+_categoryName;
				 
				 textcity.setText(breadcrumbtext);
				 textcity.setTypeface(Utility.setRegularFont(getApplicationContext()));

			
			 }
			 
			 String categroyId = getIntent().getExtras().getString("categroyId");
			 String categoryName = getIntent().getExtras().getString("categoryname");
			 
			 if (Utility.isOnline(getApplicationContext())) {
				 new searchAdsTask(Constant.FIND_ADS_FROM_CATEGORY,categroyId,categoryName).execute();
				} else{
					Constant.showMsg(getApplicationContext(),
							Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);
			}
			 

	 }  
	 
	 
		public class MySearchListAdapter extends BaseAdapter {
			private final Activity context;
			ArrayList<SearchAdsModel> list = new ArrayList<SearchAdsModel>();
			private SearchAdsModel obj=null;
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
				

				final TextView txtTitle = (TextView)rowView.findViewById(R.id.txttitle);
				final TextView txtdetail = (TextView)rowView.findViewById(R.id.detailtxt);
				final TextView txtcity = (TextView)rowView.findViewById(R.id.txtcityname);
				final TextView txtnews = (TextView)rowView.findViewById(R.id.txtnews);
				final TextView txtdate = (TextView)rowView.findViewById(R.id.txtdate);
				final ImageView btnShare = (ImageView)rowView.findViewById(R.id.sharebutton);
				txtTitle.setText(list.get(position).getAdsTitle());
				String str=list.get(position).getAdsDescription();
				
				StringUtils.popupDefinition(str,txtdetail,AdsActivity.this);
				
				//StringUtils.removeUnderlines((Spannable)txtdetail.getText());
//				txtdetail.setAutoLinkMask(Linkify.PHONE_NUMBERS);
//				txtdetail.setLinkTextColor(getResources().getColor(R.color.lightgreen));
//				txtdetail.setAutoLinkMask(Linkify.PHONE_NUMBERS);
//				txtdetail.setLinkTextColor(getResources().getColor(R.color.lightgreen));
//				txtdetail.setLinksClickable(true);
//				StringUtils.setTextViewHTML(txtdetail, "<HTML>"+str+"</HTML>",AdsActivity.this);
//				stripUnderlines(txtdetail,str);
//				SpannableStringBuilder text=new SpannableStringBuilder(str);
//				txtdetail.setMovementMethod(LinkMovementMethod.getInstance());
//				txtdetail.setText(str);
				
				txtcity.setText(list.get(position).getCity() + " | ");
				//String str=list.get(position).getNewspaperName();
				txtnews.setText(list.get(position).getNewspaperName()  + " | ");
				txtdate.setText(list.get(position).getCreationTime());
				
				bottomText = _newsPaperName + " | "+list.get(position).getCity()  + " | "+list.get(position).getCreationTime();
				
				txtTitle.setTypeface(Utility.setRegularFont(getApplicationContext()));
				txtdetail.setTypeface(Utility.setRegularFont(getApplicationContext()));
				txtcity.setTypeface(Utility.setRegularFont(getApplicationContext()));
				txtnews.setTypeface(Utility.setRegularFont(getApplicationContext()));
				txtdate.setTypeface(Utility.setRegularFont(getApplicationContext()));
				
				//if(position%2!=0)
				//	rowView.setBackgroundResource(R.drawable.darkrow);
				
				
				
				btnShare.setOnClickListener(new OnClickListener() {
					
					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						Constant.shareText(context, list.get(position).getAdsTitle(), list.get(position).getAdsDescription());
						/*Intent intent = new Intent(getApplicationContext(),
								ShareActivity.class);
						intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
						intent.putExtra("title", list.get(position).getAdsTitle());
						intent.putExtra("desc", list.get(position).getAdsDescription());
						startActivity(intent);
						overridePendingTransition(R.anim.slide_in_left,
								R.anim.slide_out_left);*/
					}
				});
				
				
				rowView.setOnClickListener(new OnClickListener() {

					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
					//	obj = list.get(position);
						ArrayList<ADDetailComponent> liArrayList=new ArrayList<ADDetailComponent>();
						for(int i=0;i<list.size();i++)
						{
							obj = list.get(i);
							ADDetailComponent adDetailComponent=new ADDetailComponent();
							adDetailComponent.id=obj.getId();
							adDetailComponent.adsDescription=obj.getAdsDescription();
							adDetailComponent.adsTitle=obj.getAdsTitle();
							adDetailComponent.categoryId=obj.getCategoryId();
							adDetailComponent.city=obj.getCity();
							adDetailComponent.cityName=obj.getCityName();
							adDetailComponent.creationTime=obj.getCreationTime();
							adDetailComponent.status=obj.getStatus();
							adDetailComponent.newspaperName=obj.getNewspaperName();
							adDetailComponent.updateTime=obj.getUpdateTime();

							liArrayList.add(adDetailComponent);
						}
						Intent intent = new Intent(getApplicationContext(),
								CopyOfAdsDetailActivity.class);
						//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
						intent.putParcelableArrayListExtra("data", liArrayList);
						intent.putExtra("ADS_ROW_PRESSED", position);
						intent.putExtra("bottomtext", bottomText);
						intent.putExtra("breadcrumbtext", breadcrumbtext);
						intent.putExtra("ACTIVITY_NAME",activity_source_name);
						intent.putExtra("CURR_PAGE", position);

					/*	intent.putExtra("detail", list.get(position).getAdsDescription());
						intent.putExtra("cityname", list.get(position).getCity());
						intent.putExtra("date", list.get(position).getCreationTime());
				*/		startActivity(intent);
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
		
		@SuppressLint("DefaultLocale")
		public ArrayList<SearchAdsModel> performSearch(String searchString) {
			ArrayList<SearchAdsModel> filterData = new ArrayList<SearchAdsModel>();
			for (int i = 0; i < searchAdsList.size(); i++) {
				if (searchAdsList.get(i).getAdsTitle().toLowerCase().contains(searchString.toLowerCase()) || searchAdsList.get(i).getAdsDescription().toLowerCase().contains(searchString.toLowerCase()) || searchAdsList.get(i).getCreationTime().toLowerCase().contains(searchString.toLowerCase())) {
					filterData.add(searchAdsList.get(i));
				}
			}
			return filterData;
		}

//		private void stripUnderlines(TextView textView,String str) {
//			SpannableStringBuilder text=new SpannableStringBuilder(str);
//
//	        Spannable s = (Spannable)text;
//	        URLSpan[] spans = s.getSpans(0, s.length(), URLSpan.class);
//	        for (URLSpan span: spans) {
//	            int start = s.getSpanStart(span);
//	            int end = s.getSpanEnd(span);
//	            s.removeSpan(span);
//	            span = new URLSpanNoUnderline(span.getURL());
//	            s.setSpan(span, start, end, 0);
//	        }
//	        textView.setText(s);
//	    }
	       
		
		
		
		
//	private class URLSpanNoUnderline extends URLSpan {
//	        public URLSpanNoUnderline(String url) {
//	            super(url);
//	        }
//	        @Override public void updateDrawState(TextPaint ds) {
//	            super.updateDrawState(ds);
//	            ds.setUnderlineText(false);
//	        }
//	    }
		
		public class searchAdsTask extends AsyncTask<String, Integer, String> {
			public String _url, _searchstring,_categoryName;

			public searchAdsTask(String url, String searchString, String categoryName) {
				// TODO Auto-generated constructor stub
				_url = url;
				_searchstring = searchString;
				_categoryName = categoryName;
			}

			protected void onPreExecute() {
				CustomProgressDialog.showProgressDialog(AdsActivity.this,"", true);

			}

			@Override
			protected String doInBackground(String... params) {
				InputStream in = HttpConnection.connect(_url+_searchstring);
				String res = null;
				if (in != null) {
					res = Utility.getString(in);
					CategorySearchAdsParserHandler searchAdsparserHandler = new CategorySearchAdsParserHandler();
					searchAdsArraylist = searchAdsparserHandler
							.getParseDataByModel(res,_newsPaperName);
				}

				return null;
			}

			protected void onProgressUpdate(Integer... progress) {

			}

			protected void onPostExecute(String result) {
				 myadapter = new MySearchListAdapter(AdsActivity.this,
						 searchAdsArraylist);
				 listView.setAdapter(myadapter);
				 CustomProgressDialog.removeDialog();
			}
		}
		
		
		@Override
		protected void onResume() {
		    super.onResume();
		    
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
			
		}
}
