package com.cnfa.utility;

import android.content.Context;
import android.content.Intent;
import android.graphics.Typeface;
import android.net.Uri;
import android.text.TextPaint;
import android.text.style.ClickableSpan;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.cnfa.R;

public class ActivitySpan extends ClickableSpan {
	String keyword;
	Context mContext;
	PopupWindow pwindo;
	DisplayMetrics metrics;
	int popWindoWidth;

	public ActivitySpan(String keyword, Context context) {
		super();
		this.keyword = keyword;
		this.mContext = context;
		metrics = new DisplayMetrics();
		popWindoWidth = (int) (metrics.widthPixels * .75);
	}

	@Override
	public void onClick(View v) {
		TextView phoneTextView;
		LinearLayout linearLayout;
		LayoutInflater inflater = (LayoutInflater) mContext
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		View layout = inflater.inflate(R.layout.alert_on_click_phoneno, null);
		linearLayout = (LinearLayout) layout.findViewById(R.id.ll_alert);
		phoneTextView = (TextView) layout.findViewById(R.id.txt_phone_on_alert);
		phoneTextView.setText(keyword);
		pwindo = new PopupWindow(layout, 400,
				LinearLayout.LayoutParams.WRAP_CONTENT, true);
		pwindo.showAtLocation(layout, Gravity.CENTER, 0, 0);
		// button call
		Button btnCall = new Button(mContext);
		btnCall.setTextColor(mContext.getResources().getColor(
				android.R.color.holo_blue_dark));
		btnCall.setTypeface(null, Typeface.BOLD);
		btnCall.setGravity(Gravity.CENTER);
		LinearLayout.LayoutParams btnCalllayout = new LinearLayout.LayoutParams(
				LinearLayout.LayoutParams.WRAP_CONTENT,
				LinearLayout.LayoutParams.WRAP_CONTENT, 1);
		// button cancel
		Button btnCancel = new Button(mContext);
		btnCancel.setGravity(Gravity.CENTER);
		btnCancel.setTextColor(mContext.getResources().getColor(
				android.R.color.holo_blue_dark));
		LinearLayout.LayoutParams btnCancellayout = new LinearLayout.LayoutParams(
				LinearLayout.LayoutParams.WRAP_CONTENT,
				LinearLayout.LayoutParams.WRAP_CONTENT, 1);
		btnCall.setText(R.string.call);
		btnCancel.setText(R.string.cancel);
//		if (Cache.language == "en") {
//
//			linearLayout.addView(btnCancel, btnCancellayout);
//			linearLayout.addView(btnCall, btnCalllayout);
//		} else {
			linearLayout.addView(btnCall, btnCalllayout);
			linearLayout.addView(btnCancel, btnCancellayout);

//		}

		btnCall.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {

				Intent callIntent = new Intent(Intent.ACTION_CALL);
				callIntent.setData(Uri.parse("tel:" + keyword));
				mContext.startActivity(callIntent);
				pwindo.dismiss();
			}

		});

		btnCancel.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				pwindo.dismiss();
			}

		});

	}

	public void updateDrawState(TextPaint ds) {
		ds.setUnderlineText(false);
	}
}