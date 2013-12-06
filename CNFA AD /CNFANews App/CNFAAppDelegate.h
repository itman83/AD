//
//  CNFAAppDelegate.h
//  CNFANews App
//
//  Created by Dex on 21/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNFANewsDigestViewController.h"
#import "CNFAContactUsViewController.h"
#import "CNFACityViewController.h"
#import "CNFAAboutUsViewController.h"
#import "CNFARateUsViewController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "Reachability.h"
@class CNFASubCategoryDetailViewController;
@class CNFACategoryNewsViewController;
@interface CNFAAppDelegate : UIResponder <WXApiDelegate,UIApplicationDelegate,UITabBarControllerDelegate,UINavigationControllerDelegate,UITabBarDelegate>{
    UITabBarController *tabbar;
    CNFAContactUsViewController *contactus;
    
    UITabBar *tabBar;
    UIView * indicatorbackview;
    UIActivityIndicatorView * indicator ;
    UINavigationController *nav1;
    UINavigationController *nav2;
    UINavigationController *nav3;
    UINavigationController *nav4;
    UINavigationController * nav5;
    
    Reachability* internetReachable;
    Reachability* hostReachable;
    UIAlertView * alertView ;
}

//- (NSArray *)initializeTabBarItems;

-(void) checkNetworkStatus:(NSNotification *)notice;

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)CNFANewsDigestViewController *newsDigest;
@property(strong,nonatomic)UINavigationController *navcontroller;
@property(strong,nonatomic) UITabBarController *tabbar;
@property (strong, nonatomic) CNFASubCategoryDetailViewController *viewController;
@property (strong, nonatomic) CNFACategoryNewsViewController *viewController1;
@property (strong, nonatomic) NSString *fromPage;
@end
