//
//  CNFATermsANDPrivacyViewController.m
//  CNFANews App
//
//  Created by Dex on 26/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFATermsANDPrivacyViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CNFATermsANDPrivacyViewController ()

@end

@implementation CNFATermsANDPrivacyViewController
@synthesize Titlevalstr,txt_view,keystr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];

    
    
    // privicyID=[[NSMutableArray alloc] init];
     PrivTect=[[NSMutableArray alloc] init];
     UpdateTime=[[NSMutableArray alloc] init];
    
    fetchprivicyID=[[NSMutableArray alloc] init];
    fetchPrivTect=[[NSMutableArray alloc] init];
    fetchUpdateTime=[[NSMutableArray alloc] init];
    
    
    
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
//    navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
//    
//    
////    if ([keystr isEqualToString:@"AB"]) {
////        navbartitle.text=[NSString stringWithFormat:@"Terms Of Use"];
////    }else{
////        navbartitle.text=[NSString stringWithFormat:@"Privacy"];
////    }
//
//    if ([keystr isEqualToString:@"AB"]) {
//        navbartitle.text=[NSString stringWithFormat:@"使用条款"];
//    }else{
//        navbartitle.text=[NSString stringWithFormat:@"隐私条款"];
//    }
//
//  
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:18];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];
    
//   navbartitle=[[UILabel alloc] init];
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
#pragma NaviGation Left(back button) bar Button
    UIButton *back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame=CGRectMake(5,27,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//    [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//    [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:back_btn];

    
#pragma Buttom Bar ImageView
    UIImageView *midbg_img = [[UIImageView alloc] init];
    if(IS_IPHONE_5){
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,83+20,292,390);
        } else {
            midbg_img.frame=CGRectMake(14,83,292,390);
        }
        
    }
    else{
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            midbg_img.frame=CGRectMake(14,83+20,292,305.5);
        } else {
            midbg_img.frame=CGRectMake(14,83,292,305.5);
        }
        
    }
    [midbg_img setImage:[UIImage imageNamed:@"contact-bg.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    midbg_img.layer.masksToBounds = YES;
    midbg_img.layer.cornerRadius = 10;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];
    
    
#pragma ScrollView
   UIScrollView *maingScrollView = [[UIScrollView alloc] init];
    if (IS_IPHONE_5) {
         maingScrollView.frame=CGRectMake(0, 15, 292, 400.5);
    }
   else
   {
        maingScrollView.frame=CGRectMake(0, 10, 292, 295.5);
   }
    maingScrollView.backgroundColor = [UIColor clearColor];
    maingScrollView.contentSize = CGSizeMake(292,400);
    [maingScrollView setCanCancelContentTouches:NO];
    maingScrollView.clipsToBounds = YES;
    maingScrollView.scrollEnabled = FALSE;
    [maingScrollView setShowsHorizontalScrollIndicator:NO];
    [maingScrollView setShowsVerticalScrollIndicator:NO];
    
    maingScrollView.tag=111;
    [midbg_img addSubview:maingScrollView];
    [maingScrollView release];
      

    txt_view=[[UIWebView alloc]init];
    if (IS_IPHONE_5) {
        txt_view.frame=CGRectMake(10, 10, 272, 360.5);

    }
    else
    {
        txt_view.frame=CGRectMake(10, 10, 272, 280.5);

    }
    txt_view.backgroundColor=[UIColor clearColor];
    [txt_view setOpaque:NO];
     //txt_view.textColor=[UIColor whiteColor];
    //txt_view.font=[UIFont fontWithName:@"ZhunYuan" size:14];
    //txt_view.editable=FALSE;
     txt_view.dataDetectorTypes=UIDataDetectorTypeLink|UIDataDetectorTypePhoneNumber;
    txt_view.delegate=self;
    [maingScrollView addSubview:txt_view];
    
    
    
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
    
 if([keystr isEqualToString:@"AB"]){
     
     if(remoteHostStatus != NotReachable)
     {
         
         NSLog(@"REACHABLE.........");
         CNFAGetAboutUSService * AboutUS=[[CNFAGetAboutUSService alloc]init];
         AboutUS.delegate=self;
         [AboutUS callWebService:@"termsofuse"];
         
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
         
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         if ([defaults objectForKey:@"privacy"] !=NULL) {
             [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[defaults objectForKey:@"Termsof_use"]] ]baseURL:nil];
         } else {
             [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"当前没有可用网络，请检查后再试."] ]baseURL:nil];
             
         }
         tempindbg.hidden=TRUE;
         [spinner stopAnimating];
     }
     


}
 else{

    
         if(remoteHostStatus != NotReachable)
         {
            
             NSLog(@"REACHABLE.........");
             CNFAGetAboutUSService * AboutUS=[[CNFAGetAboutUSService alloc]init];
             AboutUS.delegate=self;
             [AboutUS callWebService:@"privacy"];

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
             
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             if ([defaults objectForKey:@"privacy"] !=NULL) {
                 [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[defaults objectForKey:@"privacy"]] ]baseURL:nil];
             } else {
                 [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"当前没有可用网络，请检查后再试."] ]baseURL:nil];

             }
             tempindbg.hidden=TRUE;
             [spinner stopAnimating];
         }
     
     
     

  }

   
    

}

-(void)getcontentLists:(NSString *)ContentTitleName status:(BOOL)value
{
    [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",ContentTitleName] ]baseURL:nil];
    if([keystr isEqualToString:@"CD"])
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:ContentTitleName forKey:@"privacy"];
        [defaults synchronize];
    }
    else if([keystr isEqualToString:@"AB"])
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:ContentTitleName forKey:@"Termsof_use"];
        [defaults synchronize];
    }
    tempindbg.hidden=TRUE;
    [spinner stopAnimating];
    
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
        
        ph=[ph stringByReplacingOccurrencesOfString:@"tel" withString:@"致电"];
        ph=[ph stringByReplacingOccurrencesOfString:@"%EF%BC%8D" withString:@""];
        self.ph1=[ph stringByReplacingOccurrencesOfString:@"致电" withString:@""];
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.ph1]]];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:inRequest.URL];
        }

        
        return NO;
    }
    
    
    return YES;
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag==1111)
    {
        NSLog(@"PHONE NUMBER --- %@",self.ph1);
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.ph1 ]]];
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

//-(void)fetch_previousPriviTimeStamp_FromDB{
//    sqlite3_stmt * countstatement;
//    
//    if(fetchUpdateTime){
//        [fetchUpdateTime removeAllObjects];}
//    
//    
//    NSString *sqlString1 = [NSString stringWithFormat:@"select TimeStamp from  AboutUS_Content WHERE MessageID=2222"];
//    
//    const char *sql = [sqlString1 UTF8String];
//    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
//        while(sqlite3_step(countstatement) == SQLITE_ROW){
//            NSString * UpdateTimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
//            [fetchUpdateTime addObject:UpdateTimeStamp];
//        }
//        sqlite3_finalize(countstatement);
//    }
//    
//    CNFAGetAboutUSService * AboutUS=[[CNFAGetAboutUSService alloc]init];
//    AboutUS.delegate=self;
//    [AboutUS callWebService:@"privacy"];
//    
//}
//
//
//-(void)Delete_AboutUS_Privi_Content_Table_DB{
//    NSString *insertSQL;
//    insertSQL = [NSString stringWithFormat: @"DELETE FROM AboutUS_Content WHERE MessageID=2222"];
//    const char *insert_stmt = [insertSQL UTF8String];
//    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
//    sqlite3_step(InsertStatement);
//    sqlite3_finalize(InsertStatement);
//    [self InsertRecord_ToAboutUS_Privi_Contente_DB];
//}
//
//
//
//
//-(void)InsertRecord_ToAboutUS_Privi_Contente_DB{
//    NSString *insertSQL;
//    for(int i=0; i<[PrivTect count];i++){
//        insertSQL = [NSString stringWithFormat: @"INSERT INTO AboutUS_Content (MessageFor,MessageID,Message,TimeStamp) VALUES (\"Privicy\",\"2222\",\"%@\",\"%@\")",[PrivTect objectAtIndex:i],[UpdateTime objectAtIndex:i]];
//        
//        NSLog(@"insertSQL-- %@",insertSQL);
//        const char *insert_stmt = [insertSQL UTF8String];
//        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
//        sqlite3_step(InsertStatement);
//    }
//    sqlite3_finalize(InsertStatement);
//    
//    [self FetchRecord_AboutUS_Priv_Content_DB];
//}
//
//
//-(void)FetchRecord_AboutUS_Priv_Content_DB{
//    sqlite3_stmt * countstatement;
//    
//    if(fetchPrivTect){
//        [fetchPrivTect removeAllObjects];}
//    if(fetchUpdateTime){
//        [fetchUpdateTime removeAllObjects];}
//    
//    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * from AboutUS_Content WHERE MessageID=2222"];
//    
//    const char *sql = [sqlString1 UTF8String];
//    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
//        while(sqlite3_step(countstatement) == SQLITE_ROW){
//            NSString * IDStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
//            [fetchPrivTect addObject:IDStr];
//            //[fetchTimeStamp addObject:TitleStr];
//        }
//        sqlite3_finalize(countstatement);
//    }
//    
//    if([fetchPrivTect count]<1){
//        tempindbg.hidden=TRUE;
//        [spinner stopAnimating];
//    }
//    else{
//        //txt_view.text=[NSString stringWithFormat:@"%@",[fetchPrivTect objectAtIndex:0]];
//        
//        [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><style type='text/css'> p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none;  }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[fetchPrivTect objectAtIndex:0]] ]baseURL:nil];
//
//        tempindbg.hidden=TRUE;
//        [spinner stopAnimating];}
//    
//}
//
////<a href="#" x-apple-data-detectors="false">666-777-777</a>
//
////******************************************************************************************************************
//
//
//
//-(void)fetch_previousTermTimeStamp_FromDB{
//    sqlite3_stmt * countstatement;
//    
//    if(fetchUpdateTime){
//        [fetchUpdateTime removeAllObjects];}
//    
//    
//    NSString *sqlString1 = [NSString stringWithFormat:@"select  TimeStamp  from AboutUS_Content WHERE MessageID=3333"];
//    
//    const char *sql = [sqlString1 UTF8String];
//    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
//        while(sqlite3_step(countstatement) == SQLITE_ROW){
//            NSString * UpdateTimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
//            [fetchUpdateTime addObject:UpdateTimeStamp];
//        }
//        sqlite3_finalize(countstatement);
//    }
//    
//    TermofUses=TRUE;
//    
//    CNFAGetAboutUSService * AboutUS=[[CNFAGetAboutUSService alloc]init];
//    AboutUS.delegate=self;
//    [AboutUS callWebService:@"termsofuse"];
//    
//}
//
//
//-(void)Delete_AboutUS_Term_Content_Table_DB{
//    NSString *insertSQL;
//    insertSQL = [NSString stringWithFormat: @"DELETE FROM AboutUS_Content WHERE MessageID=3333"];
//    const char *insert_stmt = [insertSQL UTF8String];
//    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
//    sqlite3_step(InsertStatement);
//    sqlite3_finalize(InsertStatement);
//    [self InsertRecord_ToAboutUS_Term_Contente_DB];
//}
//
//
//
//
//-(void)InsertRecord_ToAboutUS_Term_Contente_DB{
//    NSString *insertSQL;
//    for(int i=0; i<[PrivTect count];i++){
//        insertSQL = [NSString stringWithFormat: @"INSERT INTO AboutUS_Content (MessageFor,MessageID,Message,TimeStamp) VALUES (\"TermCon\",\"3333\",\"%@\",\"%@\")",[PrivTect objectAtIndex:i],[UpdateTime objectAtIndex:i]];
//       
//         if(remoteHostStatus != NotReachable)
//         {
//              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//             [defaults setObject:[PrivTect objectAtIndex:i] forKey:@"TermsofUSe"];
//             [defaults synchronize];
//         }
//      
//        
//        
//        NSLog(@"insertdsfdsfSQL-- %@",insertSQL);
//        const char *insert_stmt = [insertSQL UTF8String];
//        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
//        
//        if (sqlite3_step(InsertStatement) == SQLITE_DONE)
//        {
//            NSLog(@"INSERTING>>>>>>");
//            
//        } else {
//            NSLog(@"FAILED >>>>>");
//             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//             [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[defaults objectForKey:@"TermsofUSe"]] ]baseURL:nil];
//        }
//        sqlite3_step(InsertStatement);
//    }
//    sqlite3_finalize(InsertStatement);
//    
//    [self FetchRecord_AboutUS_Term_Content_DB];
//}
//
//
//-(void)FetchRecord_AboutUS_Term_Content_DB{
//    sqlite3_stmt * countstatement;
//    
//    if(fetchPrivTect){
//        [fetchPrivTect removeAllObjects];}
//    if(fetchUpdateTime){
//        [fetchUpdateTime removeAllObjects];}
//    
//    
//    if (remoteHostStatus == NotReachable)
//    {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[defaults objectForKey:@"TermsofUSe"]] ]baseURL:nil];
//        
//        tempindbg.hidden=TRUE;
//        [spinner stopAnimating];
//    }
//    else
//    {
//    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * from AboutUS_Content WHERE MessageID=3333"];
//    
//    const char *sql = [sqlString1 UTF8String];
//    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
//        while(sqlite3_step(countstatement) == SQLITE_ROW){
//            NSString * IDStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
//             [fetchPrivTect addObject:IDStr];
//       }
//        sqlite3_finalize(countstatement);
//    }
//    
//    if([fetchPrivTect count]<1){
//        tempindbg.hidden=TRUE;
//        [spinner stopAnimating];
//    }
//    else{
//        ///txt_view.text=[NSString stringWithFormat:@"%@",[fetchPrivTect objectAtIndex:0]];
//        [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[fetchPrivTect objectAtIndex:0]] ]baseURL:nil];
//
//        tempindbg.hidden=TRUE;
//        [spinner stopAnimating];}
//    }
//    
//}





//-(void)getcontentLists:(NSMutableArray *)ContentTitleName  getTimeStamp:(NSMutableArray *)ContentTimeStamp   status:(BOOL)value{
//    if(PrivTect){[PrivTect removeAllObjects];}
//    if(UpdateTime){[UpdateTime removeAllObjects];}
//    
//     PrivTect=[ContentTitleName mutableCopy];
//     UpdateTime=[ContentTimeStamp mutableCopy];
//    
//    [PrivTect retain];
//    
////    if([keystr isEqualToString:@"AB"]){
////        TermofUses=FALSE;
////        
////        if([UpdateTime isEqualToArray:fetchUpdateTime]){
////            [self FetchRecord_AboutUS_Term_Content_DB];
////        }
////        else{
////            [self Delete_AboutUS_Term_Content_Table_DB];
////        
////        }
////    }
////    else{
//    
//        if([PrivTect count]>0){
//            
//           // txt_view.text=[NSString stringWithFormat:@"%@",[PrivTect objectAtIndex:0]];
//               [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:0; } p { color:white; font-family:ZhunYuan; font-size:14px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",[NSString stringWithFormat:@"%@",[ContentTitleName objectAtIndex:0]] ]baseURL:nil];
//        
//        }
//        tempindbg.hidden=TRUE;
//        [spinner stopAnimating];
//        
//        
////        
////        if([UpdateTime isEqualToArray:fetchUpdateTime]){
////            
////            
////            [self FetchRecord_AboutUS_Priv_Content_DB];
////        }
////        else{
////            [self Delete_AboutUS_Privi_Content_Table_DB];
////            
////        }
//   // }
//
//}

-(void)back_btnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
