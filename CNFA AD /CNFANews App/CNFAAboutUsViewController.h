//
//  CNFAAboutUsViewController.h
//  CNFANews App
//
//  Created by Dex on 24/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CNFAGetAboutUSService.h"
#import "Reachability.h"
#import <sqlite3.h>

@interface CNFAAboutUsViewController : UIViewController<GetaboutUSDelegate,UIWebViewDelegate,UIScrollViewDelegate>
{
   UIWebView *txt_view;
    UIView * tempindbg;
    UIActivityIndicatorView *  spinner;

    //NSMutableArray * fetchID;
    NSMutableArray * fetchtext;
    NSMutableArray * fetchTimeStamp;

    NSMutableArray * text;
    NSMutableArray * TimeStamp;

    int flag;
    UIScrollView *maingScrollView;
    Reachability * reachability ;
    NetworkStatus remoteHostStatus;
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;
}
@end
