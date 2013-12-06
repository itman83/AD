//
//  CNFACategoryNewsViewController.h
//  CNFANews App
//
//  Created by Dex on 26/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//


#import "Reachability.h"
#import <sqlite3.h>
#import <UIKit/UIKit.h>
#import "CNFAGetCatListByNewsandCity.h"
#import <QuartzCore/QuartzCore.h>
#import "CNFASubCategoryDetailViewController.h"
#import "CNFAGetSubCatDetail.h"
#import "CNFAGetAllAddSearch.h"
#import "CNFAGetSerchNewsByCtID.h"
#import "CNFAGetSubCatSearchList.h"
#import "CustomUIASView.h"


#import "WXApiObject.h"
#import "WXApi.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
//#import "TCWBEngine.h"
#import <MessageUI/MessageUI.h>
#import "CNFAAppDelegate.h"
#import "WeiboApi.h"
#import "WBMsgViewController.h"

@interface CNFACategoryNewsViewController : UIViewController<GetSearchsubcategoryListDelegate,GetSearchNewsclassBYCTIDDelegate,GetSearchdelegateByNewsID,UITextFieldDelegate,GetSubCatAddDetailBYAllSearch,GetSubCatAddDetail,UITableViewDataSource,UITableViewDelegate,WXApiDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIWebViewDelegate,WeiboAuthDelegate,WeiboRequestDelegate,WBMsgViewControllerDelegate>{
    UIImageView *mainbg_img;
    UITableView *tableview;
    NSMutableArray  *array1;
    UIButton *   back_btn;
    UILabel * city_lbl;
    UILabel * City_lbl2;

    Reachability * reachability ;
    NetworkStatus remoteHostStatus;
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;
    UIView * tempindbg;
    UIActivityIndicatorView *spinner;
    BOOL ISTempStorSearch;
    
    NSMutableArray * adddescID;
    NSMutableArray * adddescTitle;
    NSMutableArray * adddescDetaiText;
    NSMutableArray * adddescCreatedDate;
    NSMutableArray * adddescUpdateTime;
    NSMutableArray * adddescNewsName;
    NSMutableArray * adddesCityName;

    
    NSMutableArray * fetchadddescID;
    NSMutableArray * fetchadddescTitle;
    NSMutableArray * fetchadddescDetaiText;
    NSMutableArray * fetchadddescCreatedDate;
    NSMutableArray * fetchadddescUpdateTime;
    NSMutableArray * fetchadddescNewsName;
    NSMutableArray * fetchadddesCityName;
    UITextField * searchbar_Txt;
    
    UIView* transview;

     CustomUIASView *uiasView;
    int shareClicked;
    
    UILabel* noresult_lbl;
    NSString* m_nsLastText;
    UIAlertView *alert;
    enum WXScene _scene;
    WBMsgViewController *wbMsg;
 }
@property (nonatomic, retain) CustomUIASView *uiasView;
@property(nonatomic,retain)NSString * news_catIDstr;
@property(nonatomic,retain)NSString * news_Namestr;
@property(nonatomic,retain)NSString * news_cityIdstr;
@property(nonatomic,retain)NSString * news_IDstr;
@property(nonatomic,retain)NSString * news_Catname;
@property(nonatomic,retain)NSString * Isallsearch;
@property(nonatomic,retain)NSString * searchtextvalstr;
@property(nonatomic,retain)NSString * searchtextstr;
@property(nonatomic,retain)NSString * NewsID;
@property(nonatomic,retain)NSString * cityIDstr;
@property(nonatomic,retain)NSString * cityName;
@property(nonatomic,retain)NSString * fromTab1;

@property(nonatomic,retain)NSString * ph1;
//-(void)weibo_btnAction:(id)sender;
//- (void) sendTextContent:(NSString*)nsText;


//@property (nonatomic, retain) TCWBEngine   *weiboEngine;


- (void)showAlertMessage:(NSString *)msg;
//- (void)onLogInOAuthButtonPressed;
@property (nonatomic, retain) UIButton      *logInBtnOAuth;
@property (nonatomic , retain) WeiboApi     *wbapi;
@property (nonatomic, retain) NSString* eMailSubjectstr;
@property (nonatomic, retain) NSString* eMaildetailmsgstr;
@property (nonatomic, retain) NSString* eMailaddCitystr;
@property (nonatomic, retain) NSString* eMailaddNewsstr;
@property (nonatomic, retain) NSString* eMailaddTimestr;

@end
