//
//  CNFANewsDigestViewController.h
//  CNFANews App
//
//  Created by Dex on 21/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CNFAGetCityListandCat.h"
#import "CNFAGetCategoryListByCT.h"
#import "CNFAGetCatListByNewsandCity.h"
#import <sqlite3.h>
#import "Reachability.h"
#import "CNFAGlobalDataClass.h"
@interface CNFANewsDigestViewController : UIViewController<GetNewsCatListDelegate,GetCityCatListDelegate,UISearchBarDelegate,UIScrollViewDelegate,UITabBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
     
    UITextField * searchbar_Txt;
    Reachability * reachability ;
    NetworkStatus remoteHostStatus;
    UIButton * searchback_btn;
    UIButton * drpbtnhidden_btn;
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;
    UIView * tempindbg;
    UIActivityIndicatorView *spinner;

    
    
     UITableView *tableView1;
     UIImageView *dropdownBGimg;
     UIButton * drpbtn_btn;
    UILabel * city_lbl;
    
    
    NSMutableArray * Newscategory_id;
    NSMutableArray * Newscategory_name;
    NSMutableArray * Newsupdate_time;
    NSMutableArray * Newslogo_URL;
    NSMutableArray * Newsimage_Name;
    NSMutableArray * NewsNewsID;
    
    NSMutableArray * NewsCatNumArt;
    
    NSMutableArray * NewsCatUpdateTime;
    NSMutableArray * NewscityId;
    NSMutableArray * NewscityName;
    NSMutableArray * NewscityTimeStamp;
    
    
    NSMutableArray * fetNewscategory_id;
    NSMutableArray * fetNewscategory_name;
    NSMutableArray * fetNewsupdate_time;
    NSMutableArray * fetNewslogo_URL;
    NSMutableArray * fetNewsimage_Name;
    NSMutableArray * fetNewsNewsID;
    NSMutableArray * fetNewsnewspaper_name;
    NSMutableArray * fetNewsnewspaperupdate_time;
    NSMutableArray * fetNewscityId;
    NSMutableArray * fetNewscityName;
    NSMutableArray * fetNewscityTimeStamp;

    UILabel * City_lbl2;
    
//    
//    NSMutableArray * Citycategory_id;
//    NSMutableArray * Citycategory_name;
//    NSMutableArray * Cityupdate_time;
//    NSMutableArray * Citylogo_URL;
//    NSMutableArray * Cityimage_Name;
//    NSMutableArray * CityNewsID;
//    NSMutableArray * Citynewspaper_name;
//    NSMutableArray * Citynewspaperupdate_time;
//
//    
//    
//    NSMutableArray * fetCitycategory_id;
//    NSMutableArray * fetCitycategory_name;
//    NSMutableArray * fetCityupdate_time;
//    NSMutableArray * fetCitylogo_URL;
//    NSMutableArray * fetCityimage_Name;
//    NSMutableArray * fetCityNewsID;
//    NSMutableArray * fetCitynewspaper_name;
//    NSMutableArray * fetCitynewspaperupdate_time;
    
    
    
    
    NSString * Selected_City;
    NSString * Selected_CityID;
    NSString *fullPath;
    UIImage *image;
    
    
    
    UIView * scrollDesableview;
    UIButton *back_btn ;
    UISearchBar *searchbar;
    UIScrollView *scrollView;
    BOOL pageControlIsChangingPage;
    UIPageControl *pageControl;
    NSArray *array_imgnames;
    NSArray *btn_nameary;
    UITabBar  *tabbar;
    UITabBarController *tabbarcontroller;
    UIImageView * mainbg_img;
    
    UIButton *imageView22;
    UIImageView *navbarimage;
}
@property(nonatomic,retain)UITabBarController *tabbarcontroller;
@property(nonatomic,retain)UITabBar *tabbar;
@property(nonatomic,retain)NSString *keystr;
@property(nonatomic,retain)NSString *NewsID;
@property(nonatomic,retain)NSString *ClassType;
@property(nonatomic,retain)NSString *CityID;
@property(nonatomic,retain)NSString *CityName;
@property(nonatomic,retain)NSString *dropdownmsg;
@property(nonatomic,retain)NSString *finalNewsID;
@property(nonatomic,retain)NSString *fromTab;

@end
