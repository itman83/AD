//
//  CNFANewsViewController.h
//  CNFANews App
//
//  Created by Dex on 24/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//
//#import "CNFAChangeUpdateStatus.h"
//#import "CNFAGetClassUpdateStatus.h"

#import "Reachability.h"
#import <sqlite3.h>
#import <UIKit/UIKit.h>
#import "CNFAGetNewsTitle.h"
#import "CNFACategoryNewsViewController.h"
@interface CNFANewsViewController : UIViewController<GetNewsListDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{

    Reachability * reachability ;
    NetworkStatus remoteHostStatus;
    //BOOL UpdateStatusbool;
    UIImageView *mainbg_img;
    UITextField *searchbar_Txt;
 
    UIButton *   back_btn;
  
    NSMutableArray * newsID;
    NSMutableArray * newsTitle;
    NSMutableArray * newsTitleimg;
    NSMutableArray * newsTitleimgURL;
    NSMutableArray * timeStamp;
    
    NSMutableArray * fetchnewsID;
    NSMutableArray * fetchnewsTitle;
    NSMutableArray * fetchnewsTitleimg;
    NSMutableArray * fetchnewsTitleimgURL;
    NSMutableArray * fetchtimeStamp;
    
    
    
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;
    NSString *fullPath;
    UIImage *image;
    
  UIView * tempindbg;
  UIActivityIndicatorView *spinner;
    
    
    // 
    
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
    
}
//
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
//

@end
