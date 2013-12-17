package com.cnfa.Activity;

import java.util.Locale;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.view.MotionEvent;

import com.cnfa.R;
import com.cnfa.utility.Cache;

public class SplashActivity extends Activity {
	/** Called when the activity is first created. */
	protected boolean _active = true;
	protected int _splashTime = 2000;
	String xmlData = null;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.splash);

		Locale current = getResources().getConfiguration().locale;
		if (current.getLanguage().equals("zh"))
			Cache.language = "zh";
		else

			Cache.language = "en";

		Thread splashTread = new Thread() {
			@Override
			public void run() {
				try {
					int waited = 0;
					while (_active && (waited < _splashTime)) {
						sleep(100);
						if (_active) {
							waited += 100;
						}
					}
				} catch (InterruptedException e) {
				} finally {
					// updateStart();
					finish();
					startMainScreen();
				}
			}
		};
		splashTread.start();
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
	}

	private void startMainScreen() {
		Intent i = new Intent(getApplicationContext(), NewspaperActivity.class);
		startActivity(i);
	}

	@Override
	public boolean onTouchEvent(MotionEvent event) {
		if (event.getAction() == MotionEvent.ACTION_DOWN) {
			_active = false;
		}
		return true;
	}
}
