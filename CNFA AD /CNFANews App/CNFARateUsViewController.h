//
//  CNFARateUsViewController.h
//  CNFANews App
//
//  Created by iMac Apple on 27/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "CNFAGetContactUS.h"
#import "CNFAGetNewContactUSservices.h"
#import <sqlite3.h>
@interface CNFARateUsViewController :UIViewController<GetContactUSNewDelegate,GetContactUsDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSArray *lbl_list;
    
    Reachability * reachability ;
    NetworkStatus remoteHostStatus;
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;
    UITextField * userName_Txt;
    UITextField * email_Txt;
    UITextField *phone_Txt;
    UITextField *city_Txt;
    UITextView *text_view;
    UIScrollView *maingScrollView;
    
    UIView * tempindbg;
    UIActivityIndicatorView *spinner;
    
    NSMutableArray * IDarr;
    NSMutableArray * Addressarr;
    NSMutableArray * phonenoarr;
    NSMutableArray * faxnoarr;
    NSMutableArray * emailarr;
    NSMutableArray * websitearr;
    NSMutableArray * Eweiboarr;
    NSMutableArray * renronarr;
    
    
    NSString * IDstr;
    NSString * Addressstr;
    NSString * phonenostr;
    NSString * faxnostr;
    NSString * emailstr;
    NSString * websitestr;
    NSString * Eweibostr;
    NSString * renronstr;
    UITextView *   txt_view;
    UILabel * faxressicon_lbl;
    UIImageView *mail_TELICON;
    UITextView *   mail_txt_view;
    UITextView *   web_icon_txt_view;
    UILabel * add_lbl;
}

@end
