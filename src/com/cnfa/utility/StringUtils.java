package com.cnfa.utility;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import android.app.Dialog;
import android.content.Context;
import android.text.Html;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.text.style.ForegroundColorSpan;
import android.text.style.URLSpan;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.cnfa.R;

public class StringUtils {

	// Pattern.compile("\\d{7,15}");// ^[a-zA-Z]+([0-9]+).*
	private static Pattern pattern = Pattern.compile(

	"(\\+[0-9]+[\\- \\.]*)?"

	+ "(\\([0-9]+\\)[\\- \\.]*)?"

	+ "([0-9][0-9\\- \\.][0-9\\- \\.]+[0-9])");

	public static void popupDefinition(String string, TextView textView,
			Context context) {
		SpannableString spannable = new SpannableString(string);
		Matcher matcher = pattern.matcher(spannable);
		while (matcher.find()) {
			
			//Log.d("ABCDEFDH", "ABCDEFDH"+matcher.toString().length()+"/////" + spannable.length());
			spannable.setSpan(new ActivitySpan(matcher.group(), context),
					matcher.start(), matcher.end(),
					Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
			int count = matcher.end()-matcher.start();
			//Log.d("COUNTTT", "COUNTTT"+count);
			if (count>6)
			{
			spannable.setSpan(new ForegroundColorSpan(context.getResources()
					.getColor(R.color.lightgreen)), matcher.start(), matcher
					.end(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
			}
			
		}
		
		textView.setText(spannable);
		textView.setMovementMethod(LinkMovementMethod.getInstance());
		
		

	}

	public static void popupDefinitionFromHTML(String string,
			TextView textView, Context context) {
		SpannableString spannable = new SpannableString(string);
		Matcher matcher = pattern.matcher(spannable);
		while (matcher.find()) {
			spannable.setSpan(new ActivitySpan(matcher.group(), context),
					matcher.start(), matcher.end(),
					Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
			spannable.setSpan(new ForegroundColorSpan(context.getResources()
					.getColor(R.color.lightgreen)), matcher.start(), matcher
					.end(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
		}

		String str = spannable.toString();
		// textView.setAutoLinkMask(Linkify.WEB_URLS);
		// textView.setLinkTextColor(context.getResources().getColor(R.color.lightgreen));
		textView.setText(Html.fromHtml(str));
		textView.setMovementMethod(LinkMovementMethod.getInstance());

	}

	public static void removeUnderlines(Spannable p_Text) {
		URLSpan[] spans = p_Text.getSpans(0, p_Text.length(), URLSpan.class);

		for (URLSpan span : spans) {
			int start = p_Text.getSpanStart(span);
			int end = p_Text.getSpanEnd(span);
			p_Text.removeSpan(span);
			span = new URLSpanNoUnderline(span.getURL());
			p_Text.setSpan(span, start, end, 0);
		}

	}

	public static void makeLinkClickable(SpannableStringBuilder strBuilder,
			final URLSpan span, final Context context) {
		int start = strBuilder.getSpanStart(span);
		int end = strBuilder.getSpanEnd(span);
		int flags = strBuilder.getSpanFlags(span);
		ClickableSpan clickable = new ClickableSpan() {
			public void onClick(View view) {
				Dialog dialog = new Dialog(context);
				dialog.setTitle("Link Clickabkle");
				dialog.show();
			}
		};
		strBuilder.setSpan(clickable, start, end, flags);
		strBuilder.removeSpan(span);
	}

	public static void setTextViewHTML(TextView text, String html,
			Context context) {

		CharSequence sequence = Html.fromHtml(html);
		SpannableStringBuilder strBuilder = new SpannableStringBuilder(sequence);
		URLSpan[] urls = strBuilder.getSpans(0, sequence.length(),
				URLSpan.class);
		for (URLSpan span : urls) {
			makeLinkClickable(strBuilder, span, context);
		}
		text.setText(strBuilder);
	}
}
