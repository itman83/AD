//
//  CNFATermsANDPrivacyViewController.h
//  CNFANews App
//
//  Created by Dex on 26/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CNFAGetAboutUSService.h"
#import "Reachability.h"
#import <sqlite3.h>
#import <MessageUI/MessageUI.h>
@interface CNFATermsANDPrivacyViewController : UIViewController<GetaboutUSDelegate,UITextViewDelegate,UIWebViewDelegate,MFMailComposeViewControllerDelegate>
{
    UILabel *navbartitle;
 
    BOOL TermofUses;
    
    Reachability * reachability ;
    NetworkStatus remoteHostStatus;
    
    NSMutableArray * privicyID;
    NSMutableArray * PrivTect;
    NSMutableArray * UpdateTime;
    
    NSMutableArray * fetchprivicyID;
    NSMutableArray * fetchPrivTect;
    NSMutableArray * fetchUpdateTime;
    

    
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;

    int flag;
    
    UIView * tempindbg;
    UIActivityIndicatorView *  spinner;

}
@property(nonatomic,retain)NSString * Titlevalstr;
@property(nonatomic,retain) UIWebView *txt_view;
@property(nonatomic,retain)NSString *keystr;
@property(nonatomic,retain)NSString *ph1;

@end
