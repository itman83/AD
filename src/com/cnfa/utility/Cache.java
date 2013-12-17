package com.cnfa.utility;

import java.util.HashMap;

public class Cache {
	private static Cache instance = null;	
	public HashMap<String, String> items = new HashMap<String, String>();
	
	public static Boolean isLoggedIn = false;
	public static String username = null;
	public static String password = null;
	
	public static String language = "en";
	public static String selectedroom = null;
	public static String selectedroomtype = null;
	public static String lastactivity = null;
	public static String nextactivity = null;
	public static String specialeventid = null;
	
	public static String viaroute_reservation = null;
	public static String viaroute_dinner = null;
	public static String viaroute_thankyou = null;
	public static String viaroute_gateway = null;
	
	public static String reservation_checkin = null;
	public static String reservation_checkout = null;
	public static String reservation_roomcount = null;
	public static String reservation_adultcount = null;
	public static String reservation_roomtype = null;
	public static String reservation_childcount = null;
	public static String reservation_roomprice = null;
	public static String reservation_arrivaltime = null;
	public static String reservation_plancode = null;
	public static String reservation_roomid = null;
	public static String reservation_corporatename = null;
	public static String reservation_membername = null;
	public static String reservation_advanced = null;
	public static String reservation_guarantee = null;
	public static String reservation_description = null;
	
	public static String dinningbooking_restaurant = null;
	public static String dinningbooking_bookingdate = null;
	public static String dinningbooking_mealtime = null;
	public static String dinningbooking_meal = null;
	public static String dinningbooking_arrivaltime = null;
	public static String dinningbooking_guestcount = null;
	public static String dinningbooking_specialreq = null;
	public static String dinningbooking_additionalreq = null;
	
	public static String myinfo_memberid = null;
	public static String myinfo_fullname = null;
	public static String firstname = null;
	public static String lastname = null;
	public static String email = null;
	public static String phone = null;
	public static String myinfo_gender = null;
	public static String myinfo_nationality = null;
	public static String myinfo_birthday = null;
	public static String myinfo_email = null;
	public static String myinfo_mobile = null;
	public static String myinfo_availablepoints = null;
	public static String myinfo_totalpoints = null;
	public static String myinfo_pointsused = null;
	
	public static String specialevent_name = null;
	public static String specialevent_description = null;
	
	public static String bookingid = null;
	public static String totalamount = null;
	
	public static String phonenumber = null;
	public static String transactionid = null;
	public static String is_signup = null;
	public static String is_login = null;
	
	
	
	

	protected Cache() {
		// Exists only to defeat instantiation.
	}

	public static Cache getInstance() {
		if (instance == null) {
			instance = new Cache();
		}
		return instance;
	}
}
