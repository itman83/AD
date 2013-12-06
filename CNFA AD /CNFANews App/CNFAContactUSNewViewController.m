//
//  CNFAContactUSNewViewController.m
//  CNFANews App
//
//  Created by iMac Apple on 20/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAContactUSNewViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CNFAContactUSNewViewController ()

@end

@implementation CNFAContactUSNewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"147.png"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //Make Database connection
    database = [DBConnectionManager getDatabaseObject];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];
    
    
    IDarr=[[NSMutableArray alloc]init];
    Addressarr=[[NSMutableArray alloc]init];
    phonenoarr=[[NSMutableArray alloc]init];
    faxnoarr=[[NSMutableArray alloc]init];
    emailarr=[[NSMutableArray alloc]init];
    websitearr=[[NSMutableArray alloc]init];
    Eweiboarr=[[NSMutableArray alloc]init];
    renronarr=[[NSMutableArray alloc]init];

    
    
    
    
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
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
////    navbartitle.text=[NSString stringWithFormat:@"Contact US"];
//    navbartitle.text=[NSString stringWithFormat:@"联系我们"];
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
    back_btn.frame=CGRectMake(5,27,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    back_btn.titleLabel.font=[UIFont fontWithName:@"ZhunYuan" size:13.0f];
//    [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
//    [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:back_btn];
    
    
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
    
    UILabel *navbartitle=[[UILabel alloc] init];
    if (IS_IPHONE_5) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
             navbartitle.frame=CGRectMake(85,15,292,33);
        } else {
             navbartitle.frame=CGRectMake(85,15,292,33);
        }
       
    } else {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            navbartitle.frame=CGRectMake(85,10,292,33);
        } else {
            navbartitle.frame=CGRectMake(85,10,292,33);
        }
        
    }
    
    navbartitle.text=[NSString stringWithFormat:@"杭州凡闻科技有限公司"];
    navbartitle.textAlignment=UITextAlignmentLeft;
    navbartitle.textColor= [UIColor whiteColor];
    navbartitle.backgroundColor=[UIColor clearColor];
    navbartitle.font=[UIFont fontWithName:@"ZhunYuan" size:16];
    navbartitle.shadowColor = [UIColor grayColor];
    navbartitle.shadowOffset = CGSizeMake(0,0);
    [midbg_img addSubview:navbartitle];
    [navbartitle release];
#pragma ScrollView
    maingScrollView = [[UIScrollView alloc] init];
    if (IS_IPHONE_5) {
        maingScrollView.frame=CGRectMake(0, 33, 292, 368);
    }
    else
    {
        maingScrollView.frame=CGRectMake(0, 43, 292, 250);
    }
    maingScrollView.backgroundColor = [UIColor clearColor];
    maingScrollView.contentSize = CGSizeMake(292,368);
    [maingScrollView setCanCancelContentTouches:NO];
    maingScrollView.clipsToBounds = YES;
    maingScrollView.scrollEnabled = TRUE;
    maingScrollView.delegate=self;
    maingScrollView.tag=111;
    [midbg_img addSubview:maingScrollView];
    [maingScrollView release];
    
    
#pragma Name Text imageView
   
    UIImageView *addressicon = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){  addressicon.frame=CGRectMake(25,35, 16,19.5);}
    else{   addressicon.frame=CGRectMake(25,35, 16,19.5);}
    
    [addressicon setImage:[UIImage imageNamed:@"address-icon.png"]];
    addressicon.userInteractionEnabled=TRUE;
    addressicon.opaque = YES;
    [maingScrollView addSubview:addressicon];
    [addressicon release];
    
    
#pragma Name Label
    add_lbl=[[UILabel alloc] init];
    add_lbl.frame=CGRectMake(85,25, 220,40);
//    add_lbl.text=[NSString stringWithFormat:@"Block 2,121 Yonghua Street,  Hangzhou,China"];
    add_lbl.textAlignment=0;
    add_lbl.numberOfLines=3;
    add_lbl.textColor= [UIColor whiteColor];
    add_lbl.backgroundColor=[UIColor clearColor];
    add_lbl.font=[UIFont fontWithName:@"ZhunYuan" size:14];
    [maingScrollView addSubview:add_lbl];
    [add_lbl release];

    
    UIImageView *TELICON = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){  TELICON.frame=CGRectMake(25,80, 11.5,15.5);}
    else{TELICON.frame=CGRectMake(25,80, 11.5,15.5);}
    
    [TELICON setImage:[UIImage imageNamed:@"phone-icon.png"]];
    TELICON.userInteractionEnabled=TRUE;
    TELICON.opaque = YES;
    [maingScrollView addSubview:TELICON];
    [TELICON release];
    

    
   txt_view=[[UIWebView alloc]init];
    if (IS_IPHONE_5) {
        txt_view.frame=CGRectMake(75,72, 240,25);
    }
    else
    txt_view.frame=CGRectMake(75,72, 240,25);
    txt_view.backgroundColor=[UIColor clearColor];
    [txt_view setOpaque:NO];
    txt_view.scrollView.scrollEnabled=NO;

    txt_view.dataDetectorTypes=UIDataDetectorTypePhoneNumber;
   
    txt_view.delegate=self;

    [maingScrollView addSubview:txt_view];

    

    
    
#pragma Name Text imageView
    
    UIImageView *faxressicon = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){  faxressicon.frame=CGRectMake(25,120, 21,18);}
    else{faxressicon.frame=CGRectMake(25,120, 21,18);}
    
    [faxressicon setImage:[UIImage imageNamed:@"fax-ixon.png"]];
    faxressicon.userInteractionEnabled=TRUE;
    faxressicon.opaque = YES;
    [maingScrollView addSubview:faxressicon];
    [faxressicon release];
    
    
#pragma Name Label
    
    faxressicon_lbl=[[UIWebView alloc]init];
    if (IS_IPHONE_5) {
        faxressicon_lbl.frame=CGRectMake(75,112, 240,25);
    }
    else
        faxressicon_lbl.frame=CGRectMake(75,112, 240,25);
    faxressicon_lbl.backgroundColor=[UIColor clearColor];
    [faxressicon_lbl setOpaque:NO];
    faxressicon_lbl.scrollView.scrollEnabled=NO;
    [faxressicon_lbl setUserInteractionEnabled:NO];
    //faxressicon_lbl.dataDetectorTypes=UIDataDetectorTypePhoneNumber;
    
    faxressicon_lbl.delegate=self;
    
    [maingScrollView addSubview:faxressicon_lbl];
    //[faxressicon_lbl release];

    
    
    
    
    mail_TELICON = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){  mail_TELICON.frame=CGRectMake(25,160, 21,18);}
    else{ mail_TELICON.frame=CGRectMake(25,160, 21,18);}
   
    [mail_TELICON setImage:[UIImage imageNamed:@"mail-icon.png"]];
    mail_TELICON.userInteractionEnabled=TRUE;
    mail_TELICON.opaque = YES;
    [maingScrollView addSubview:mail_TELICON];
    [mail_TELICON release];
    
    
//    UIWebView *mobile_lbl=[[[UIWebView alloc] initWithFrame:CGRectMake(60,59,200,30)] autorelease];
//    [mobile_lbl loadHTMLString:[NSString stringWithFormat:@"<div id ='foo'  style='font-size:17px; font-family:ArialMT; textAlign:center;vertical-align: middle';>%@<div>",mobileNo] baseURL:nil];
//    [mobile_lbl setBackgroundColor:[UIColor clearColor]];
//    [mobile_lbl setOpaque:NO];
//    
//    [white_bgimg addSubview:mobile_lbl];
   mail_txt_view=[[UIWebView alloc]init];
    if (IS_IPHONE_5) {
        mail_txt_view.frame=CGRectMake(75,153,240,25);
    }
    else
     mail_txt_view.frame=CGRectMake(75,153,240,25);
     mail_txt_view.backgroundColor=[UIColor clearColor];
     [mail_txt_view setOpaque:NO];
     mail_txt_view.scrollView.scrollEnabled=NO;
     [mail_txt_view setDataDetectorTypes:UIDataDetectorTypeAll];
    // [ mail_txt_view loadHTMLString:<#(NSString *)#> baseURL:nil];
    //    mail_txt_view.textColor=[UIColor whiteColor];
    //    mail_txt_view.font=[UIFont fontWithName:@"ZhunYuan" size:15];
    //    mail_txt_view.editable=FALSE;
    //    mail_txt_view.scrollEnabled=FALSE;
    // mail_txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
    // mail_txt_view.text=@"info@cnfanews.com";
    mail_txt_view.delegate=self;
    // mail_txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
    [maingScrollView addSubview:mail_txt_view];
    
   
    UIImageView *web_icon = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){  web_icon.frame=CGRectMake(25,207, 21.5,21.5);}
    else{  web_icon.frame=CGRectMake(25,207, 21.5,21.5);}
    
    [web_icon setImage:[UIImage imageNamed:@"web-icon.png"]];
    web_icon.userInteractionEnabled=TRUE;
    web_icon.opaque = YES;
    [maingScrollView addSubview:web_icon];
    [web_icon release];
    
    
    
     web_icon_txt_view=[[UIWebView alloc]init];
    if (IS_IPHONE_5) {
        web_icon_txt_view.frame=CGRectMake(75,200,240,25);
    }
    else
    web_icon_txt_view.frame=CGRectMake(75,200,240,25);
    web_icon_txt_view.scrollView.scrollEnabled=NO;
    web_icon_txt_view.backgroundColor=[UIColor clearColor];
    [web_icon_txt_view setOpaque:NO];
  
    web_icon_txt_view.dataDetectorTypes=UIDataDetectorTypeLink;
    web_icon_txt_view.delegate=self;
    [maingScrollView addSubview:web_icon_txt_view];
    

    // find us:关注我们
    
    // rate us::评价我们
    
//    UIImageView *findus_icon = [[UIImageView alloc] init];
//    
//    if(IS_IPHONE_5){  findus_icon.frame=CGRectMake(25,260, 36,8);}
//    else{  findus_icon.frame=CGRectMake(25,260, 36,8);}
//    
//    [findus_icon setImage:[UIImage imageNamed:@"find-us.png"]];
//    findus_icon.userInteractionEnabled=TRUE;
//    findus_icon.opaque = YES;
//    [maingScrollView addSubview:findus_icon];
//    [findus_icon release];
    
//    UILabel *findus_icon=[[UILabel alloc] init];
//    if(IS_IPHONE_5){  findus_icon.frame=CGRectMake(15,260, 55,15);}
//        else{  findus_icon.frame=CGRectMake(13,260, 55,15);}
//    findus_icon.text=[NSString stringWithFormat:@"关注我们"];
//    findus_icon.textAlignment=0;
//    findus_icon.numberOfLines=1;
//    findus_icon.textColor= [UIColor whiteColor];
//    findus_icon.backgroundColor=[UIColor clearColor];
//    findus_icon.font=[UIFont fontWithName:@"ZhunYuan" size:13];
//    [maingScrollView addSubview:findus_icon];
//    [findus_icon release];

    
    UIImageView *web_icon1 = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){  web_icon1.frame=CGRectMake(25,260, 21.5,21.5);}
    else{  web_icon1.frame=CGRectMake(25,260, 21.5,21.5);}
    
    [web_icon1 setImage:[UIImage imageNamed:@"search.png"]];
    web_icon1.userInteractionEnabled=TRUE;
    web_icon1.opaque = YES;
    [maingScrollView addSubview:web_icon1];
    [web_icon1 release];
#pragma Weibo chat Button
    UIButton *weibo_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    weibo_btn.frame=CGRectMake(85,250,40,38);
    [weibo_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sina-weibo" ofType:@"png"]] forState:UIControlStateNormal];
    [weibo_btn addTarget:self action:@selector(openlink1) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:weibo_btn];
//    
#pragma Tencet chat Button
    UIButton *tencet_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    tencet_btn.frame=CGRectMake(151,250,40,38);
    [tencet_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tecent-weibo" ofType:@"png"]] forState:UIControlStateNormal];
   [tencet_btn addTarget:self action:@selector(openlink2) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:tencet_btn];
    
 
//    UILabel *rateUs_icon=[[UILabel alloc] init];
//    if(IS_IPHONE_5){  rateUs_icon.frame=CGRectMake(15,320, 55,15);}
//    else{  rateUs_icon.frame=CGRectMake(13,320, 55,15);}
//    rateUs_icon.text=[NSString stringWithFormat:@"评价我们"];
//    rateUs_icon.textAlignment=0;
//    rateUs_icon.numberOfLines=1;
//    rateUs_icon.textColor= [UIColor whiteColor];
//    rateUs_icon.backgroundColor=[UIColor clearColor];
//    rateUs_icon.font=[UIFont fontWithName:@"ZhunYuan" size:13];
//    [maingScrollView addSubview:rateUs_icon];
//    [rateUs_icon release];
    
    
    UIImageView *web_icon2 = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){  web_icon2.frame=CGRectMake(25,315, 21.5,21.5);}
    else{  web_icon2.frame=CGRectMake(25,315, 21.5,21.5);}
    
    [web_icon2 setImage:[UIImage imageNamed:@"star.png"]];
    web_icon2.userInteractionEnabled=TRUE;
    web_icon2.opaque = YES;
    [maingScrollView addSubview:web_icon2];
    [web_icon2 release];
#pragma Tencet chat Button
    
    UIButton *rateUsbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rateUsbtn.frame=CGRectMake(85,307.5,40,38);
    [rateUsbtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rateapp-store" ofType:@"png"]] forState:UIControlStateNormal];
  //  [rateUsbtn addTarget:self action:@selector(openlink2) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:rateUsbtn];
 
    
    
    
    tempindbg=[[UIView alloc]init];
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
    
    
    
    tempindbg .hidden=FALSE;
    [spinner startAnimating];
      
    
    
    // force the tableview to load
    if(remoteHostStatus == NotReachable) {
        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"提醒!"
                                                                 message:@"当前没有可用网络，请检查后再试."
                                                                delegate:nil
                                                       cancelButtonTitle:@"确认"
                                                       otherButtonTitles:nil];

      [networkmessage show];
      [networkmessage release];
      [self FetchRecord_ContactUS_DB];
        
    }
    else{
        
        CNFAGetNewContactUSservices * serviceDel=[[CNFAGetNewContactUSservices alloc]init];
        serviceDel.delegate=self;
        [serviceDel callWebService:@"contact_detail"];
        

    }
    
   
	// Do any additional setup after loading the view.
}




-(void)Delete_ContactUS_Content_Table_DB{
    NSString *insertSQL;
    insertSQL = [NSString stringWithFormat: @"DELETE FROM ContactUS_New "];
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
    sqlite3_step(InsertStatement);
    sqlite3_finalize(InsertStatement);
    [self InsertRecord_ToAboutUS_Contente_DB];
}

//CREATE TABLE "ContactUS_New" ("ID" VARCHAR, "Address" VARCHAR, "Phone_No" VARCHAR, "Fax_No" VARCHAR, "Email_Id" VARCHAR, "Web_Link" VARCHAR, "Eweibo_Link" VARCHAR, "Erenren_Link" VARCHAR)

-(void)InsertRecord_ToAboutUS_Contente_DB{
    NSString *insertSQL;
    for(int i=0; i<[IDarr count];i++){
        insertSQL = [NSString stringWithFormat: @"INSERT INTO ContactUS_New (ID,Address,Phone_No,Fax_No,Email_Id,Web_Link,Eweibo_Link,Erenren_Link) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[IDarr objectAtIndex:i],[Addressarr objectAtIndex:i],[phonenoarr objectAtIndex:i],[faxnoarr objectAtIndex:i],[emailarr objectAtIndex:i],[websitearr objectAtIndex:i],[Eweiboarr objectAtIndex:i],[renronarr objectAtIndex:i]];
        
        NSLog(@"insertSQL-- %@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &InsertStatement, NULL);
        sqlite3_step(InsertStatement);
    }
    sqlite3_finalize(InsertStatement);
    
    [self FetchRecord_ContactUS_DB];
}


-(void)FetchRecord_ContactUS_DB{
    sqlite3_stmt * countstatement;
     
    NSString *sqlString1 = [NSString stringWithFormat:@"SELECT * from ContactUS_New"];
    NSLog(@"sqlString1-- %@",sqlString1);
    const char *sql = [sqlString1 UTF8String];
    if(sqlite3_prepare_v2(database, sql, -1, &countstatement, NULL) == SQLITE_OK) {
        while(sqlite3_step(countstatement) == SQLITE_ROW){
            
             IDstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,0)];
             Addressstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,1)];
             phonenostr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,2)];
              faxnostr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,3)];
             emailstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,4)];
              websitestr= [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,5)];
             Eweibostr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,6)];
             renronstr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(countstatement,7)];
            [Eweibostr retain];
            [renronstr retain];
            
          }
        sqlite3_finalize(countstatement);
    }
    
    
    [self Display_record_Method];

}





-(void)getcontentLists:(NSMutableArray *)ContactID  getAddress:(NSMutableArray *)AddressText getPhoneNo:(NSMutableArray *)PhoneNo getFaxNo:(NSMutableArray *)FaxNo  getEmailID:(NSMutableArray *)EmailID getwebsiteName:(NSMutableArray *)webName getEweiboLink:(NSMutableArray *)EweiboLink  getRenrenLink:(NSMutableArray *)RenrenLink  status:(BOOL)value
{


     IDarr=[ContactID mutableCopy];
     Addressarr=[AddressText mutableCopy];
     phonenoarr=[PhoneNo mutableCopy];
     faxnoarr=[FaxNo mutableCopy];
     emailarr=[EmailID mutableCopy];
     websitearr=[webName mutableCopy];
     Eweiboarr=[EweiboLink mutableCopy];
     renronarr=[RenrenLink mutableCopy];

    

    if([IDarr count] >0){
     [self Delete_ContactUS_Content_Table_DB];
    }
    
    
    
  }




-(void)Display_record_Method{

    add_lbl.text=Addressstr;
    //txt_view.text=phonenostr;
    
     [txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:2; } p { color:black; font-family:ZhunYuan; font-size:15px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",phonenostr] baseURL:nil];
    
   // faxressicon_lbl.text=faxnostr;
    
    [faxressicon_lbl loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:2; } p { color:black; font-family:ZhunYuan; font-size:15px; } a { color:white; text-decoration:none; }</style></head><body><p>%@</p></body></html>",faxnostr] baseURL:nil];
    
   // mail_txt_view.text=emailstr;
   [mail_txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:2; } p { color:black; font-family:ZhunYuan; font-size:15px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",emailstr] baseURL:nil];
    
    //<div id ='foo'  style='font-size:17px; font-family:ArialMT; color:black;textAlign:center;vertical-align: middle';>%@<div>
 
//    web_icon_txt_view.text=[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:2; } p { color:black; font-family:ArialMT; font-size:17px; } a { color:#3366BB; text-decoration:none; }</style></head><body><p>%@</p></body></html>",websitestr];
    
    [ web_icon_txt_view loadHTMLString:[NSString stringWithFormat:@"<html><head><script> document.ontouchmove = function(event) { if (document.body.scrollHeight == document.body.clientHeight) event.preventDefault(); } </script><style type='text/css'>* { margin:0; padding:2; } p { color:black; font-family:ZhunYuan; font-size:15px; } a { color:#44C0B5; text-decoration:none; }</style></head><body><p>%@</p></body></html>",websitestr] baseURL:nil];

    
    tempindbg .hidden=TRUE;
    [spinner stopAnimating];
    
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType
{
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        NSLog(@"TELEPHONE URL %@",inRequest.URL);
       
        if ([[inRequest.URL scheme] isEqual:@"mailto"]) {
            NSLog(@"mail to");
           // [[UIApplication sharedApplication] openURL:inRequest.URL];
            
            
            
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
        //ph=[ph stringByReplacingOccurrencesOfString:@"tel" withString:@"致电"];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.ph1]]];
        }
        else
        {
             [[UIApplication sharedApplication] openURL:inRequest.URL];
        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒:"
//                                                            message:[NSString stringWithFormat:@"%@",ph]
//                                                           delegate:self
//                                                  cancelButtonTitle:@"确认"
//                                                  otherButtonTitles:@"取消",Nil];
//             [alert setTag:1111];
//            [alert show];
//            [alert release];
    
            //[[UIApplication sharedApplication] openURL:inRequest.URL];
        
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
         NSLog(@"PH1 %@",self.ph1);
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
           
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.ph1]]];
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




-(void)openlink2{
    //http://t.qq.com/fs2043525960
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://t.qq.com/fs2043525960"]];
}

-(void)openlink1{
    NSLog(@"SINA WEIBO REDIRECT URL: %@",Eweibostr);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/u/3748852832"]];
}


#pragma TextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    UIScrollView *scrollview=(UIScrollView *)[self.view viewWithTag:111];
    scrollview.scrollEnabled=YES;
    if (textField.tag==100) {
        [scrollview setContentOffset:CGPointMake(0, 10)animated:YES];}
    else if (textField.tag==200){
        [scrollview setContentOffset:CGPointMake(0, 30) animated:YES];}
    else if (textField.tag==300){
        [scrollview setContentOffset:CGPointMake(0, 80) animated:YES];}
    
    else if (textField.tag==400){
        [scrollview setContentOffset:CGPointMake(0, 150) animated:YES];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self resignKeyboard];
    return YES;
    
}

-(void)resignKeyboard{
    
    [userName_Txt resignFirstResponder];
    [email_Txt resignFirstResponder];
    [phone_Txt resignFirstResponder];
    [city_Txt resignFirstResponder];
    [text_view resignFirstResponder];
    
    
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


-(void)getmsgLists:(NSMutableArray *)successmsg  status:(BOOL)value{
    
    NSLog(@"SuccessMSG: %@",successmsg);
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you! " message:@"Your message has been successfully sent." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    tempindbg.hidden=TRUE;
    [spinner stopAnimating];
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
