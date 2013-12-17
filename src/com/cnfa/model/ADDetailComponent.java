package com.cnfa.model;

import android.os.Parcel;
import android.os.Parcelable;

public class ADDetailComponent implements  Parcelable
{
	public String id = null;
	public String adsTitle = null;
	public String adsDescription = null;
	public String city = null;
	public String categoryId = null;
	public String status = null;
	public String creationTime = null;
	public String updateTime = null;
	public String cityName = null;
	public String newspaperName = null;
	@Override
	public int describeContents() {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public void writeToParcel(Parcel dest, int flags) {
		// TODO Auto-generated method stub
		dest.writeString(id);
		dest.writeString(adsTitle);
		dest.writeString(adsDescription);
		dest.writeString(city);
		dest.writeString(categoryId);
		dest.writeString(status);
		dest.writeString(creationTime);
		dest.writeString(updateTime);
		dest.writeString(cityName);
		dest.writeString(newspaperName);
	}

    public static final Parcelable.Creator<ADDetailComponent> CREATOR
            = new Parcelable.Creator<ADDetailComponent>() {
        public ADDetailComponent createFromParcel(Parcel in) {
            return new ADDetailComponent(in);
        }

        public ADDetailComponent[] newArray(int size) {
            return new ADDetailComponent[size];
        }
    };
    private ADDetailComponent(Parcel in) {
    	id = in.readString();
    	adsTitle=in.readString();
    	adsDescription = in.readString();
    	city=in.readString();
    	categoryId = in.readString();
    	status=in.readString();
    	creationTime = in.readString();
    	updateTime=in.readString();
    	cityName = in.readString();
    	newspaperName=in.readString();
    }
   public ADDetailComponent() {
	// TODO Auto-generated constructor stub
}
   
   
   
	}