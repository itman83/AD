//
//  CNFACityViewController.h
//  CNFANews App
//
//  Created by Dex on 24/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//
#import "CNFAGetCityList.h"
#import <UIKit/UIKit.h>
#import "CNFANewsDigestViewController.h"
#import "CNFAGetCitySearch.h"
#import "Reachability.h"
#import <sqlite3.h>
#import "CNFACategoryNewsViewController.h"
#import "CNFANewsViewControllerByCT.h"
#import "CNFACategoryNewsViewController.h"
@interface CNFACityViewController : UIViewController<GetCityListbySearchDelegate,GetCityListDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
   
    
    Reachability * reachability ;
    NetworkStatus remoteHostStatus;
  
    UIImageView *  mainbg_img;
    UITextField * searchbar_Txt;
   // UITableView * tableview;
    UIButton * back_btn;
    
    NSMutableArray * CityIDarr;
    NSMutableArray * CityName;
    NSMutableArray * UpdateTime;
    NSMutableArray * provinceArr;
       
    NSMutableArray * fetchnCityIDarr;
    NSMutableArray * fetchCityName;
    NSMutableArray * fetchUpdateTime;
    NSMutableArray * fetchProvinceArr;
    
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;

    
    
    UIView * tempindbg;
    UIActivityIndicatorView *  spinner;
    
    ////Reddy
    
    
    //  UITableView *tableview;
    
    UITableView *tableview;
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    NSMutableArray *items;
    UITableViewCell *cell;
    NSString *todaydate;
    UILabel *today_lbl;
    //
/// reddy
    
    
}

/// Reddy
@property (nonatomic, retain)  UITableView *tableview;
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
@property (nonatomic, copy) NSString *todaydate;

//- (void)setupStrings;
//- (void)addPullToRefreshHeader;
//- (void)startLoading;
//- (void)stopLoading;
//- (void)refresh;


/// reddy
@end
