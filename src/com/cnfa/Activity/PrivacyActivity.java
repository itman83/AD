package com.cnfa.Activity;

import java.io.InputStream;
import java.util.ArrayList;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Html;
import android.text.util.Linkify;
import android.view.WindowManager;
import android.widget.TextView;
import android.widget.Toast;

import com.cnfa.R;
import com.cnfa.connection.HttpConnection;
import com.cnfa.constant.Constant;
import com.cnfa.db.DbSync;
import com.cnfa.model.ContactUsFeedbackModel;
import com.cnfa.model.PrivacyModel;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.Utility;

public class PrivacyActivity extends TabbarActivity{
	private InputStream in = null;
	ArrayList<PrivacyModel> arr_Privacy= new ArrayList<PrivacyModel>();
	private TextView txtPrivacy = null;
	Context c;

		public void onCreate(Bundle savedInstanceState) {
	        super.onCreate(savedInstanceState,R.layout.privacy);
	        layout_aboutus.setBackgroundResource(R.drawable.menuselector);
			layout_img_aboutus.setBackgroundResource(R.drawable.aboutusiconactive);
			getWindow().setSoftInputMode(
					WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
			Constant.INFO_SCREEN=5;

			
			txtPrivacy = (TextView)findViewById(R.id.texttermsofuse);
			
			
			if (Utility.isOnline(getApplicationContext())) {
				new privacyTask(Constant.PRIVACY_URL).execute();
			} else{
				Constant.showMsg(getApplicationContext(),
						Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);
			new privacyLoadLocalTask().execute();
			}

	 }
	 
		public class privacyLoadLocalTask extends AsyncTask<String, Integer, String> {
			ArrayList<ContactUsFeedbackModel> listLocalData = null;

			protected void onPreExecute() {
				CustomProgressDialog.showProgressDialog(PrivacyActivity.this,"", true);

			}

			@Override
			protected String doInBackground(String... params) {
				listLocalData = new ArrayList<ContactUsFeedbackModel>();
				listLocalData = DbSync.getAboutUslocalData(getApplicationContext(),"aboutustable","Privacy");
				return null;
			}

			protected void onProgressUpdate(Integer... progress) {

			}

			protected void onPostExecute(String result) {
				CustomProgressDialog.removeDialog();

				if(listLocalData.size()>0)
					txtPrivacy.setText(listLocalData.get(0).getContent());
				else
					Constant.showMsg(getApplicationContext(), Constant.MSG_CONTENT_NOT_AVAILABLE);
		
				
			}
		}

	 
	 
		public class privacyTask extends AsyncTask<String, Integer, String> {
			public String _url;

			public privacyTask(String url) {
				// TODO Auto-generated constructor stub
				_url=url;
			}

			protected void onPreExecute() {
			
				CustomProgressDialog.showProgressDialog(PrivacyActivity.this,"", true);

			}

			@Override
			protected String doInBackground(String... params) {
				in=HttpConnection.connect(_url);
				String res = null;
				if(in!=null){ 
				res=Utility.getString(in); 

				}
				
				return res;
			}

			protected void onProgressUpdate(Integer... progress) {

			}

			
			protected void onPostExecute(String result) {
				//dismissDialog(PROGRESS_DIALOG);
			//	progressbar.setVisibility(View.GONE);
				CustomProgressDialog.removeDialog();

				JSONObject object;
				try {
					object = (JSONObject) new JSONTokener(result).nextValue();
					String content=object.getString("content");
					txtPrivacy.setAutoLinkMask(Linkify.ALL);
					txtPrivacy.setLinkTextColor(getResources().getColor(R.color.lightgreen));
//					StringUtils.popupDefinition(content,txtPrivacy,PrivacyActivity.this);
					txtPrivacy.setText(Html.fromHtml(content));
				} catch (JSONException e) {
					Toast.makeText(PrivacyActivity.this,
							"Error! Content Not Available",
							Toast.LENGTH_SHORT).show();
				}
				
//				//check for updation
//				ArrayList<PrivacyModel> listLocalData = new ArrayList<PrivacyModel>();
//				listLocalData = DbSync.getPrivacylocalData(getApplicationContext(),"aboutustable","Privacy");
//				int check_for_deletion = 0;
//				
//				/*
//				 * if record available in local data base then checking last updated time
//				 */
//				
//				if(listLocalData.size()>0){
//				for(int i = 0;i<arr_Privacy.size();i++){
//					for(int j = 0; j<listLocalData.size();j++){
//						if(!arr_Privacy.get(i).getLastUpdateTime().equals(listLocalData.get(j).getLastUpdateTime())){
//							check_for_deletion = 1;
//							break;
//						}
//						
//					}
//				}
//				
//				
//				//remove all records
//				if(check_for_deletion == 1){
//				boolean b_delete = DbSync.deleteRecord(getApplicationContext(),"aboutustable");
//				boolean b = false;
//				b = DbSync.savePrivacydata(getApplicationContext(),arr_Privacy,"Privacy");
//				arr_Privacy.clear();
//				arr_Privacy = listLocalData;
//				}
//				}
//				else{
//					/*
//					 * save recard in local
//					 */
//					boolean b = false;
//					b = DbSync.savePrivacydata(getApplicationContext(),arr_Privacy,"Privacy");
//			
//				}
//				if(listLocalData.size()>0){
//					arr_Privacy.clear();
//					arr_Privacy = listLocalData;
//				}
//				
//
//				if(arr_Privacy.size()>0)
//					txtPrivacy.setText(arr_Privacy.get(0).getContent());
//				else
//					Constant.showMsg(getApplicationContext(), Constant.MSG_CONTENT_NOT_AVAILABLE);
//				
//				
//				
//				
//				
//				
//				
//				if(arr_Privacy.size()>0)
//					txtPrivacy.setText(arr_Privacy.get(0).getContent());
//				else
//					Constant.showMsg(getApplicationContext(), Constant.MSG_CONTENT_NOT_AVAILABLE);
			}
		}
		
		
		

		@Override
		protected void onResume() {
			// TODO Auto-generated method stub
			super.onResume();
			
		
		    c = PrivacyActivity.this;
		    Constant.activity.add(c);
			   
	
			layout_aboutus.setBackgroundDrawable(getResources().getDrawable(
					R.drawable.menuselector));
			layout_img_aboutus.setBackgroundDrawable(getResources().getDrawable(
					R.drawable.aboutusiconactive));
		}

}
