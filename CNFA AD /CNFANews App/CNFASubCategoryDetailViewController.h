//
//  CNFASubCategoryDetailViewController.h
//  CNFANews App
//
//  Created by iMac Apple on 27/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//
#import <sqlite3.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "WXApiObject.h"
#import "WXApi.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
//#import "TCWBEngine.h"
#import <MessageUI/MessageUI.h>
#import "CustomUIASView.h"
#import "CNFADummyView.h"
#import "CNFAAppDelegate.h"
#import "WeiboApi.h"
#import "WBMsgViewController.h"

@interface CNFASubCategoryDetailViewController : UIViewController<UITextViewDelegate,UIScrollViewDelegate,WXApiDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIWebViewDelegate,WeiboAuthDelegate,WeiboRequestDelegate,WBMsgViewControllerDelegate>
{
    
    BOOL favoritStatus;
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;

    UIButton *test_btm;
    UILabel *navbartitle;
    NSString * Titlevalstr;
    UIWebView *txt_view;
    NSString *keystr;
    NSString * DBUpdateTimeStamp;
    UIScrollView *scrollViewHorizontal;
    UIPageControl *pageControl;
      BOOL pageControlIsChangingPage;
    
    
    UILabel* cell_lbl1;
    UILabel* celltxt_lbl3;
    UIScrollView *maingScrollView;
    UIButton *share_btn;
    UIButton *share_btnhiden ;

    UIImageView *scrollVwbg;
    UIView *transparentView;
    
    CustomUIASView *uiasView;
    UIView* transview;
    int shareClicked;
    
   
    NSString* m_nsLastText;
    UIAlertView *alert;
    enum WXScene _scene;
    
    
    CGFloat contentHgt;
    CGFloat  originX;
    int flag;
    CNFADummyView *dummyView;
     WBMsgViewController *wbMsg;
}

@property(nonatomic,retain)NSString * addtitlestr;
@property(nonatomic,retain)NSString * adddetailtextstr;
@property(nonatomic,retain)NSString * addNewsNamestr;
@property(nonatomic,retain)NSString * addCityNamestr;
@property(nonatomic,retain)NSString * addTimestr;
@property(nonatomic,retain)NSString * addIDstr;
@property(nonatomic,retain)NSString * pageCurr;
@property(nonatomic,retain)NSString * addUpdateTime;
@property(nonatomic,retain)NSMutableArray * subCategory_AddIDarr;
@property(nonatomic,retain)NSMutableArray * subCategory_AddTitlearr;
@property(nonatomic,retain)NSMutableArray * subCategory_AddDetailTextarr;
@property(nonatomic,retain)NSMutableArray * subCategory_AddCreatedTimearr;
@property(nonatomic,retain)NSMutableArray * subCategory_AddNewsNamearr;
@property(nonatomic,retain)NSMutableArray * subCategory_AddCityNamearr;
@property(nonatomic,retain)NSMutableArray * subCategory_UpdateTimearr;

@property (nonatomic, retain) NSString* eMailSubjectstr;
@property (nonatomic, retain) NSString* eMaildetailmsgstr;
@property (nonatomic, retain) NSString* eMailaddCitystr;
@property (nonatomic, retain) NSString* eMailaddNewsstr;
@property (nonatomic, retain) NSString* eMailaddTimestr;

@property (nonatomic, retain) NSString* cityName;
@property (nonatomic, retain) NSString* news_Namestr;
@property (nonatomic, retain) NSString* news_Catname;
@property (nonatomic, retain)  NSString *ph1;

@property (nonatomic, retain) CustomUIASView *uiasView;

//-(void)weibo_btnAction:(id)sender;
//- (void) sendTextContent:(NSString*)nsText;


//@property (nonatomic, retain) TCWBEngine   *weiboEngine;
@property(nonatomic,retain)NSString *fromTab;
@property (nonatomic, retain) UIButton      *logInBtnOAuth;
@property (nonatomic , retain) WeiboApi     *wbapi;
- (void)showAlertMessage:(NSString *)msg;
//- (void)onLogInOAuthButtonPressed;

@end
