//
//  CNFASubCategoryDetailViewController.m
//  CNFANews App
//
//  Created by iMac Apple on 27/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFASubCategoryDetailViewController.h"
#import "CNFAShareAppViewController.h"
#import "CNFAGlobalDataClass.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define WiressSDKDemoAppKey     @"801434831"
#define WiressSDKDemoAppSecret  @"6e550f71bb105271cf4738299d79c199"
#define REDIRECTURI             @"http://www.hzfanwen.com/products_ad.html"
#define TCWBAlertViewLogOutTag          100
#define TCWBAlertViewLogInTag           101
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CNFASubCategoryDetailViewController ()

@end

@implementation CNFASubCategoryDetailViewController

@synthesize uiasView;
@synthesize eMailaddTimestr,eMailaddCitystr,eMailaddNewsstr,eMaildetailmsgstr,eMailSubjectstr;
@synthesize addCityNamestr,adddetailtextstr,addNewsNamestr,addTimestr,addtitlestr,addIDstr,addUpdateTime;
@synthesize subCategory_AddIDarr,subCategory_AddCityNamearr,subCategory_AddCreatedTimearr,subCategory_AddDetailTextarr,subCategory_AddNewsNamearr,subCategory_AddTitlearr,subCategory_UpdateTimearr,pageCurr,fromTab;
@synthesize cityName,news_Catname,news_Namestr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
//    CNFAGlobalDataClass *obj=[CNFAGlobalDataClass getInstance];
//    if ([obj.lognDone isEqualToString:@"LoginDone"]) {
//        [obj setLognDone:@""];
//        NSLog(@"share ...............");
//        [ self onLogInOAuthButtonPressed ];
//    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     NSLog(@"subCategory_AddCreatedTimearr::::%@", subCategory_AddCreatedTimearr);
    
//    eMailSubjectstr=@"";
//    eMaildetailmsgstr=@"";
//    eMailaddCitystr=@"";
//    eMailaddNewsstr=@"";
//    eMailaddTimestr=@"";
    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];
    
    //Check content by add id
    [self Check_recordByAddId_DB];

    
    
#pragma Main BackGround ImageView
    UIImageView *mainbg_img = [[UIImageView alloc] init];
    if(IS_IPHONE_5){ mainbg_img.frame=CGRectMake(0,0, 320,520);}
    else{
        mainbg_img.frame=CGRectMake(0,0, 320,480);}
    [mainbg_img setImage:[UIImage imageNamed:@"Main-bg.png"]];
    mainbg_img.userInteractionEnabled=TRUE;
    mainbg_img.opaque = YES;
    [self.view addSubview:mainbg_img];
    [mainbg_img release];
    
#pragma Navigation Bar imageView
    UIImageView *navbarimage = [[UIImageView alloc] init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        navbarimage.frame=CGRectMake(0,20, 320,41.5);
    } else {
        navbarimage.frame=CGRectMake(0,0, 320,41.5);
    }
    
    [navbarimage setImage:[UIImage imageNamed:@"navbar.png"]];
    navbarimage.userInteractionEnabled=TRUE;
    navbarimage.opaque = YES;
    [mainbg_img addSubview:navbarimage];
    [navbarimage release];
    
#pragma Navigation Bar Title
//    navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
//    navbartitle.text=[NSString stringWithFormat:@"%@",addtitlestr];
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:18];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];
    
    
#pragma NaviGation Left(back button) bar Button
    UIButton *back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame=CGRectMake(5,9,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//    [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//    [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:back_btn];
    
    UIImageView *searchbg_image = [[UIImageView alloc] init];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
         searchbg_image.frame=CGRectMake(0,41.5+20, 320,40.75);
    } else {
         searchbg_image.frame=CGRectMake(0,41.5, 320,40.75);
    }
   
    [searchbg_image setImage:[UIImage imageNamed:@"search-bg.png"]];
    searchbg_image.userInteractionEnabled=TRUE;
    searchbg_image.opaque = YES;
    [mainbg_img addSubview:searchbg_image];
    [searchbg_image release];
    
    UIImageView *category_img = [[UIImageView alloc] init];
    category_img.frame=CGRectMake(14,8.5, 292,21.5);
    [category_img setImage:[UIImage imageNamed:@"category-select.png"]];
    category_img.userInteractionEnabled=TRUE;
    category_img.opaque = YES;
    [searchbg_image addSubview:category_img];
    [category_img release];
    
#pragma CITY Label
    
    UILabel *city_lbl=[[UILabel alloc] init];
    city_lbl.frame=CGRectMake(18,0,290,21);
    city_lbl.textAlignment=0;
    
    
    
    if ([self.fromTab isEqualToString:@"favourites"]) {
        city_lbl.text=[NSString stringWithFormat:@" 喜爱"];
    }
    else if ([self.fromTab isEqualToString:@"Newspaper"])
    {
        city_lbl.text=[NSString stringWithFormat:@" %@>>%@",self.news_Namestr,self.news_Catname];
    }
    else if ([self.fromTab isEqualToString:@"City"])
    {
        city_lbl.text=[NSString stringWithFormat:@" %@>>%@>>%@",self.cityName,self.news_Namestr,self.news_Catname];
    }
     else if ([self.fromTab isEqualToString:@"NewspaperSearch"])
     {
         city_lbl.text=[NSString stringWithFormat:@" %@",self.news_Namestr];
     }
     else if ([self.fromTab isEqualToString:@"CitySearch"])
     {
         city_lbl.text=[NSString stringWithFormat:@" %@",self.news_Namestr];
     }
     else if ([self.fromTab isEqualToString:@"NewspaperByCitySearch"])
     {
         city_lbl.text=[NSString stringWithFormat:@" %@",self.news_Namestr];
     }
     else if ([self.fromTab isEqualToString:@"CategorySearch"])
     {
         city_lbl.text=[NSString stringWithFormat:@" %@",self.news_Namestr];
     }
    
    
    
    
    city_lbl.textColor= [UIColor whiteColor];
    city_lbl.backgroundColor=[UIColor clearColor];
    city_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:13];
    [category_img addSubview:city_lbl];
    [city_lbl release];

#pragma Buttom Bar ImageView
    UIImageView *midbg_img = [[UIImageView alloc] init];
    if(IS_IPHONE_5)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
             midbg_img.frame=CGRectMake(14,93+20,292,380);
        } else {
             midbg_img.frame=CGRectMake(14,93,292,380);
        }
       
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,93+20,292,280);
        } else {
            midbg_img.frame=CGRectMake(14,93,292,280);
        }
        
    }
    [midbg_img setImage:[UIImage imageNamed:@"bg-midd.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    midbg_img.layer.masksToBounds = YES;
    midbg_img.layer.cornerRadius = 10;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];
    
#pragma ScrollView
    scrollViewHorizontal = [[UIScrollView alloc] init];
    if (IS_IPHONE_5) {
        
        
        scrollViewHorizontal.frame=CGRectMake(0, 0, 292, 380);
    }
    else
        scrollViewHorizontal.frame=CGRectMake(0, 0, 292,280);
    
    scrollViewHorizontal.backgroundColor = [UIColor clearColor];
    scrollViewHorizontal.contentSize = CGSizeMake(292*[subCategory_AddTitlearr count], 200);
    scrollViewHorizontal.showsHorizontalScrollIndicator = NO;
    [scrollViewHorizontal setCanCancelContentTouches:NO];
    scrollViewHorizontal.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollViewHorizontal.clipsToBounds = YES;
    scrollViewHorizontal.scrollEnabled = YES;
    scrollViewHorizontal.pagingEnabled=YES;
    scrollViewHorizontal.delegate=self;
    scrollViewHorizontal.tag=222;
    [midbg_img addSubview:scrollViewHorizontal];
    [scrollViewHorizontal release];
    
    
    
   
 
    
    
#pragma PageControl
    pageControl=[[UIPageControl alloc]init];
    
    if(IS_IPHONE_5)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            pageControl.frame=CGRectMake(15, 455+20+20, 290, 14);
        } else {
            pageControl.frame=CGRectMake(15, 455+20, 290, 14);
        }
        
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            pageControl.frame=CGRectMake(15, 390+20, 290, 14);
        }
        else
        {
            pageControl.frame=CGRectMake(15, 390, 290, 14);
        }
        
    }
    pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    pageControl.tag=12;
    pageControl.backgroundColor=[UIColor clearColor];
    [mainbg_img addSubview:pageControl];
    [pageControl release];
    
    
    // [self createCategoryButtons];
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];
    if ([subCategory_AddTitlearr count]>10) {
        pageControl.numberOfPages = 10;
        pageControl.currentPage = [pageCurr integerValue]%10;
    } else {
        pageControl.numberOfPages = [subCategory_AddTitlearr count];
        pageControl.currentPage = [pageCurr integerValue];
    }
    
    

#pragma Cell Image View
    cell_lbl1=[[UILabel alloc] init];
    if(IS_IPHONE_5 ){
     cell_lbl1.frame=CGRectMake(10,10,200,18);
    }
    else{
        cell_lbl1.frame=CGRectMake(10,10,200,18);}
        cell_lbl1.text=[NSString stringWithFormat:@"%@",addtitlestr];
    cell_lbl1.textAlignment=0;
    cell_lbl1.textColor= [UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];
    cell_lbl1.backgroundColor=[UIColor clearColor];
    cell_lbl1.font=[UIFont fontWithName:@"ZhunYuan" size:16];
    cell_lbl1.shadowColor = [UIColor grayColor];
    cell_lbl1.shadowOffset = CGSizeMake(0,0);
    [scrollViewHorizontal addSubview:cell_lbl1];
    [cell_lbl1 release];
    
    
    
#pragma Favorites Button.
    test_btm =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (IS_IPHONE_5) {
       test_btm.frame=CGRectMake(217,2,32,32);
    }
    else{
    test_btm.frame=CGRectMake(217,2,32,32);
    }
    if(favoritStatus)
       {
           favoritStatus=FALSE;
           test_btm.tag=2222;
           [test_btm setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favourite_selectimg" ofType:@"png"]] forState:UIControlStateNormal];
       }
    else{
    test_btm.tag=1111;
           [test_btm setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favourite_unseltct" ofType:@"png"]] forState:UIControlStateNormal];}
    [test_btm addTarget:self action:@selector(favorites_btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollViewHorizontal addSubview:test_btm];

    
    
//    share_btnhiden =[UIButton buttonWithType:UIButtonTypeCustom];
//    if (IS_IPHONE_5) {
//        share_btnhiden.frame=CGRectMake(262,8,35,35);
//    }
//    else
//      share_btnhiden.frame=CGRectMake(262,8,35,35);
//  //  [share_btnhiden setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share-button" ofType:@"png"]] forState:UIControlStateNormal];
//    [share_btnhiden addTarget:self action:@selector(share_btnAction) forControlEvents:UIControlEventTouchUpInside];
//    [scrollViewHorizontal addSubview:share_btnhiden];
    
  
    
    
#pragma Share Button
    share_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    if (IS_IPHONE_5) {
         share_btn.frame=CGRectMake(255,3,22+7,21.5+9);
    }
    else
         share_btn.frame=CGRectMake(255,5,22+7,21.5+7);
    [share_btn setTag:[pageCurr integerValue]];
    [share_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share-button" ofType:@"png"]] forState:UIControlStateNormal];
    [share_btn addTarget:self action:@selector(share_btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollViewHorizontal addSubview:share_btn];
    
    
      
    
#pragma ScrollView
//    maingScrollView = [[UIScrollView alloc] init];
//    if (IS_IPHONE_5) {
//          maingScrollView.frame=CGRectMake(0, 30, 292, 300);
//         maingScrollView.contentSize = CGSizeMake(292,400);
//    }
//    else
//    {
//    maingScrollView.frame=CGRectMake(0, 30, 292,212);
//         maingScrollView.contentSize = CGSizeMake(292,280);
//    }
//    maingScrollView.backgroundColor = [UIColor clearColor];
//   
//    [maingScrollView setCanCancelContentTouches:NO];
//    maingScrollView.clipsToBounds = YES;
//    maingScrollView.scrollEnabled = YES;
//    [maingScrollView setShowsHorizontalScrollIndicator:NO];
//    [maingScrollView setShowsVerticalScrollIndicator:NO];
//    ///maingScrollView.scrollEnabled=FALSE;
//    maingScrollView.tag=111;
//    [scrollViewHorizontal addSubview:maingScrollView];
//    [maingScrollView release];
    
    
//    txt_view=[[UITextView alloc]init];
//    if (IS_IPHONE_5) {
//        txt_view.frame=CGRectMake(0, 40, 292, 262+35);
//    }
//    else
//    txt_view.frame=CGRectMake(0, 0, 292, 192+20);
//    txt_view.backgroundColor=[UIColor clearColor];
//    txt_view.textColor=[UIColor whiteColor];
//    txt_view.font=[UIFont fontWithName:@"ZhunYuan" size:15];
//    txt_view.editable=FALSE;
//    //txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
//    txt_view.text=[NSString stringWithFormat:@"%@",adddetailtextstr];
//    NSLog(@"TEXT %@",adddetailtextstr);
//    txt_view.delegate=self;
//    [maingScrollView addSubview:txt_view];
    
    
    txt_view=[[UIWebView alloc]init];
    if (IS_IPHONE_5) {
        txt_view.frame=CGRectMake(10, 40, 282-5, 1);
    }
    else
        txt_view.frame=CGRectMake(10,40, 282-5,1);
    txt_view.backgroundColor=[UIColor clearColor];
    [txt_view setOpaque:NO];
    //[txt_view setUserInteractionEnabled:NO];
//    txt_view.textColor=[UIColor whiteColor];
//    txt_view.font=[UIFont fontWithName:@"ZhunYuan" size:15];
//    txt_view.editable=FALSE;
    txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
    [txt_view setMultipleTouchEnabled:YES];
  //  txt_view.text=[NSString stringWithFormat:@"%@",adddetailtextstr];
     [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:2; } p { color:white; font-family:ZhunYuan; font-size:15px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",adddetailtextstr] baseURL:nil];
    NSLog(@"TEXT %@",adddetailtextstr);
    
    txt_view.delegate=self;
    
    [scrollViewHorizontal addSubview:txt_view];
    
    dummyView=[[CNFADummyView alloc] init ];
    if (IS_IPHONE_5) {
         dummyView.frame=CGRectMake(0, 60, 292, 270-30);
    }
    else
    {
         dummyView.frame=CGRectMake(0, txt_view.scrollView.contentSize.height, 292, 212-60);
    }
    
    [dummyView setBackgroundColor:[UIColor clearColor]];
    [txt_view addSubview:dummyView];
    [dummyView release];
#pragma Cell Image View
    celltxt_lbl3=[[UILabel alloc] init];
    if(IS_IPHONE_5){
        celltxt_lbl3.frame=CGRectMake(5,350,252+25,18);}
    else{
        celltxt_lbl3.frame=CGRectMake(35,255,252,18);}
    celltxt_lbl3.numberOfLines=1;
    celltxt_lbl3.text=[NSString stringWithFormat:@"%@ | %@ | %@",addNewsNamestr,addCityNamestr,addTimestr];
    celltxt_lbl3.textAlignment=2;
    celltxt_lbl3.textColor= [UIColor colorWithRed:68/255.0f green:192/255.0f blue:181/255.0f alpha:1];
    celltxt_lbl3.backgroundColor=[UIColor clearColor];
    celltxt_lbl3.font=[UIFont fontWithName:@"ZhunYuan" size:14];
    celltxt_lbl3.shadowColor = [UIColor grayColor];
    celltxt_lbl3.shadowOffset = CGSizeMake(0,0);
    [scrollViewHorizontal addSubview:celltxt_lbl3];
    [celltxt_lbl3 release];
    
    
    transview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [transview setBackgroundColor:[UIColor clearColor]];
    [transview setHidden:YES];
    [mainbg_img addSubview:transview];
    
    self.uiasView = [[CustomUIASView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height + 230), 320, 300)];
    
    [self.uiasView.tencentButton addTarget:self action:@selector(TencentWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.weChatButton addTarget:self action:@selector(sendTextContent_WeChat) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.emailButton addTarget:self action:@selector(openMail:) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.sinaweiboButton addTarget:self action:@selector(SinaWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.smsButton addTarget:self action:@selector(message_btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.uiasView.cancleBtn addTarget:self action:@selector(dismiss_btn:) forControlEvents:UIControlEventTouchUpInside];
    [mainbg_img addSubview:self.uiasView];
    
    
  
    
      //if yes Status of Time Stamp
    
    //if time stamp diff delete and add
    
    
    [scrollViewHorizontal setContentOffset:CGPointMake(scrollViewHorizontal.frame.size.width*[pageCurr integerValue], 0) animated:YES];
	// Do any additional setup after loading the view.
}
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType
{
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        NSLog(@"TELEPHONE URL %@",inRequest.URL);
        //[[UIApplication sharedApplication] openURL:inRequest.URL];
        if ([[inRequest.URL scheme] isEqual:@"mailto"]) {
            NSLog(@"mail to");
            if ([MFMailComposeViewController canSendMail]){
                MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                mailer.mailComposeDelegate = self;
                
                NSArray *toRecipients = [NSArray arrayWithObjects:[[NSString stringWithFormat:@"%@",inRequest.URL]stringByReplacingOccurrencesOfString:@"mailto:" withString:@""], nil];
                [mailer setToRecipients:toRecipients];
                
                
                [self presentModalViewController:mailer animated:YES];
                [mailer release];
            }
            else{
                
                UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"警告"
                                                                 message:@"您的设备不支持的作曲家表"
                                                                delegate:nil
                                                       cancelButtonTitle:@"确认"
                                                       otherButtonTitles: nil];
                [alert1 show];
                [alert1 release];
            }

            return NO;
        }
        else if ([[inRequest.URL scheme] isEqual:@"tel"])
        {
            NSLog(@"tel");
        
        
        
        NSString *ph=[[NSString stringWithFormat:@"%@",inRequest.URL] stringByReplacingOccurrencesOfString:@"%20" withString:@""];
        self.ph1=[ph stringByReplacingOccurrencesOfString:@"tel" withString:@""];
        ph=[ph stringByReplacingOccurrencesOfString:@"tel" withString:@"致电"];
        
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.ph1]]];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:inRequest.URL];
        }
//        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"提醒:"
//                                                        message:[NSString stringWithFormat:@"%@",ph]
//                                                       delegate:self
//                                              cancelButtonTitle:@"确认"
//                                              otherButtonTitles:@"取消",Nil];
//        [alert1 setTag:1111];
//        [alert1 show];
//        [alert1 release];
        
        //[[UIApplication sharedApplication] openURL:inRequest.URL];
        
        return NO;
    }
    
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag==1111)
    {
        NSLog(@"PHONE NUMBER %@",self.ph1);
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.ph1]]];
        } else {
            UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"提醒:" message:@"您的设备不支持此功能." delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [Notpermitted show];
            [Notpermitted release];
        }
        
    }
    if (buttonIndex == 1)
    {
        //Code for download button
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    
    
    //DragonDataObjectClass *obj=[DragonDataObjectClass getInstance];
     aWebView.frame=CGRectMake(originX, 40, 282-5,1);
    CGSize contentSize = aWebView.scrollView.contentSize;
    // NSLog(@"webView contentSize: %@", NSStringFromCGSize(contentSize));
    if (IS_IPHONE_5) {
        if (contentSize.height>300) {
            //[dummyView setHidden:YES];
            contentHgt=300;
            dummyView.frame=CGRectMake(0, contentSize.height, 292, 212-60);
            [dummyView setHidden:NO];
            txt_view.frame=CGRectMake(originX,40, 282-5,300);
        }
        else
        {
            contentHgt=contentSize.height;
            
            txt_view.frame=CGRectMake(originX,40, 282-5,contentSize.height);
            dummyView.frame=CGRectMake(0, contentSize.height, 292, 212-60);
            [dummyView setHidden:NO];
            
        }
        
    } else {
        if (contentSize.height>212) {
            
            contentHgt=212;
            dummyView.frame=CGRectMake(0, contentSize.height, 292, 212-60);
            [dummyView setHidden:NO];

            txt_view.frame=CGRectMake(originX,40, 282-5,212);
        }
        else
        {
            
            contentHgt=contentSize.height;
            
            txt_view.frame=CGRectMake(originX,40, 282-5,contentSize.height);
            dummyView.frame=CGRectMake(0, contentSize.height, 292, 212-60);
            [dummyView setHidden:NO];
            
        }
        
    }
    
    
    
    
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
    if (_scrollView.tag==222)
    {
        CGFloat pageWidth = _scrollView.frame.size.width;
        
        int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) +1 ;
        
        
        if(IS_IPHONE_5 ){
            cell_lbl1.frame=CGRectMake(10+(292*page),10,200,18);
            test_btm.frame=CGRectMake(217+(292*page),2,32,32);
           // share_btnhiden.frame=CGRectMake(262+(292*page),5,35,35);
            share_btn.frame=CGRectMake(255+(292*page),3,22+7,21.5+9);
            txt_view.frame=CGRectMake(10+(292*page), 40, 282-5, contentHgt);
            originX=10+(292*page);
            celltxt_lbl3.frame=CGRectMake(5+(292*page),350,252+25,18);
            
            [self Check_recordByAddId_DB];
            [test_btm removeFromSuperview];
            test_btm =[UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            test_btm.frame=CGRectMake(217+(292*page),2,32,32);
            
            if(favoritStatus)
            {
                favoritStatus=FALSE;
                test_btm.tag=2222;
                [test_btm setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favourite_selectimg" ofType:@"png"]] forState:UIControlStateNormal];
            }
            else{
                test_btm.tag=1111;
                [test_btm setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favourite_unseltct" ofType:@"png"]] forState:UIControlStateNormal];}
            [test_btm addTarget:self action:@selector(favorites_btnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollViewHorizontal addSubview:test_btm];
            
        }
        else{
            cell_lbl1.frame=CGRectMake(10+(292*page),10,200,18);
            //share_btnhiden.frame=CGRectMake(262+(292*page),8,35,35);
            //test_btm.frame=CGRectMake(217+(292*page),2,32,32);
            share_btn.frame=CGRectMake(255+(292*page),5,22+7,21.5+7);
            txt_view.frame=CGRectMake(10+(292*page), 40, 282-5,contentHgt);
            originX=10+(292*page);
           // txt_view.frame=CGRectMake(0+(292*page), 40, 292, 262+15);
            celltxt_lbl3.frame=CGRectMake(35+(292*page),255,252,18);
            [self Check_recordByAddId_DB];
            [test_btm removeFromSuperview];
            test_btm =[UIButton buttonWithType:UIButtonTypeRoundedRect];
            NSLog(@"DID SCROLL CONTENT contentHgt  %f",contentHgt);
            test_btm.frame=CGRectMake(217+(292*page),2,32,32);
            
            if(favoritStatus)
            {
                favoritStatus=FALSE;
                test_btm.tag=2222;
                [test_btm setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favourite_selectimg" ofType:@"png"]] forState:UIControlStateNormal];
            }
            else{
                test_btm.tag=1111;
                [test_btm setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favourite_unseltct" ofType:@"png"]] forState:UIControlStateNormal];}
            [test_btm addTarget:self action:@selector(favorites_btnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollViewHorizontal addSubview:test_btm];

        }
        
        [share_btn setTag:page];
        
//        txt_view.text=[NSString stringWithFormat:@"%@",[subCategory_AddDetailTextarr objectAtIndex:page]];
         [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:2; } p { color:white; font-family:ZhunYuan; font-size:15px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[subCategory_AddDetailTextarr objectAtIndex:page]] baseURL:nil];
       
        cell_lbl1.text=[NSString stringWithFormat:@"%@",[subCategory_AddTitlearr objectAtIndex:page]];
        
        celltxt_lbl3.text=[NSString stringWithFormat:@"%@ | %@ | %@",[subCategory_AddNewsNamearr objectAtIndex:page],[subCategory_AddCityNamearr objectAtIndex:page],[subCategory_AddCreatedTimearr objectAtIndex:page]];
        
        
        
        if ([subCategory_AddTitlearr count]<10) {
             pageControl.numberOfPages = [subCategory_AddTitlearr count];
             pageControl.currentPage = page;
        }
        
        else
        {
            if (page>9)
            {
                
                if ([subCategory_AddTitlearr count]/10>1 && (page/10)*10 <=([subCategory_AddTitlearr count]/10)*10 )
                {
                    // NSLog(@"IF\n%d\n",page);
                    if (page >([subCategory_AddTitlearr count]/10)*10) {
                        pageControl.numberOfPages = [subCategory_AddTitlearr count]%10;
                    } else {
                        pageControl.numberOfPages = 10;
                    }
                    
                }
                else
                {
                    //NSLog(@"ELSE :::\n%d\n",page);
                    pageControl.numberOfPages = [subCategory_AddTitlearr count]%10;
                }
                
                pageControl.currentPage = page%10;
            }
            else
            {
                pageControl.numberOfPages = 10;
                pageControl.currentPage = page%10;
            }
 
        }
        
        
       
        
    }
   
    
    
}
-(void)Check_recordByAddId_DB{
    sqlite3_stmt * countstatement;
       
    NSString *sqlString1 = [NSString stringWithFormat:@"select UpdateTime from  FavouriteTabbar WHERE AddID=%@",[subCategory_AddIDarr objectAtIndex:pageControl.currentPage]];
    
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
        DBUpdateTimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
            [DBUpdateTimeStamp retain];
            if([DBUpdateTimeStamp length]>0){
                favoritStatus=TRUE;
                [self check_Updation_Status];
            }
            
        }
        sqlite3_finalize(countstatement);
    }
    
       
}

-(void)check_Updation_Status{

    if ([addUpdateTime isEqualToString:DBUpdateTimeStamp]) {
        NSLog(@"Match do nothing");
    }
    else{
        [self Delete_FevRecord_DB];
    }

}

-(void)Delete_FevRecord_DB{
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM FavouriteTabbar WHERE AddID=%@",[subCategory_AddIDarr objectAtIndex:pageControl.currentPage]];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
    [self Insert_FavRecordtoDB];
}


-(void)Insert_FavRecordtoDB{
    NSString *insertSQL;

    insertSQL = [NSString stringWithFormat: @"INSERT INTO FavouriteTabbar (AddID,AddTitle,AddDetailText,AddCreatedTime,AddNewsName,AddCityName,UpdateTime) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[subCategory_AddIDarr objectAtIndex:pageControl.currentPage],addtitlestr,adddetailtextstr,addTimestr,addNewsNamestr,addCityNamestr,addUpdateTime];
        
        NSLog(@"insertSQL-- %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
        sqlite3_step(InsertStatement);
        sqlite3_finalize(InsertStatement);
    
   // [self FetchRecord_All_CityList_DB];
}



-(void)Delete_FevRecord_BYbtn_DB{
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM FavouriteTabbar WHERE AddID=%@",[subCategory_AddIDarr objectAtIndex:pageControl.currentPage]];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
   // [self Insert_FavRecordtoDB];
}




-(void)favorites_btnAction:(UIButton *)sender{
    
    NSInteger  tagval=sender.tag;
    
    if(tagval==1111){
        test_btm.tag=2222;
        [test_btm setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favourite_selectimg" ofType:@"png"]] forState:UIControlStateNormal];
        [self Delete_FevRecord_DB];
    }
    else if(tagval==2222){
        test_btm.tag=1111;
        [test_btm setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favourite_unseltct" ofType:@"png"]] forState:UIControlStateNormal];
    
        [self Delete_FevRecord_BYbtn_DB];
    }
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *mystring=@"Ramana";
    [defaults setObject:mystring forKey:@"KEY1"];
}
-(void)back_btnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)share_btnAction:(id)sender
{//,,,,
    NSInteger tag = [sender tag];
    
//    CNFAShareAppViewController *gotoshare_Cls=[[CNFAShareAppViewController alloc]init];
//    [gotoshare_Cls setEMailSubjectstr:addtitlestr];
//    [gotoshare_Cls setEMaildetailmsgstr:adddetailtextstr];
//    [gotoshare_Cls setEMailaddNewsstr:addNewsNamestr];
//    [gotoshare_Cls setEMailaddCitystr:addCityNamestr];
//    [gotoshare_Cls setEMailaddTimestr:addTimestr];
//    [self.navigationController pushViewController:gotoshare_Cls animated:YES];
//    [gotoshare_Cls release];
    [transview setHidden:NO];
    self.eMailSubjectstr=[NSString stringWithFormat:@"%@",[subCategory_AddTitlearr objectAtIndex:tag]];
    
    self.eMaildetailmsgstr=[NSString stringWithFormat:@"%@",[subCategory_AddDetailTextarr objectAtIndex:tag]];
    self.eMailaddNewsstr=[NSString stringWithFormat:@"%@",[subCategory_AddNewsNamearr objectAtIndex:tag]];
    self.eMailaddCitystr=[NSString stringWithFormat:@"%@",[subCategory_AddCityNamearr objectAtIndex:tag]];
    self.eMailaddTimestr=[NSString stringWithFormat:@"%@",[subCategory_AddTitlearr objectAtIndex:tag]];
    
    if (shareClicked==0) {
        shareClicked=1;
        [UIView animateWithDuration:0.60f animations:^{
            
            CGRect uiasViewFrame   = self.uiasView.frame;
            uiasViewFrame.origin.y = (self.view.frame.size.height - 230);
            
            self.uiasView.frame = uiasViewFrame;
        }];
    } else {
        shareClicked=0;
        [UIView animateWithDuration:0.75f animations:^{
            
            CGRect uiasViewFrame   = self.uiasView.frame;
            uiasViewFrame.origin.y = (self.view.frame.size.height + 230);
            
            self.uiasView.frame = uiasViewFrame;
        }];
        
    }
}
-(void)dismiss_btn:(id)sender
{
    shareClicked=0;
    [transview setHidden:YES];
    [UIView animateWithDuration:0.75f animations:^{
        
        CGRect uiasViewFrame   = self.uiasView.frame;
        uiasViewFrame.origin.y = (self.view.frame.size.height + 230);
        
        self.uiasView.frame = uiasViewFrame;
    }];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

- (void) onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        NSString *strMsg = [NSString stringWithFormat:@"Result:%d", resp.errCode];
        NSLog(@"Response from Weixin was: %@",strMsg);
    }
}

- (void) onReq:(BaseReq*)req {
}



-(void)TencentWeibo:(id)sender{
    
    if(self.wbapi == nil)
    {
        self.wbapi = [[WeiboApi alloc]initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUri:REDIRECTURI] ;
        
        CNFAAppDelegate *dele=(CNFAAppDelegate*)[UIApplication sharedApplication].delegate;
        [dele setFromPage:@"SubCategory"];
        dele.viewController=self;
        
    }
    //first reflash the Auth,if Success Send Msg,Or Login
    [self.wbapi refreshAuthWithDelegate:self];
    
    
    
}
//By Ye
//Reflash Auth Failed,Start Login
- (void)DidAuthRefreshFail:(NSError *)error
{
    [self.wbapi loginWithDelegate:self andRootController:self];
    
}
//By Ye
//Reflash Auth Success ,Send WeiBo Msg
-(void)DidAuthRefreshed:(WeiboApi *)wbapi
{
    [self SendWeiBo];//Send Msg
}
//By Ye
//Login Success Continue,Send Msg
- (void)DidAuthFinished:(WeiboApi *)wbapi_
{
    [self SendWeiBo];//Send Msg
}
//By Ye
//If Click Cancel Button When at the Auth Page
-(void)DidAuthCanceled:(WeiboApi *)wbapi
{
    
}
//By Ye
//Auth Failed,Show Failure Msg
- (void)DidAuthFailWithError:(NSError *)error
{
    // NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    [self createFail:error];
    //[str release];
}
//By Ye
//After Sending Msg Successfully,We get the Callback,so Show Alert to tell user msg had sent
- (void)didReceiveRawData:(NSData *)data reqNo:(int)reqno
{
    
    
    [self showAlertMessage:@"分享成功"];
    
    
}
//By Ye
//Send Failed Log the Failed
- (void)didFailWithError:(NSError *)error reqNo:(int)reqno
{
    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
    
    NSLog(@"%@",str);
    [str release];
}

//By Ye
//Init Send Msg,and Init WBMsgViewController，this is uesd to show what we want to send.User can alse modify the text before send
-(void)SendWeiBo
{
//   if ([self.eMaildetailmsgstr length] >= 100)
//   {
//        self.eMaildetailmsgstr = [ self.eMaildetailmsgstr substringToIndex:100];
//   }
//   else
//   {
//       self.eMaildetailmsgstr = [ self.eMaildetailmsgstr substringToIndex:[ self.eMaildetailmsgstr length]];
//   }
    
    NSString* nsText;
//    nsText =[NSString stringWithFormat:@"%@\n\n%@\n\n%@ | %@ | %@\n@凡人凡事 http://www.hzfanwen.com/products_ad.html",self.eMailSubjectstr,self.eMaildetailmsgstr ,self.eMailaddNewsstr,self.eMailaddCitystr,self.eMailaddTimestr ];
    nsText =[NSString stringWithFormat:@"@凡人凡事 | http://www.hzfanwen.com/products_ad.html | %@ | %@ \n\n%@",self.eMailaddNewsstr,self.eMailaddCitystr,self.eMaildetailmsgstr  ];
    
    if (wbMsg==nil) {
        wbMsg=[[WBMsgViewController alloc]init];
        wbMsg.delegate=self;
    }
    
    
    [self presentViewController:wbMsg animated:YES completion:^{
        wbMsg.txtMsg.text=nsText;
    }];
    //[wbMsg release];//it cause crash on IOS6,I Confused
    
    
    
}
//By Ye
//the WBMsgViewController's call back when disappear the view, we discuess to send the message or not
-(void)WBMsgViewControllerFinishWith:(WBMsgViewController *)wbView Result:(BOOL)send
{
    if (send) {
        
        
        UIImage *pic = [UIImage imageNamed:@"icon.png"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                       wbView.txtMsg.text, @"content",
                                       pic, @"pic",
                                       nil];
        [self.wbapi requestWithParams:params apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
        [pic release];
        [params release];
    }
}

- (void)onSuccessLogin
{
    
}

//Login failed callback
- (void)onFailureLogin:(NSError *)error
{
    
//    NSString *message1 = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
//                                                        message:message1
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//    [alertView show];
//    [alertView release];
//    [message1 release];
}


-(void)SinaWeibo:(id)sender{
    //working with english content
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    {
        SLComposeViewController *swSheet = [SLComposeViewController
                                            composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        
        if ([eMaildetailmsgstr length] >= 110)
        {
            self.eMaildetailmsgstr = [ self.eMaildetailmsgstr substringToIndex:110];
        }
        else
        {
            self.eMaildetailmsgstr = [ self.eMaildetailmsgstr substringToIndex:[ self.eMaildetailmsgstr length]];
        }
//        [swSheet setInitialText:[NSString stringWithFormat:@"%@\n%@\n%@ | %@ | %@\n@凡人凡事 http://www.hzfanwen.com/products_ad.html",self.eMailSubjectstr,self.eMaildetailmsgstr,self.eMailaddNewsstr,self.eMailaddCitystr,self.eMailaddTimestr ]];
         [swSheet setInitialText:[NSString stringWithFormat:@"@凡人凡事 | http://www.hzfanwen.com/products_ad.html | %@ | %@ \n\n%@",self.eMailaddNewsstr,self.eMailaddCitystr,self.eMaildetailmsgstr]];
        
        NSLog(@"");
        [self presentViewController:swSheet animated:YES completion:nil];
    }
    else
    {
        //Error alert
    }  //    ACAccountStore *accountStore1 = [[ACAccountStore alloc] init];
    
}








#pragma We Chat
- (void)sendTextContent_WeChat{
    NSString* nsText;
  //  nsText =[NSString stringWithFormat:@"%@\n\n%@\n\n%@ | %@ | %@\n@凡人凡事 http://www.hzfanwen.com/products_ad.html",self.eMailSubjectstr,self.eMaildetailmsgstr,self.eMailaddNewsstr,self.eMailaddCitystr,self.eMailaddTimestr ];
    
    nsText =[NSString stringWithFormat:@"@凡人凡事 | http://www.hzfanwen.com/products_ad.html | %@ | %@ \n\n%@ ",self.eMailaddNewsstr,self.eMailaddCitystr,self.eMaildetailmsgstr ];
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = YES;
    req.text = nsText;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}




#pragma Message Button Action
-(IBAction)message_btn:(id)sender{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText]){
//        controller.body = [NSString stringWithFormat:@"%@ \n%@ | %@ | %@\n@凡人凡事 http://www.hzfanwen.com/products_ad.html", self.eMaildetailmsgstr,self.eMailaddNewsstr,self.eMailaddCitystr,self.eMailaddTimestr];
          controller.body = [NSString stringWithFormat:@"@凡人凡事 | http://www.hzfanwen.com/products_ad.html | %@ | %@ \n\n %@", self.eMailaddNewsstr,self.eMailaddCitystr,self.eMaildetailmsgstr];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}


#pragma Message Composer Delegate Metthod
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
            alert=[[UIAlertView alloc]initWithTitle:@"Myapp" message:@"message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}



#pragma mark - Open the mail interface
- (IBAction)openMail:(id)sender
{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:[NSString stringWithFormat:@"%@ (凡人凡事 - 报纸分类广告)",eMailSubjectstr]];
        //   NSArray *toRecipients = [NSArray arrayWithObjects:@"reddanna.k@search-value.com", nil];
        //   [mailer setToRecipients:toRecipients];
        //        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        //        NSData *imageData = UIImagePNGRepresentation(myImage);
        //        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
//        NSString *emailBody =[NSString stringWithFormat:@"%@ \n\n%@ | %@ | %@\n@凡人凡事 http://www.hzfanwen.com/products_ad.html", eMaildetailmsgstr,eMailaddNewsstr,eMailaddCitystr,eMailaddTimestr];
         NSString *emailBody =[NSString stringWithFormat:@"@凡人凡事 |http://www.hzfanwen.com/products_ad.html | %@ |%@ \n\n %@ ", eMailaddNewsstr,eMailaddCitystr,eMaildetailmsgstr];
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
        [mailer release];
    }
    else{
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"警告"
                                                         message:@"您的设备不支持的作曲家表"
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles: nil];
        [alert1 show];
        [alert1 release];
    }
    
}

#pragma mark - MFMailComposeController delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    [self dismissModalViewControllerAnimated:YES];
}


- (void)onSuccessAuthorizeLogin
{
    // [indicatorView stopAnimating];
    //[self onLogInOAuthButtonPressed];
}

- (void)postStart {
    NSLog(@"%s", __FUNCTION__);
    //    [self showAlertMessage:@"开始发送"];
}

- (void)createSuccess:(NSDictionary *)dict {
    NSLog(@"%s %@", __FUNCTION__,dict);
    
    if (dict !=NULL) {
        if ([[dict objectForKey:@"ret"] intValue] == 0) {
            [self showAlertMessage:@"Message sent"];
        }else {
            [self showAlertMessage:@"Message not sent"];
        }
    }
    
}

- (void)createFail:(NSError *)error {
    NSLog(@"error is %@",error);
    
    //[self showAlertMessage:@"Message not sent"];
}

- (void)showAlertMessage:(NSString *)msg {
    
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"确认"
                                             otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
}


//-(void)onLoginFailed:(WBErrCode)errCode msg:(NSString*)msg;
//{
//    
//    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Login failed" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    [av show];
//}

//-(void)onLoginSuccessed:(NSString*)name token:(WBToken*)token;
//{
//    NSString* msg = [NSString stringWithFormat:@"name=%@\n openid=%@\n token=%@\n expire=%u\n refreshToken=%@ \n omasToken=%@ omasKey = %@\n",name,token.openid,token.accessToken,token.expires,token.refreshToken, token.omasKey, token.omasToken];
//    
//    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Login successful" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    [av show];
//}
- (void)onLogin {
    
}
//- (void)onLogInOAuthButtonPressed
//{
//    UIImage * image  = [UIImage imageNamed:@"icon.png"];
//    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
//    //    UIImage *image = [UIImage imageNamed:path];
//    // 分享(自带 m登录功能)
//    NSString* nsText;
//    nsText =[NSString stringWithFormat:@"%@\n\n%@\n\n%@ | %@ | %@\n@凡人凡事 http://www.hzfanwen.com/products_ad.html",eMailSubjectstr,eMaildetailmsgstr,eMailaddNewsstr,eMailaddCitystr,eMailaddTimestr ];
//    
//    [self.weiboEngine UIBroadCastMsgWithContent:nsText
//                                       andImage:image
//                                    parReserved:nil
//                                       delegate:self
//                                    onPostStart:@selector(postStart)
//                                  onPostSuccess:@selector(createSuccess:)
//                                  onPostFailure:@selector(createFail:)];
//    
//}
@end
