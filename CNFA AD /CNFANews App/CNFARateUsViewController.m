//
//  CNFARateUsViewController.m
//  CNFANews App
//
//  Created by iMac Apple on 27/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFARateUsViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface CNFARateUsViewController ()

@end

@implementation CNFARateUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.title = NSLocalizedString(@"Second", @"Second");
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
    navbarimage.frame=CGRectMake(0,0, 320,41.5);
    [navbarimage setImage:[UIImage imageNamed:@"navbar.png"]];
    navbarimage.userInteractionEnabled=TRUE;
    navbarimage.opaque = YES;
    [mainbg_img addSubview:navbarimage];
    [navbarimage release];
    
    
#pragma Navigation Bar Title
    UILabel *navbartitle=[[UILabel alloc] init];
    navbartitle.frame=CGRectMake(0,2.5,320,34);
    //    navbartitle.text=[NSString stringWithFormat:@"Contact US"];
    navbartitle.text=[NSString stringWithFormat:@"评价我们"];
    navbartitle.textAlignment=1;
    navbartitle.textColor= [UIColor whiteColor];
    navbartitle.backgroundColor=[UIColor clearColor];
    navbartitle.font=[UIFont fontWithName:@"Microsoft YaHei" size:18];
    navbartitle.shadowColor = [UIColor grayColor];
    navbartitle.shadowOffset = CGSizeMake(0,0);
    [navbarimage addSubview:navbartitle];
    [navbartitle release];
    
//#pragma NaviGation Left(back button) bar Button
//    UIButton *back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
//    back_btn.frame=CGRectMake(5,5.5,49.5,29);
//    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
//    [back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
//    [navbarimage addSubview:back_btn];
//    
    
#pragma Buttom Bar ImageView
    UIImageView *midbg_img = [[UIImageView alloc] init];
    
    if(IS_IPHONE_5){  midbg_img.frame=CGRectMake(14,70,292,388);}
    else{ midbg_img.frame=CGRectMake(14,70,292,300);}
    
    [midbg_img setImage:[UIImage imageNamed:@"contact-bg.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];
    
    
#pragma ScrollView
    maingScrollView = [[UIScrollView alloc] init];
    maingScrollView.frame=CGRectMake(0, 0, 292, 348);
    maingScrollView.backgroundColor = [UIColor clearColor];
    maingScrollView.contentSize = CGSizeMake(292,400);
    [maingScrollView setCanCancelContentTouches:NO];
    maingScrollView.clipsToBounds = YES;
    maingScrollView.scrollEnabled = FALSE;
    maingScrollView.tag=111;
    [midbg_img addSubview:maingScrollView];
    [maingScrollView release];
    
    
//#pragma Name Text imageView
//    
//    UIImageView *addressicon = [[UIImageView alloc] init];
//    
//    if(IS_IPHONE_5){  addressicon.frame=CGRectMake(25,35, 12,19.5);}
//    else{   addressicon.frame=CGRectMake(25,34, 12,19.5);}
//    
//    [addressicon setImage:[UIImage imageNamed:@"address-icon.png"]];
//    addressicon.userInteractionEnabled=TRUE;
//    addressicon.opaque = YES;
//    [maingScrollView addSubview:addressicon];
//    [addressicon release];
//    
//    
//#pragma Name Label
//    add_lbl=[[UILabel alloc] init];
//    add_lbl.frame=CGRectMake(70,30, 220,40);
//    //    add_lbl.text=[NSString stringWithFormat:@"Block 2,121 Yonghua Street,  Hangzhou,China"];
//    add_lbl.textAlignment=0;
//    add_lbl.numberOfLines=3;
//    add_lbl.textColor= [UIColor whiteColor];
//    add_lbl.backgroundColor=[UIColor clearColor];
//    add_lbl.font=[UIFont fontWithName:@"Microsoft YaHei" size:13];
//    [maingScrollView addSubview:add_lbl];
//    [add_lbl release];
//    
//    
//    UIImageView *TELICON = [[UIImageView alloc] init];
//    
//    if(IS_IPHONE_5){  TELICON.frame=CGRectMake(25,80, 11.5,15.5);}
//    else{TELICON.frame=CGRectMake(25,80, 11.5,15.5);}
//    
//    [TELICON setImage:[UIImage imageNamed:@"phone-icon.png"]];
//    TELICON.userInteractionEnabled=TRUE;
//    TELICON.opaque = YES;
//    [maingScrollView addSubview:TELICON];
//    [TELICON release];
//    
//    
//    
//    txt_view=[[UITextView alloc]init];
//    if (IS_IPHONE_5) {
//        txt_view.frame=CGRectMake(60,72, 240,25);
//    }
//    else
//        txt_view.frame=CGRectMake(60,72, 240,25);
//    txt_view.backgroundColor=[UIColor clearColor];
//    txt_view.textColor=[UIColor whiteColor];
//    txt_view.font=[UIFont fontWithName:@"Microsoft YaHei" size:13];
//    txt_view.editable=FALSE;
//    txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
//    //txt_view.text=@"(86) 571 85331960";
//    txt_view.delegate=self;
//    txt_view.scrollEnabled=FALSE;
//    txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
//    [maingScrollView addSubview:txt_view];
//    
//    
//    
//    
//    
//#pragma Name Text imageView
//    
//    UIImageView *faxressicon = [[UIImageView alloc] init];
//    
//    if(IS_IPHONE_5){  faxressicon.frame=CGRectMake(25,120, 21,18);}
//    else{faxressicon.frame=CGRectMake(25,120, 21,18);}
//    
//    [faxressicon setImage:[UIImage imageNamed:@"fax-ixon.png"]];
//    faxressicon.userInteractionEnabled=TRUE;
//    faxressicon.opaque = YES;
//    [maingScrollView addSubview:faxressicon];
//    [faxressicon release];
//    
//    
//#pragma Name Label
//    faxressicon_lbl=[[UILabel alloc] init];
//    faxressicon_lbl.frame=CGRectMake(64,120, 240,18);
//    // faxressicon_lbl.text=[NSString stringWithFormat:@"(86) 571 85331960"];
//    faxressicon_lbl.textAlignment=0;
//    faxressicon_lbl.numberOfLines=1;
//    faxressicon_lbl.textColor= [UIColor whiteColor];
//    faxressicon_lbl.backgroundColor=[UIColor clearColor];
//    faxressicon_lbl.font=[UIFont fontWithName:@"Microsoft YaHei" size:13];
//    faxressicon_lbl.shadowColor = [UIColor grayColor];
//    faxressicon_lbl.shadowOffset = CGSizeMake(0,0);
//    [maingScrollView addSubview:faxressicon_lbl];
//    [faxressicon_lbl release];
//    
//    
//    
//    
//    
//    
//    mail_TELICON = [[UIImageView alloc] init];
//    
//    if(IS_IPHONE_5){  mail_TELICON.frame=CGRectMake(25,160, 21,18);}
//    else{ mail_TELICON.frame=CGRectMake(25,160, 21,18);}
//    
//    [mail_TELICON setImage:[UIImage imageNamed:@"mail-icon.png"]];
//    mail_TELICON.userInteractionEnabled=TRUE;
//    mail_TELICON.opaque = YES;
//    [maingScrollView addSubview:mail_TELICON];
//    [mail_TELICON release];
//    
//    
//    
//    mail_txt_view=[[UITextView alloc]init];
//    if (IS_IPHONE_5) {
//        mail_txt_view.frame=CGRectMake(60,155,240,25);
//    }
//    else
//        mail_txt_view.frame=CGRectMake(60,155,240,25);
//    mail_txt_view.backgroundColor=[UIColor clearColor];
//    mail_txt_view.textColor=[UIColor whiteColor];
//    mail_txt_view.font=[UIFont fontWithName:@"Microsoft YaHei" size:13];
//    mail_txt_view.editable=FALSE;
//    mail_txt_view.scrollEnabled=FALSE;
//    mail_txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
//    // mail_txt_view.text=@"info@cnfanews.com";
//    mail_txt_view.delegate=self;
//    mail_txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
//    [maingScrollView addSubview:mail_txt_view];
    
//    
//    UIImageView *web_icon = [[UIImageView alloc] init];
//    
//    if(IS_IPHONE_5){  web_icon.frame=CGRectMake(25,210, 21.5,21.5);}
//    else{  web_icon.frame=CGRectMake(25,210, 21.5,21.5);}
//    
//    [web_icon setImage:[UIImage imageNamed:@"web-icon.png"]];
//    web_icon.userInteractionEnabled=TRUE;
//    web_icon.opaque = YES;
//    [maingScrollView addSubview:web_icon];
//    [web_icon release];
//    
//    
//    
//    web_icon_txt_view=[[UITextView alloc]init];
//    if (IS_IPHONE_5) {
//        web_icon_txt_view.frame=CGRectMake(60,205,240,25);
//    }
//    else
//        web_icon_txt_view.frame=CGRectMake(60,205,240,25);
//    web_icon_txt_view.backgroundColor=[UIColor clearColor];
//    web_icon_txt_view.textColor=[UIColor whiteColor];
//    web_icon_txt_view.font=[UIFont fontWithName:@"Microsoft YaHei" size:13];
//    web_icon_txt_view.editable=FALSE;
//    web_icon_txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
//    // web_icon_txt_view.text=@"www.cnfanads.com";
//    web_icon_txt_view.delegate=self;
//    web_icon_txt_view.scrollEnabled=FALSE;
//    web_icon_txt_view.dataDetectorTypes=UIDataDetectorTypeAll;
//    [maingScrollView addSubview:web_icon_txt_view];
//    
//    
//    
//    
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
    
    
#pragma Weibo chat Button
    UIButton *weibo_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    weibo_btn.frame=CGRectMake(50,75,67.5,64.5);
    [weibo_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sina-weibo" ofType:@"png"]] forState:UIControlStateNormal];
    [weibo_btn addTarget:self action:@selector(openlink1) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:weibo_btn];
    //
#pragma Tencet chat Button
    UIButton *tencet_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    tencet_btn.frame=CGRectMake(170,75,67.5,64.5);
    [tencet_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tecent-weibo" ofType:@"png"]] forState:UIControlStateNormal];
    [tencet_btn addTarget:self action:@selector(openlink2) forControlEvents:UIControlEventTouchUpInside];
    [maingScrollView addSubview:tencet_btn];
    
    
#pragma Tencet chat Button
    UIButton *rateUsbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rateUsbtn.frame=CGRectMake(70,180,150,40);
    [rateUsbtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"appstore" ofType:@"png"]] forState:UIControlStateNormal];
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
        UIAlertView *networkmessage = [[UIAlertView alloc] initWithTitle:@"Alert: Network Error"
                                                                 message:@"Make sure the signal strength for Wi-Fi or data network is good and that the Device is connected to the network. "
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
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
    txt_view.text=phonenostr;
    faxressicon_lbl.text=faxnostr;
    mail_txt_view.text=emailstr;
    web_icon_txt_view.text=websitestr;
    tempindbg .hidden=TRUE;
    [spinner stopAnimating];
    
}






-(void)openlink2{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:renronstr]];
}

-(void)openlink1{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Eweibostr]];
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
