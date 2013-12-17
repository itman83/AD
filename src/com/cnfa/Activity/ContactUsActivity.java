package com.cnfa.Activity;

import java.io.InputStream;
import java.util.ArrayList;

import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.util.Linkify;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.cnfa.R;
import com.cnfa.connection.HttpConnection;
import com.cnfa.constant.Constant;
import com.cnfa.model.ContactUsModel;
import com.cnfa.parser.ContactUsParserHandler;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.StringUtils;
import com.cnfa.utility.Utility;

public class ContactUsActivity extends TabbarActivity {
	private InputStream in = null;
	private TextView txtaddress, txtele, txtfax, txtmail, txtweb;
	private ImageView imgwiebo, imgtencent;
	ArrayList<ContactUsModel> arr_terms = new ArrayList<ContactUsModel>();
	RelativeLayout contentlayout;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState,R.layout.contactus);
		Constant.INFO_SCREEN = 3;
		layout_aboutus.setBackgroundResource(R.drawable.menuselector);
		layout_img_aboutus.setBackgroundResource(R.drawable.aboutusiconactive);
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
		Constant.INFO_SCREEN = 3;
		imgwiebo = (ImageView) findViewById(R.id.weibo);
		imgtencent = (ImageView) findViewById(R.id.tencent);

		contentlayout = (RelativeLayout) findViewById(R.id.contentlayout);

		imgwiebo.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				final Intent intent = new Intent(Intent.ACTION_VIEW)
						.setData(Uri.parse(Constant.URL_WEIBO));
				startActivity(intent);
			}
		});

		imgtencent.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				final Intent intent = new Intent(Intent.ACTION_VIEW)
						.setData(Uri.parse(Constant.URL_TENCENT));
				startActivity(intent);
			}
		});

		txtaddress = (TextView) findViewById(R.id.txtaddress2);
		txtele = (TextView) findViewById(R.id.txtphone);
		txtfax = (TextView) findViewById(R.id.txtfax);
		txtmail = (TextView) findViewById(R.id.txtmail);
		txtweb = (TextView) findViewById(R.id.txtweb);

		if (Utility.isOnline(getApplicationContext())) {
			new ContactUsTask(Constant.CONTACT_US_URL).execute();
		} else {
			Constant.showMsg(getApplicationContext(),
					Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);

		}
	}

	public class ContactUsTask extends AsyncTask<String, Integer, String> {
		public String _url;

		public ContactUsTask(String url) {
			_url = url;
		}

		protected void onPreExecute() {
			CustomProgressDialog.showProgressDialog(ContactUsActivity.this, "",
					true);

		}

		@Override
		protected String doInBackground(String... params) {
			in = HttpConnection.connect(_url);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);
				ContactUsParserHandler contactUsParserHandler = new ContactUsParserHandler();
				arr_terms = contactUsParserHandler.getParseDataByModel(res);
			}

			return null;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
		
			CustomProgressDialog.removeDialog();

			contentlayout.setVisibility(View.VISIBLE);
			if (arr_terms.size() > 0) {
				txtaddress.setText(arr_terms.get(0).getAddress());
				StringUtils.popupDefinition(arr_terms.get(0).getPhoneNo(),
						txtele, ContactUsActivity.this);
				// txtele.setText(arr_terms.get(0).getPhoneNo());
				txtfax.setText(arr_terms.get(0).getFaxNo());
				txtmail.setText(arr_terms.get(0).getMailId());
				txtweb.setText(arr_terms.get(0).getWebName());
			} else {
				txtaddress
						.setText("Block 2,121 Yonghua Street, Hangzhou, China");
				// txtele.setText("(86) 571 85331960");
				StringUtils.popupDefinition("(86) 571 85331960", txtele,
						ContactUsActivity.this);
				txtfax.setText("(86) 571 85331960");
				txtmail.setText("info@cnfanews.com");
				txtweb.setText("www.cnfanads.com");
			}
			// txtele.setLinkTextColor(getResources().getColor(R.color.linkcolor));
			txtmail.setLinkTextColor(getResources().getColor(R.color.linkcolor));
			txtweb.setLinkTextColor(getResources().getColor(R.color.linkcolor));

			// Linkify.addLinks(txtele, Linkify.ALL);
			// Linkify.addLinks(txtfax, Linkify.ALL);
			Linkify.addLinks(txtmail, Linkify.ALL);
			Linkify.addLinks(txtweb, Linkify.ALL);
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
