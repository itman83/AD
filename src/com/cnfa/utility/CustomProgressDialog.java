/*
 * Copyright (C) 2013 Elo Touch Solutions, Inc. All Rights Reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.cnfa.utility;


import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.cnfa.R;



public class CustomProgressDialog
{
	private static Dialog mDialog = null;

	public CustomProgressDialog() 
	{
		super();
	}

	public static void showProgressDialog(Context mContext, String text, boolean cancellable) 
	{
		removeDialog();
		mDialog = new Dialog(mContext,	android.R.style.Theme_Translucent_NoTitleBar);
		LayoutInflater mInflater = LayoutInflater.from(mContext);
		View layout = mInflater.inflate(R.layout.progress_dialog, null);
		mDialog.setContentView(layout);
		TextView tvProgressDescription = (TextView) layout.findViewById(R.id.progressdescription);
		if (text.equals("")){
			tvProgressDescription.setVisibility(View.GONE);
		}
		else{
			tvProgressDescription.setText(text);
		}
		mDialog.setOnKeyListener(new DialogInterface.OnKeyListener()
		{
			public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event){
				switch (keyCode){
				case KeyEvent.KEYCODE_BACK:
					//HttpServer.isConnectivity = true;
					//mDialog.dismiss();
					removeDialog();
					return true;
				case KeyEvent.KEYCODE_SEARCH:
					return true;
				}

				return false;
			}
		});
		mDialog.setCancelable(cancellable);
		if (mDialog != null) 
		{
			try {
				mDialog.show();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	public static void removeDialog(){
		if (mDialog != null) {
			mDialog.dismiss();
			mDialog = null;
		}
	}
	
	
	
}
