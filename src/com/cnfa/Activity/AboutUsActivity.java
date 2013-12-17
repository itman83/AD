package com.cnfa.Activity;

import java.io.InputStream;
import java.util.ArrayList;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.cnfa.R;
import com.cnfa.connection.HttpConnection;
import com.cnfa.constant.Constant;
import com.cnfa.model.ContactUsModel;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.Utility;

public class AboutUsActivity extends TabbarActivity {
	private InputStream in = null;
	ArrayList<ContactUsModel> arr_aboutUs = new ArrayList<ContactUsModel>();
	private TextView txtAboutUs = null;
	private Button btn_Privacy, btn_termofuse, btn_feedback, btn_ContactUs;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState,R.layout.aboutus);
		layout_aboutus.setBackgroundResource(R.drawable.menuselector);
		layout_img_aboutus.setBackgroundResource(R.drawable.aboutusiconactive);
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
		Constant.INFO_SCREEN = 1;

		txtAboutUs = (TextView) findViewById(R.id.texttermsofuse);
		btn_Privacy = (Button) findViewById(R.id.btn_privacy);
		btn_termofuse = (Button) findViewById(R.id.btn_termsofuse);
		btn_feedback = (Button) findViewById(R.id.btn_feedback);
		btn_ContactUs = (Button) findViewById(R.id.btn_contactus);
		btn_Privacy.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {

				Intent intent = new Intent(getApplicationContext(),
						PrivacyActivity.class);
				startActivity(intent);

			}
		});

		btn_termofuse.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {

				Intent intent = new Intent(getApplicationContext(),
						TermsOfUseActivity.class);
				startActivity(intent);

			}
		});

		btn_feedback.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(getApplicationContext(),
						FeedbackActivity.class);
				//intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				startActivity(intent);

			}
		});

		btn_ContactUs.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(getApplicationContext(),
						ContactUsActivity.class);
				// intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				startActivity(intent);
			}
		});

		if (Utility.isOnline(getApplicationContext())) {
			new aboutUsTask(Constant.ABOUT_US_URL).execute();
		} else {
			Constant.showMsg(getApplicationContext(),
					Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);

		}

	}

	public class aboutUsTask extends AsyncTask<String, Integer, String> {
		public String _url;

		public aboutUsTask(String url) {
			_url = url;
		}

		protected void onPreExecute() {

			CustomProgressDialog.showProgressDialog(AboutUsActivity.this, "",
					true);

		}

		@Override
		protected String doInBackground(String... params) {
			in = HttpConnection.connect(_url);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);

			}

			return res;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {

			CustomProgressDialog.removeDialog();

			JSONObject object;
			try {
				object = (JSONObject) new JSONTokener(result).nextValue();
				String content = object.getString("content");
				txtAboutUs.setText(Html.fromHtml(content));
			} catch (JSONException e) {
				Toast.makeText(AboutUsActivity.this,
						"Error! Content Not Available", Toast.LENGTH_SHORT)
						.show();
			}

			// //check for updation
			// ArrayList<AboutUsModel> listLocalData = new
			// ArrayList<AboutUsModel>();
			// listLocalData
			// =DbSync.getAboutUslocalData(getApplicationContext(),"aboutustable","aboutus");
			// int check_for_deletion = 0;
			//
			// /*
			// * if record available in local data base then checking last
			// updated time
			// */
			//
			// if(listLocalData.size()>0){
			// for(int i = 0;i<arr_aboutUs.size();i++){
			// for(int j = 0; j<listLocalData.size();j++){
			// if(arr_aboutUs.get(i).getLastUpdateTime()!=null &&
			// listLocalData.get(j).getLastUpdateTime()!= null){
			// if(!arr_aboutUs.get(i).getLastUpdateTime().equals(listLocalData.get(j).getLastUpdateTime())){
			// check_for_deletion = 1;
			// break;
			// }
			// }
			// }
			// }
			//
			//
			// //remove all records
			// if(check_for_deletion == 1){
			// boolean b_delete =
			// DbSync.deleteRecord(getApplicationContext(),"aboutustable");
			// boolean b = false;
			// b =
			// DbSync.saveAboutUsdata(getApplicationContext(),arr_aboutUs,"aboutus");
			// arr_aboutUs.clear();
			// arr_aboutUs = listLocalData;
			// }
			// }
			// else{
			// /*
			// * save recard in local
			// */
			// boolean b = false;
			// b =
			// DbSync.saveAboutUsdata(getApplicationContext(),arr_aboutUs,"aboutus");
			//
			// }
			// if(listLocalData.size()>0){
			// arr_aboutUs.clear();
			// arr_aboutUs = listLocalData;
			// }
			//
			//
			// if(arr_aboutUs.size()>0){
			// if(arr_aboutUs.get(0).getContent()!=null)
			// txtAboutUs.setText(Html.fromHtml(arr_aboutUs.get(0).getContent()));
			// }
			// else
			// Constant.showMsg(getApplicationContext(),
			// Constant.MSG_CONTENT_NOT_AVAILABLE);
		}
	}

}
