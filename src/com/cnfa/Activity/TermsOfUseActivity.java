package com.cnfa.Activity;

import java.io.InputStream;
import java.util.ArrayList;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

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
import com.cnfa.model.TermsOfUseModel;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.Utility;

public class TermsOfUseActivity extends TabbarActivity {
	private InputStream in = null;
	ArrayList<TermsOfUseModel> arr_terms = new ArrayList<TermsOfUseModel>();
	private TextView txtTermsofuse = null;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.termsofuse);
		layout_aboutus.setBackgroundResource(R.drawable.menuselector);
		layout_img_aboutus.setBackgroundResource(R.drawable.aboutusiconactive);
		Constant.INFO_SCREEN = 4;
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);

		txtTermsofuse = (TextView) findViewById(R.id.texttermsofuse);

		if (Utility.isOnline(getApplicationContext())) {
			new termsofuseTask(Constant.TERMS_OF_USE_URL).execute();
		} else {
			Constant.showMsg(getApplicationContext(),
					Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);
		}

	}

	public class termsofuseTask extends AsyncTask<String, Integer, String> {
		public String _url;

		public termsofuseTask(String url) {
			_url = url;
		}

		protected void onPreExecute() {

			CustomProgressDialog.showProgressDialog(TermsOfUseActivity.this,
					"", true);

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
				// StringUtils.popupDefinitionFromHTML(content, txtTermsofuse,
				// TermsOfUseActivity.this);
				txtTermsofuse.setAutoLinkMask(Linkify.ALL);
				txtTermsofuse.setLinkTextColor(getResources().getColor(
						R.color.lightgreen));
				txtTermsofuse.setText(Html.fromHtml(content));
			} catch (JSONException e) {
				Toast.makeText(TermsOfUseActivity.this,
						"Error! Content Not Available", Toast.LENGTH_SHORT)
						.show();
			}
			// //check for updation
			// ArrayList<TermsOfUseModel> listLocalData = new
			// ArrayList<TermsOfUseModel>();
			// listLocalData =
			// DbSync.getTermslocalData(getApplicationContext(),"aboutustable","Termsandcondition");
			// int check_for_deletion = 0;
			//
			// /*
			// * if record available in local data base then checking last
			// updated time
			// */
			//
			// if(listLocalData.size()>0){
			// for(int i = 0;i<arr_terms.size();i++){
			// for(int j = 0; j<listLocalData.size();j++){
			// if(!arr_terms.get(i).getLastUpdateTime().equals(listLocalData.get(j).getLastUpdateTime())){
			// check_for_deletion = 1;
			// break;
			// }
			//
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
			// DbSync.saveTermsandconditiondata(getApplicationContext(),arr_terms,"Termsandcondition");
			// arr_terms.clear();
			// arr_terms = listLocalData;
			// }
			// }
			// else{
			// /*
			// * save recard in local
			// */
			// boolean b = false;
			// b =
			// DbSync.saveTermsandconditiondata(getApplicationContext(),arr_terms,"Termsandcondition");
			//
			// }
			// if(listLocalData.size()>0){
			// arr_terms.clear();
			// arr_terms = listLocalData;
			// }
			//
			//
			// if(arr_terms.size()>0)
			// txtTermsofuse.setText(arr_terms.get(0).getContent());
			// else
			// Constant.showMsg(getApplicationContext(),
			// Constant.MSG_CONTENT_NOT_AVAILABLE);
			//
			//
			//
			//
			//
			//
			// if(arr_terms.size()>0)
			// txtTermsofuse.setText(arr_terms.get(0).getContent());
			// else
			// Constant.showMsg(getApplicationContext(),
			// Constant.MSG_CONTENT_NOT_AVAILABLE);
		}
	}

}
