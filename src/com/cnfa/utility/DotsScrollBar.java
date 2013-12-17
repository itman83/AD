package com.cnfa.utility;

import android.content.Context;
import android.util.Log;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.cnfa.R;

public class DotsScrollBar
{
    LinearLayout main_image_holder;
    public static void createDotScrollBar(Context context, LinearLayout main_holder,int selectedPage,int count)
    {
        for(int i=0;i<count;i++)
        {
            ImageView dot = null;
            dot= new ImageView(context);
            LinearLayout.LayoutParams vp = 
                new LinearLayout.LayoutParams(LayoutParams.WRAP_CONTENT, 
                                LayoutParams.WRAP_CONTENT);
            dot.setLayoutParams(vp);    
            if(i==selectedPage)
            {
                try {
                    dot.setImageResource(R.drawable.selectdots);
                } catch (Exception e) 
                {
                    Log.d("inside DotsScrollBar.java","could not locate identifier");
                }
            }else
            {
                dot.setImageResource(R.drawable.dots);
            }
            main_holder.addView(dot);
        }
        main_holder.invalidate();
    }
}