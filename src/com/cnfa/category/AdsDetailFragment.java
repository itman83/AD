package com.cnfa.category;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.cnfa.R;
import com.cnfa.constant.Constant;
import com.cnfa.db.DbSync;
import com.cnfa.model.ADDetailComponent;
import com.cnfa.utility.StringUtils;
import com.cnfa.utility.Utility;

public class AdsDetailFragment extends Fragment {
	private TextView txtTitle, txtDetail, txtCityName, txtbreadcrumb,
			txtHeading;
	private ImageView imgFavorite, btnShare;
	Context mContext;
	ADDetailComponent adDetailComponent;
	private int check;
	String bottomtext;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		ViewGroup rootView = (ViewGroup) inflater.inflate(
				R.layout.addetailfragment, container, false);
		txtTitle = (TextView) rootView.findViewById(R.id.extadstitle);
		txtDetail = (TextView) rootView.findViewById(R.id.txtdetail);
		txtCityName = (TextView) rootView.findViewById(R.id.bottomtext);
		txtbreadcrumb = (TextView) rootView.findViewById(R.id.txtbreadcrumb);
		btnShare = (ImageView) rootView.findViewById(R.id.shareicon);
		imgFavorite = (ImageView) rootView.findViewById(R.id.favicon);
		txtCityName.setText(bottomtext);
	

		txtCityName
				.setTypeface(Utility.setRegularFont(mContext));
		if (adDetailComponent != null) {
			// txtHeading.setText(obj.getAdsTitle());
			txtTitle.setText(adDetailComponent.adsTitle);
			StringUtils.popupDefinition(adDetailComponent.adsDescription,txtDetail,mContext);
//			txtDetail.setText();
			// txtCityName.setText(obj.getCityName());
			// txtDate.setText(obj.getCreationTime());
			txtTitle.setTypeface(Utility.setRegularFont(mContext));
			//txtDetail.setTypeface(Utility.setRegularFont(mContext));
			txtDetail.setTypeface(Utility.setRegularFont(mContext));

			btnShare.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View v) {
					Constant.shareText(mContext, adDetailComponent.adsTitle,adDetailComponent.adsDescription);
				
				}
			});

			check = DbSync.isFavouriteAvailable(mContext, adDetailComponent.id);

			if (check != 0) {
				imgFavorite.setImageResource(R.drawable.topfavouriteicon_active);

			}
			imgFavorite.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View v) {
					check = DbSync.isFavouriteAvailable(mContext,
							adDetailComponent.id);
					if (check == 0) {
						boolean b = DbSync.saveFavoritedata(mContext,
								adDetailComponent.id,
								adDetailComponent.adsTitle,
								adDetailComponent.adsDescription,
								adDetailComponent.city,
								adDetailComponent.categoryId,
								adDetailComponent.status,
								adDetailComponent.creationTime,
								adDetailComponent.updateTime,
								adDetailComponent.cityName,
								adDetailComponent.newspaperName);
						if (b == true) {
							imgFavorite.setImageResource(R.drawable.topfavouriteicon_active);

						}
					} else {
						boolean delCheck = DbSync
								.deleteFavoriteRecord(mContext,
										"favoritetable", adDetailComponent.id);
						if (delCheck == true) {
							imgFavorite.setImageResource(R.drawable.topfavouriteicon);
					

						}
					}
				}
			});
		}
		return rootView;
	}

	AdsDetailFragment(Context context, ADDetailComponent adDetail,
			String bottomtext) {
		mContext = context;
		adDetailComponent = adDetail;
		this.bottomtext = bottomtext;
	}

	public AdsDetailFragment() {
	}

}
