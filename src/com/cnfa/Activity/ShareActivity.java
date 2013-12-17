/*package com.cnfa.Activity;

import java.util.ArrayList;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.text.InputType;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.cnfa.R;
import com.cnfa.constant.Constant;
import com.cnfa.tab.TabbarActivity;

public class ShareActivity extends TabbarActivity {
	private ImageView shareWechat, shareWeibo, shareTencens, shareSms,
			shareEmail;
	private String title, description;

	@SuppressWarnings("deprecation")
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.share);
		// setContentView(R.layout.citylist);
		getWindow().setSoftInputMode(
				WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);

		shareWechat = (ImageView)findViewById(R.id.share1);
		shareWeibo = (ImageView)findViewById(R.id.share2);
		shareTencens = (ImageView)findViewById(R.id.share3);
		shareSms = (ImageView)findViewById(R.id.smsicon);
		shareEmail = (ImageView)findViewById(R.id.emailicon);
		
		title = getIntent().getStringExtra("title");
		description = getIntent().getStringExtra("desc");
		
		shareWechat.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub

			}
		});

		shareWeibo.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub

			}
		});

		shareTencens.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub

			}
		});

		shareSms.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				showSmsDialog();
			}
		});

		shareEmail.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				sendEmail();
			}
		});

	}
	
	public void sendEmail(){
		Intent i = new Intent(Intent.ACTION_SEND);
		i.setType("text/plain");
		i.putExtra(Intent.EXTRA_EMAIL  , new String[]{""});
		i.putExtra(Intent.EXTRA_SUBJECT, title);
		i.putExtra(Intent.EXTRA_TEXT   , description);
		try {
		    startActivity(Intent.createChooser(i, "Send mail..."));
		} catch (android.content.ActivityNotFoundException ex) {
		    Toast.makeText(ShareActivity.this, "There are no email clients installed.", Toast.LENGTH_SHORT).show();
		}
	}
	
	public void showSmsDialog(){
	 AlertDialog.Builder alert = new AlertDialog.Builder(this);

     alert.setMessage("Share via sms");
     // Set an EditText view to get user input 
     final EditText edSms = new EditText(this);
     edSms.setInputType(InputType.TYPE_CLASS_NUMBER);
     alert.setView(edSms);

     alert.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
     public void onClick(DialogInterface dialog, int whichButton) {
       String number = edSms.getText().toString();
       // Do something with value!
       if(!number.equals(""))
    	   sendLongSMS(number,title);
       else
    	   Constant.showMsg(getApplicationContext(), Constant.MSG_SENT_SUCCESSFULLY);
       }
     });
     
     alert.show();
	}
	
	
	private void sendinitialmsg(String number, String message)
	  { 
		SmsManager smsManager = SmsManager.getDefault();
	    smsManager.sendTextMessage(number, null, message, null, null);
	    }
	
	public void sendLongSMS(String number, String _message) {
		 
	    String phoneNumber = number;
	    String message = _message;

	    SmsManager smsManager = SmsManager.getDefault();
	    ArrayList<String> parts = smsManager.divideMessage(message); 
	    smsManager.sendMultipartTextMessage(phoneNumber, null, parts, null, null);
	}
}
*/