package com.cnfa.Activity;

import java.io.InputStream;

import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;

import com.cnfa.R;
import com.cnfa.connection.HttpConnection;
import com.cnfa.constant.Constant;
import com.cnfa.parser.FeedbackParserHandler;
import com.cnfa.tab.TabbarActivity;
import com.cnfa.utility.CustomProgressDialog;
import com.cnfa.utility.Utility;

public class FeedbackActivity extends TabbarActivity {
	private InputStream in = null;
	private EditText edName, edEmail, edPhone, edCity, edMessage;
	private Button btn_submit;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState,R.layout.feedback);
		layout_aboutus.setBackgroundResource(R.drawable.menuselector);
		layout_img_aboutus.setBackgroundResource(R.drawable.aboutusiconactive);
		Constant.INFO_SCREEN=2;
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
		Constant.INFO_SCREEN=2;
         edName = (EditText) findViewById(R.id.edname);
		edEmail = (EditText) findViewById(R.id.edemail);
		edPhone = (EditText) findViewById(R.id.edphone);
		edCity = (EditText) findViewById(R.id.edcity);
		edMessage = (EditText) findViewById(R.id.edmessage);

		btn_submit = (Button) findViewById(R.id.btn_submit);

		btn_submit.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {

				if (edName.getText().toString().trim().length()>0) {
					if (edEmail.getText().toString().trim().length()>0) {
						if (Constant.validateEmailID(edEmail.getText().toString().trim())) {
								if (Utility
											.isOnline(getApplicationContext())) {
										new feedBackTask(Constant.FEED_BACK_URL, edName.getText().toString(),edEmail.getText().toString(),edPhone.getText().toString(),	edCity.getText().toString(),edMessage.getText().toString()).execute();
										} else
										Constant.showMsg(
												getApplicationContext(),
												Constant.MSG_NETWORK_CONNECTION_NOT_AVAILABLE);
							
						} else
							Constant.showMsg(getApplicationContext(), "请输入有效的电子邮件地址。");
					} else
						Constant.showMsg(getApplicationContext(), "请输入所需的字段");
				} else
					Constant.showMsg(getApplicationContext(), "请输入有效的电子邮件地址。");

			}

		});

	}

	public class feedBackTask extends AsyncTask<String, Integer, String> {

		private String _name, _email, _phone, _city, _message, _url;
		private String queryString = null;
		private String result = "";
		public feedBackTask(String url, String name, String email,
				String phone, String city, String message) {
			_name = name;
			_email = email;
			_phone = phone;
			_city = city;
			_message = message;
			_url = url;
			queryString = "&name=" + _name + "&email=" + _email + "&phone="
					+ _phone + "&subject=" + _city + "&message=" + _message;
			_url = _url + "&" + queryString;
		}

		protected void onPreExecute() {
			CustomProgressDialog.showProgressDialog(FeedbackActivity.this,"", true);

		}

		@Override
		protected String doInBackground(String... params) {
			in = HttpConnection.connect(_url);
			String res = null;
			if (in != null) {
				res = Utility.getString(in);
				FeedbackParserHandler feedbackparser = new FeedbackParserHandler();
				result = feedbackparser.getParseDataByModel(res);
				
			}
			return result;
		}

		protected void onProgressUpdate(Integer... progress) {

		}

		protected void onPostExecute(String result) {
			CustomProgressDialog.removeDialog();

			Constant.showMsg(getApplicationContext(), "谢谢您的宝贵意见。");
			finish();
		}
	}

	

	
}
