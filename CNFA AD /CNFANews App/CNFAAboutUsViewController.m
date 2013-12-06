//
//  CNFAAboutUsViewController.m
//  CNFANews App
//
//  Created by Dex on 24/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAAboutUsViewController.h"
#import "CNFAContactUsViewController.h"
#import "CNFATermsANDPrivacyViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CNFAAboutUsViewController ()

@end

@implementation CNFAAboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  self.title = NSLocalizedString(@"关于我们", @"关于我们");
      //  self.tabBarItem.image = [UIImage imageNamed:@"147.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      self.view.backgroundColor=[UIColor yellowColor];
    
     [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];
    
   

    
   fetchtext=[[NSMutableArray alloc]init];
   fetchTimeStamp=[[NSMutableArray alloc]init];    
  
   text=[[NSMutableArray alloc]init];
   TimeStamp=[[NSMutableArray alloc]init];
    
    
    
    
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
        navbarimage.frame=CGRectMake(0,20, 320,83);
    } else {
        navbarimage.frame=CGRectMake(0,0, 320,83);
    }
   
   [navbarimage setImage:[UIImage imageNamed:@"navbar1.png"]];
   navbarimage.userInteractionEnabled=TRUE;
   navbarimage.opaque = YES;
   [mainbg_img addSubview:navbarimage];
   [navbarimage release];
   
    
#pragma Navigation Bar Title
//    UILabel *navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(80,53,320,33);
//    navbartitle.text=[NSString stringWithFormat:@"杭州凡闻科技有限公司"];
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:13];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];

    
    
#pragma Buttom Bar ImageView
    UIImageView *midbg_img = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5)
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,93+20,292,388);
        } else {
            midbg_img.frame=CGRectMake(14,93,292,388);
        }
        
    }
    else
    {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,93+20,292,300);
        } else {
            midbg_img.frame=CGRectMake(14,93,292,300);
        }
        
    }
    
    [midbg_img setImage:[UIImage imageNamed:@"contact-bg.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];
    
    txt_view=[[UIWebView alloc]init];
    if(IS_IPHONE_5){      txt_view.frame=CGRectMake(10, 0, 272, 198+15);
    }
    else{
        txt_view.frame=CGRectMake(10, 0, 272, 165);
    }
    txt_view.backgroundColor=[UIColor clearColor];
    [txt_view setOpaque:NO];
   
    txt_view.delegate=self;
    [midbg_img addSubview:txt_view];
    

    
    
    
    maingScrollView = [[UIScrollView alloc] init];
    if (IS_IPHONE_5) {
        maingScrollView.frame=CGRectMake(0, 219, 292, 348);
    }
    else
    {
        maingScrollView.frame=CGRectMake(0,175, 292, 125);
    }
    maingScrollView.backgroundColor = [UIColor clearColor];
    maingScrollView.contentSize = CGSizeMake(292,200);
    [maingScrollView setCanCancelContentTouches:NO];
    maingScrollView.clipsToBounds = YES;
    maingScrollView.scrollEnabled = TRUE;
    maingScrollView.delegate=self;
    maingScrollView.tag=111;
    [midbg_img addSubview:maingScrollView];
    [maingScrollView release];

#pragma Contact US
    UIButton *feedbackbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5){   feedbackbtn.frame=CGRectMake(11,10,270,31.5);}
    else
    {
        feedbackbtn.frame=CGRectMake(11,10,270,31.5);
    }
    
    [feedbackbtn.titleLabel setFont:[UIFont fontWithName:@"ZhunYuan" size:16]];
    [feedbackbtn setTitle:@"反馈意见" forState:UIControlStateNormal];
    [feedbackbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [feedbackbtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 9.0f, 0.0f, 0.0f)];
    [feedbackbtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"feedback" ofType:@"png"]] forState:UIControlStateNormal];
    [feedbackbtn addTarget:self action:@selector(contactus_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:feedbackbtn];
    

    
#pragma Contact US
    UIButton *contactus_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5){   contactus_btn.frame=CGRectMake(11,50,270,31.5);}else{   contactus_btn.frame=CGRectMake(11,50,270,31.5);}
 //联系我们//
    
    [contactus_btn.titleLabel setFont:[UIFont fontWithName:@"ZhunYuan" size:16]];
    [contactus_btn setTitle:@"联系我们" forState:UIControlStateNormal];
    [contactus_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contactus_btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 9.0f, 0.0f, 0.0f)];
    [contactus_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"feedback" ofType:@"png"]] forState:UIControlStateNormal];
    [contactus_btn addTarget:self action:@selector(feedback_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:contactus_btn];
    
    
#pragma Terms Of Use
    UIButton *termsofuse_btn =[UIButton buttonWithType:UIButtonTypeCustom];
       if(IS_IPHONE_5){   termsofuse_btn.frame=CGRectMake(11,90,270,31.5);}else{   termsofuse_btn.frame=CGRectMake(11,90,270,31.5);}
 //使用条款  
    
    [termsofuse_btn.titleLabel setFont:[UIFont fontWithName:@"ZhunYuan" size:16]];
    [termsofuse_btn setTitle:@"使用条款" forState:UIControlStateNormal];
    [termsofuse_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [termsofuse_btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 9.0f, 0.0f, 0.0f)];
    [termsofuse_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"feedback" ofType:@"png"]] forState:UIControlStateNormal];
    [termsofuse_btn addTarget:self action:@selector(termsofuse_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:termsofuse_btn];
    

    
#pragma Privacy
    UIButton *privacy_btn =[UIButton buttonWithType:UIButtonTypeCustom];
       if(IS_IPHONE_5){privacy_btn.frame=CGRectMake(11,130,270,31.5);}
       else{privacy_btn.frame=CGRectMake(11,130,270,31.5);}
    [privacy_btn.titleLabel setFont:[UIFont fontWithName:@"ZhunYuan" size:16]];
    [privacy_btn setTitle:@"隐私条款" forState:UIControlStateNormal];
    [privacy_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [privacy_btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 9.0f, 0.0f, 0.0f)];
    [privacy_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"feedback" ofType:@"png"]] forState:UIControlStateNormal];
    [privacy_btn addTarget:self action:@selector(privacy_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:privacy_btn];
    

    
    tempindbg=[[[UIView alloc]init] autorelease];
    tempindbg.frame=CGRectMake(0,0,320,568);
    tempindbg.backgroundColor=[UIColor blackColor];
    tempindbg.alpha=0.5;
    tempindbg.hidden=TRUE;
    [mainbg_img addSubview:tempindbg];
    
    
    spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = CGPointMake(160, 260);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner stopAnimating];
    [spinner release];
    
    tempindbg.hidden=FALSE;
    [spinner startAnimating];
    
     
	// Do any additional setup after loading the view.
}






//-(void)fetch_previousTimeStamp_FromDB{
//    sqlite3_stmt * countstatement;
//    
//    if(fetchTimeStamp){
//        [fetchTimeStamp removeAllObjects];}
//    
//      
//    NSString *sqlString1 = [NSString stringWithFormat:@"select  TimeStamp  from AboutUS_Content WHERE MessageID=1111"];
//    
//    const char *sql = [sqlString1 UTF8String];
//    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
//        while(sqlite3_step(countstatement) == SQLITE_ROW){
//            NSString * UpdateTimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
//            [fetchTimeStamp addObject:UpdateTimeStamp];
//        }
//        sqlite3_finalize(countstatement);
//    }
//    
////    CNFAGetAboutUSService * AboutUS=[[CNFAGetAboutUSService alloc]init];
////    AboutUS.delegate=self;
////    [AboutUS callWebService:@"aboutus"];
//    
//}



//-(void)getcontentLists:(NSMutableArray *)ContentTitleName  getTimeStamp:(NSMutableArray *)ContentTimeStamp   status:(BOOL)value{
//    if(text){[text removeAllObjects];}
//    if(TimeStamp){[TimeStamp removeAllObjects];}
//    
//    text=[ContentTitleName mutableCopy];
//    TimeStamp=[ContentTimeStamp mutableCopy];
//    NSLog(@"CONTENT %@",text);
//    
//   
//    if([fetchTimeStamp isEqualToArray:TimeStamp]){
//    //FromDB
//        [self FetchRecord_AboutUS_Content_DB];
//        
//    }else{
//      //Delete insert
//        [self Delete_AboutUS_Content_Table_DB];
//    }
//    
//    
//}



//-(void)Delete_AboutUS_Content_Table_DB{
//    NSString *insertSQL;
//    insertSQL = [NSString stringWithFormat: @"DELETE FROM AboutUS_Content WHERE MessageID=1111"];
//    const char *insert_stmt = [insertSQL UTF8String];
//    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
//    sqlite3_step(InsertStatement);
//    sqlite3_finalize(InsertStatement);
//    [self InsertRecord_ToAboutUS_Contente_DB];
//}
//
//
//   
//-(void)InsertRecord_ToAboutUS_Contente_DB{
//    NSString *insertSQL;
//    for(int i=0; i<[text count];i++){
//        insertSQL = [NSString stringWithFormat: @"INSERT INTO AboutUS_Content (MessageFor,MessageID,Message,TimeStamp) VALUES (\"AboutUS\",\"1111\",\"%@\",\"%@\")",[text objectAtIndex:i],[TimeStamp objectAtIndex:i]];
//        if(remoteHostStatus != NotReachable)
//        {
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:[text objectAtIndex:i] forKey:@"About_US"];
//            [defaults synchronize];
//        }
//        NSLog(@"insertSQL-- %@",insertSQL);
//        const char *insert_stmt = [insertSQL UTF8String];
//        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
//        if (sqlite3_step(InsertStatement) == SQLITE_DONE)
//        {
//            NSLog(@"INSERTING ABT US>>>>>>");
//            
//        } else {
//            NSLog(@"FAILED ABT US>>>>>");
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            //txt_view.text=[NSString stringWithFormat:@"%@",[defaults objectForKey:@"About_US"]];
//        }
//
//        sqlite3_step(InsertStatement);
//    }
//    sqlite3_finalize(InsertStatement);
//    
//    [self FetchRecord_AboutUS_Content_DB];
//}
//
//
//-(void)FetchRecord_AboutUS_Content_DB{
//    sqlite3_stmt * countstatement;
//    
//    if(fetchtext){
//        [fetchtext removeAllObjects];}
//    if(fetchTimeStamp){
//        [fetchTimeStamp removeAllObjects];}
//    if (remoteHostStatus == NotReachable)
//    {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        //txt_view.text=[defaults objectForKey:@"About_US"];
//        
//        tempindbg.hidden=TRUE;
//        [spinner stopAnimating];
//    }
//    else
//    {
//        NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * from AboutUS_Content WHERE MessageID=1111"];
//        
//        const char *sql = [sqlString1 UTF8String];
//        if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
//            
//            while(sqlite3_step(countstatement) == SQLITE_ROW){
//                NSString * IDStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
//                NSString * TitleStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
//                NSLog(@"IDStrIDStrIDStr %@",IDStr);
//                [fetchtext addObject:IDStr];
//                [fetchTimeStamp addObject:TitleStr];
//            }
//            sqlite3_finalize(countstatement);
//        }
//        
//        if([fetchTimeStamp count]<1){
//            tempindbg.hidden=TRUE;
//            [spinner stopAnimating];
//        }
//        else{
//            //txt_view.text=[NSString stringWithFormat:@"%@",[fetchtext objectAtIndex:0]];
//            tempindbg.hidden=TRUE;
//            [spinner stopAnimating];
//        }
//    }
//
//}



-(void)feedback_btnAction
{
    NSLog(@"Contactus");
    CNFAContactUSNewViewController *contact_us=[[CNFAContactUSNewViewController alloc]init];
    [self.navigationController pushViewController:contact_us animated:YES];
    [contact_us release];
}

-(void)contactus_btnAction
{
    NSLog(@"Contactus");
    CNFAContactUsViewController *contact_us=[[CNFAContactUsViewController alloc]init];
    [self.navigationController pushViewController:contact_us animated:YES];
    [contact_us release];
}
-(void)termsofuse_btnAction{

    CNFATermsANDPrivacyViewController *termsofuse_Cls=[[CNFATermsANDPrivacyViewController alloc]init];
   // [termsofuse_Cls setTitlevalstr:@"Terms Of Use"];
    [termsofuse_Cls setKeystr:@"AB"];
    [self.navigationController pushViewController:termsofuse_Cls animated:YES];
    [termsofuse_Cls release];


}
-(void)privacy_btnAction{
    CNFATermsANDPrivacyViewController *termsofuse_Cls=[[CNFATermsANDPrivacyViewController alloc]init];
    [termsofuse_Cls setKeystr:@"CD"];
    [self.navigationController pushViewController:termsofuse_Cls animated:YES];
    [termsofuse_Cls release];
    

  }


-(void)viewWillAppear:(BOOL)animated{
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (flag==0) {
        if(remoteHostStatus != NotReachable)
        {
            flag=1;
            NSLog(@"REACHABLE.........");
            CNFAGetAboutUSService * AboutUS=[[CNFAGetAboutUSService alloc]init];
            AboutUS.delegate=self;
            [AboutUS callWebService:@"aboutus"];
        }
        else
        {
            UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                            message:@"当前没有可用网络，请检查后再试."
                                                            delegate:nil
                                                            cancelButtonTitle:@"确认"
                                                            otherButtonTitles:nil];
            [networkmessage show];
            [networkmessage show];
            [networkmessage release];
            flag=0;
            [txt_view loadHTMLString:@"" baseURL:nil];
             [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"当前没有可用网络，请检查后再试."] ]baseURL:nil];
        }
    } else {
        NSLog(@"DEFAULTS.........");
          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[defaults objectForKey:@"About_US"]] ]baseURL:nil];
    }
    
    
//    if(remoteHostStatus == NotReachable) {
//        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
//                                                                 message:@"当前没有可用网络，请检查后再试."
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"确认"
//                                                       otherButtonTitles:nil];            [networkmessage show];
//        [networkmessage show];
//        [networkmessage release];
////       [self FetchRecord_AboutUS_Content_DB];
//         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        if ([defaults objectForKey:@"About_US"] !=NULL) {
//            [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[defaults objectForKey:@"About_US"]] ]baseURL:nil];
//        } else {
//            [txt_view loadHTMLString:@"当前没有可用网络，请检查后再试." baseURL:nil];
//        }
//        
//        
//    }
//    else{
//        //[self fetch_previousTimeStamp_FromDB];
//           CNFAGetAboutUSService * AboutUS=[[CNFAGetAboutUSService alloc]init];
//           AboutUS.delegate=self;
//           [AboutUS callWebService:@"aboutus"];
//    }
    tempindbg.hidden=TRUE;
    [spinner stopAnimating];
 }
-(void)getcontentLists:(NSString *)ContentTitleName status:(BOOL)value
{

   [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",ContentTitleName] ]baseURL:nil];
    if(remoteHostStatus != NotReachable)
    {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:ContentTitleName forKey:@"About_US"];
    [defaults synchronize];
    }
    tempindbg.hidden=TRUE;
    [spinner stopAnimating];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back_btnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
