// THIS IS A BETA! I DON'T RECOMMEND USING IT IN PRODUCTION CODE JUST YET

/*
 * Copyright 2012 Roman Nurik
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.cnfa.swipetodelete;

import com.cnfa.R;

import android.graphics.Rect;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewConfiguration;
import android.widget.AbsListView;
import android.widget.ListView;


public class SwipeDismissListViewTouchListener2 implements View.OnTouchListener ,OnClickListener{
    // Cached ViewConfiguration and system-wide constant values
    private int mSlop;
    private int mMinFlingVelocity;
    private int mMaxFlingVelocity;
    private long mAnimationTime;

    // Fixed properties
    private ListView mListView;
    private OnDismissCallback mCallback;
    private float mViewWidth = 1; // 1 and not 0 to prevent dividing by zero

    // Transient properties
//    private List<PendingDismissData> mPendingDismisses = new ArrayList<PendingDismissData>();
    private float mDownX;
    private VelocityTracker mVelocityTracker;
     static int mDownPosition=ListView.INVALID_POSITION;
     int mPreDownPosition=ListView.INVALID_POSITION;
    private View mDownView;
    private View mPreDownView;

    private boolean mPaused;
    static boolean dismiss = false;  
    boolean viewDeleteStatus=false;
    float prevDeltaX=0;
    int alpha;
    float deltaX;
    boolean isDeleteStripeAppear=false;
    int touchCount=0;
    public interface OnDismissCallback {
        
        void onDismiss(ListView listView, int reverseSortedPositions);
    }
    public SwipeDismissListViewTouchListener2(ListView listView, OnDismissCallback callback) {
    	System.out.println("fhhhfhf");
        ViewConfiguration vc = ViewConfiguration.get(listView.getContext());
        mSlop = vc.getScaledTouchSlop();
        mMinFlingVelocity = vc.getScaledMinimumFlingVelocity();
        mMaxFlingVelocity = vc.getScaledMaximumFlingVelocity();
        mAnimationTime = listView.getContext().getResources().getInteger(
                android.R.integer.config_shortAnimTime);
        mListView = listView;
      //  mListView.setDescendantFocusability(ListView.FOCUS_BLOCK_DESCENDANTS);
        mCallback = callback;
        
    }

    /**
     * Enables or disables (pauses or resumes) watching for swipe-to-dismiss gestures.
     *
     * @param enabled Whether or not to watch for gestures.
     */
    public void setEnabled(boolean enabled) {
        mPaused = !enabled;
    }

    /**
     * Returns an {@link android.widget.AbsListView.OnScrollListener} to be added to the
     * {@link ListView} using
     * {@link ListView#setOnScrollListener(android.widget.AbsListView.OnScrollListener)}.
     * If a scroll listener is already assigned, the caller should still pass scroll changes
     * through to this listener. This will ensure that this
     * {@link SwipeDismissListViewTouchListener2} is paused during list view scrolling.</p>
     *
     * @see {@link SwipeDismissListViewTouchListener2}
     */
    public AbsListView.OnScrollListener makeScrollListener() {
        return new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView absListView, int scrollState) {
                setEnabled(scrollState != AbsListView.OnScrollListener.SCROLL_STATE_TOUCH_SCROLL);
            }

            @Override
            public void onScroll(AbsListView absListView, int i, int i1, int i2) {
            }
        };
    }
    
    
    @Override
    public boolean onTouch(View view, MotionEvent motionEvent) {

        switch (motionEvent.getActionMasked()) {
            case MotionEvent.ACTION_DOWN: {
                if (mPaused) {
                    return false;
                }
          
                 touchCount++;
                mViewWidth = mListView.getWidth();
                System.out.println("withd="+mViewWidth);
                Rect rect = new Rect();
                int childCount = mListView.getChildCount();
                int[] listViewCoords = new int[2];
                mListView.getLocationOnScreen(listViewCoords);
                int x = (int) motionEvent.getRawX() - listViewCoords[0];
                int y = (int) motionEvent.getRawY() - listViewCoords[1];
                View child;
                for (int i = 0; i < childCount; i++) {
                    child = mListView.getChildAt(i);
                    child.getHitRect(rect);
                   
                    if (rect.contains(x, y)) {
                        mDownView = child;
                        break;
                    }
                }

                if (mDownView != null) {
                    mDownX = motionEvent.getRawX();
                    mDownPosition = mListView.getPositionForView(mDownView);

                    mVelocityTracker = VelocityTracker.obtain();
                    mVelocityTracker.addMovement(motionEvent);
                }
                if(mPreDownPosition==mDownPosition)
                	dismiss=true;

                System.out.println("prep="+mPreDownPosition+"curp="+mDownPosition);
                System.out.println("count="+touchCount);

                view.onTouchEvent(motionEvent);
                return true;
            }

            case MotionEvent.ACTION_UP: {
            	System.out.println("up");
                if (mVelocityTracker == null) {
                    break;
                }

                if(mPreDownPosition==ListView.INVALID_POSITION)
                {
                	alpha=0;
                	mDownView.setScrollX(0);
                	 mDownView.setBackgroundResource(R.color.red);
                	 touchCount=0;
                }
                 if (touchCount==2&& mPreDownPosition==mDownPosition) {
                	 alpha=0;
//                	 mDownView.setBackgroundResource(R.drawable.order_list_selector);
                	 mDownView.setScrollX(0);
                	 mDownView.setBackgroundResource(R.color.red);
                	 mDownView.getBackground().setAlpha(alpha);
                	 mDownView=null;
                     mDownX = 0;
                     mDownPosition=ListView.INVALID_POSITION;
                	 touchCount=0;
                	 mPreDownView=null;
                	 mCallback.onDismiss(mListView, mPreDownPosition);
                     mPreDownPosition=ListView.INVALID_POSITION;

//                	 mPreDownView.getBackground().setAlpha(alpha);
                	 
                 }	
                else if(touchCount==2 &&mPreDownPosition!=mDownPosition)
                {
                	alpha=0;
                mPreDownView.setBackgroundResource(R.color.red);
                mPreDownView.setScrollX(0);
                touchCount=0;
                mPreDownView=null;
                mPreDownPosition=ListView.INVALID_POSITION;
                }
                	
                mVelocityTracker = null;
                mDownX = 0;
                mDownView = null;
                mDownPosition = ListView.INVALID_POSITION;
              break;
            }

            case MotionEvent.ACTION_MOVE: {
                if (mVelocityTracker == null || mPaused||touchCount==2 ) {
                    break;
                }
                System.out.println("moving........");
              deltaX = motionEvent.getRawX() - mDownX;
                if(deltaX<0 && Math.abs(deltaX) > mSlop)
                {

                	mDownView.setBackgroundResource(R.drawable.ic_launcher);
                    alpha=(int)(510/mViewWidth*Math.abs(deltaX));
                    if(alpha>=255||Math.abs(deltaX)>mViewWidth/4)
                    	alpha=255;
                   mDownView.getBackground().setAlpha(alpha);
                   System.out.println("alpha="+alpha);
                   if(Math.abs(deltaX)>mViewWidth/4||alpha==255)
                   {  
                            mDownView.setScrollX((int)mViewWidth);
                            mPreDownPosition=mDownPosition;
                            mPreDownView=mDownView;
                     break;
                   }

                   else
                   {
                	   mDownView.setScrollX((int)Math.abs(deltaX));
                   }
                }
                break;
            }
        }
        return false;
    }
  
@Override
public void onClick(View v) {
	// TODO Auto-generated method stub
	if(v.getId()==1 && v.getTag().equals("Delete_View"))
	{
		System.out.println("onclick view");
		
		 mCallback.onDismiss(mListView, mPreDownPosition);
		
		
	}
		
	
  }
}
