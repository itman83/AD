//
//  CNFAAppDelegate.m
//  CNFANews App
//
//  Created by Dex on 21/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAAppDelegate.h"
#import "CNFANewsDigestViewController.h"
#import "CNFAContactUsViewController.h"
#import "CNFACityViewController.h"
#import "CNFAAboutUsViewController.h"
#import "CNFANewsViewController.h"
#import "CNFANewsDigestViewController.h"
#import "CNFAFavoritesViewController.h"
#import "CNFASubCategoryDetailViewController.h"
#import "CNFACategoryNewsViewController.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@implementation CNFAAppDelegate 

@synthesize newsDigest,navcontroller,tabbar,fromPage;
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [[Reachability reachabilityForInternetConnection] retain];
    [internetReachable startNotifier];
    
    [DBConnectionManager createCopyOfDatabaseIfNeeded];
    [DBConnectionManager initializeDatabase];
     self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    
    
    if (![WXApi registerApp:@"wxe13f609affa421f0"]) {
        NSLog(@"Failed to register with Weixin");
    }
    

    
   // sleep(3);
    
     [self customizeInterface];
    
    CNFANewsViewController *first=[[CNFANewsViewController alloc]init];
    CNFACityViewController *second=[[CNFACityViewController alloc]init];
    CNFAFavoritesViewController *third=[[CNFAFavoritesViewController alloc]init];
    CNFAAboutUsViewController *fourth=[[CNFAAboutUsViewController alloc]init];
   //  CNFARateUsViewController *fifth=[[CNFARateUsViewController alloc]init];
    
   nav1=[[UINavigationController alloc] initWithRootViewController:first];
   nav2=[[UINavigationController alloc] initWithRootViewController:second];
   nav3=[[UINavigationController alloc] initWithRootViewController:third];
   nav4=[[UINavigationController alloc] initWithRootViewController:fourth];
   //nav5=[[UINavigationController alloc]initWithRootViewController:fifth];
    
    
    
    
    tabbar=[[UITabBarController alloc]init];
    tabBar=[[UITabBar alloc]init];
    tabbar.delegate=self;
    
    tabbar.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4,  nil];
    tabBar = self.tabbar.tabBar;
    
    [first release];
    [second release];
    [third release];
    [fourth release];

    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];//newspaper-slect.png
    tabBarItem1.tag=0;
//
      UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    tabBarItem1.tag=1;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        tabBarItem2.selectedImage = [[UIImage imageNamed:@"city_select.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        tabBarItem2.image = [[UIImage imageNamed:@"city_unselct.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        tabBarItem1.selectedImage = [[UIImage imageNamed:@"newspaper-slect.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        tabBarItem1.image = [[UIImage imageNamed:@"newspaperUns.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        


    }
    else
    {
        [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"city_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"city_unselct.png"]];
        [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"newspaper-slect.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"newspaperUns.png"]];
    }

    
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    tabBarItem1.tag=3;
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"favourite_select.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"favourite_unselt.png"]];
    
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    tabBarItem1.tag=4;
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"about_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"about_unselect.png"]];
    

   
    
      [self.window addSubview:tabbar.view];
      [self.window makeKeyAndVisible];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [application setStatusBarStyle:UIStatusBarStyleLightContent];
//        self.window.clipsToBounds =YES;
//        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
//        
//        //Added on 19th Sep 2013
//        self.window.bounds = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
//    }
       return YES;
      
}


-(void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
   
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            alertView = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                   message:@"当前没有可用网络，请检查后再试."
                                                  delegate:self
                                         cancelButtonTitle:@"确认"
                                         otherButtonTitles:nil];
            
            
            [alertView setTag:4];
            [alertView show];
            [alertView release];
            
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            
            alertView = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                   message:@"请注意！没有可用的WIFI，将耗费您的手机流量"
                                                  delegate:self
                                         cancelButtonTitle:@"确认"
                                         otherButtonTitles:nil];
            
            
            [alertView setTag:4];
            [alertView show];
            [alertView release];
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            
            
            break;
        }
    }
}


- (void)customizeInterface
{
    UIImage *tabBackground = [UIImage imageNamed:@"bottom-strip.png"];
    //   resizableImageWithCapInsets:UIEdgeInsetsMake(0, 425, 320, 20)];
    [[UITabBar appearance] setBackgroundImage:tabBackground];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"bg.png"]];

    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSUInteger index=[[tabBarController viewControllers] indexOfObject:viewController];
    switch (index)
    {
        case 0:
            
            //tabbar.selectedIndex=0;

            break;
        case 1:
           
           // tabbar.selectedIndex=1;
            
            break;
        case 2:
            
           // tabbar.selectedIndex=2;
            break;
        case 3:
            //tabbar.selectedIndex=3;
            break;
        case 4:
            //tabbar.selectedIndex=4;
            break;
    
        default:
            break;
            
    }
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //判断是否为微博的回调
    BOOL str=0;
    if ([self.fromPage isEqualToString:@"SubCategory"] && [[url absoluteString] rangeOfString:@"wb"].location!=NSNotFound)
    {
        str=[self.viewController.wbapi handleOpenURL:url];
    }
    else if ([self.fromPage isEqualToString:@"Category"] && [[url absoluteString] rangeOfString:@"wb"].location!=NSNotFound)
    {
        str=[self.viewController1.wbapi handleOpenURL:url];
    }
  
    
    return str;
    
}
//By Ye Call Back
#pragma mark -SSO
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self.viewController.wbapi handleOpenURL:url];
}
@end
