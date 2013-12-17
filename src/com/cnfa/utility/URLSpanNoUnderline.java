package com.cnfa.utility;

import android.text.TextPaint;
import android.text.style.URLSpan;
 
public class URLSpanNoUnderline extends URLSpan {
    public URLSpanNoUnderline(String p_Url) {
        super(p_Url);
        System.out.println("its callling");
    }
 
    public void updateDrawState(TextPaint p_DrawState) {
        super.updateDrawState(p_DrawState);
        p_DrawState.setUnderlineText(false);
    }
}