//
//  CNFAShareAppViewController.m
//  CNFANews App
//
//  Created by Dex on 27/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAShareAppViewController.h"
#import "CNFAGlobalDataClass.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@interface CNFAShareAppViewController ()

@end

@implementation CNFAShareAppViewController
//@synthesize delegate = _delegate;
@synthesize eMailaddCitystr,eMailaddNewsstr,eMailaddTimestr,eMaildetailmsgstr,eMailSubjectstr;

- (id)init{
    if(self = [super init]){
        _scene = WXSceneSession;
    }
    return self;
}


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
//       // [ self onLogInOAuthButtonPressed ];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#pragma Main BackGround ImageView
    UIImageView *mainbg_img = [[UIImageView alloc] init];
    if(IS_IPHONE_5){ mainbg_img.frame=CGRectMake(0,0, 320,500);}
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
//    UILabel *navbartitle=[[UILabel alloc] init];
//    navbartitle.frame=CGRectMake(0,2.5,320,34);
//    //navbartitle.text=[NSString stringWithFormat:@"Share"];
//    navbartitle.text=[NSString stringWithFormat:@"分享"];
//    navbartitle.textAlignment=1;
//    navbartitle.textColor= [UIColor whiteColor];
//    navbartitle.backgroundColor=[UIColor clearColor];
//    navbartitle.font=[UIFont fontWithName:@"Microsoft YaHei" size:18];
//    navbartitle.shadowColor = [UIColor grayColor];
//    navbartitle.shadowOffset = CGSizeMake(0,0);
//    [navbarimage addSubview:navbartitle];
//    [navbartitle release];
    
#pragma NaviGation Left(back button) bar Button
    UIButton *back_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame=CGRectMake(5,5.5,49.5,29);
    [back_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-button" ofType:@"png"]] forState:UIControlStateNormal];
    back_btn.titleLabel.font=[UIFont systemFontOfSize:13.0f];
    [back_btn setTitle:@"  返回" forState:UIControlStateNormal];
    [back_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back_btn addTarget:self action:@selector(back_btnAction) forControlEvents:UIControlEventTouchUpInside];
    [navbarimage addSubview:back_btn];
    
    
#pragma Buttom Bar ImageView
    UIImageView *midbg_img = [[UIImageView alloc] init];
    midbg_img.frame=CGRectMake(14,52,292,348);
    [midbg_img setImage:[UIImage imageNamed:@"contact-bg.png"]];
    midbg_img.userInteractionEnabled=TRUE;
    midbg_img.opaque = YES;
    [mainbg_img addSubview:midbg_img];
    [midbg_img release];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btn setTitle:@"Send text message333" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setFrame:CGRectMake(20, 50, 145, 40)];
//  //  [btn addTarget:self action:@selector(sendTextContent) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
   m_nsLastText = @"Implement seam-less communication between QQ clients on Mac, PC, mobile and Pad. ";
    
    #pragma V- chat Button
        UIButton *vchat_btn =[UIButton buttonWithType:UIButtonTypeCustom];
       vchat_btn.frame=CGRectMake(24.75,70,67.5,64.5);
       [vchat_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"we-chat" ofType:@"png"]] forState:UIControlStateNormal];
     [vchat_btn addTarget:self action:@selector(sendTextContent_WeChat) forControlEvents:UIControlEventTouchUpInside];
      [midbg_img addSubview:vchat_btn];
        
   

#pragma Weibo chat Button
    UIButton *weibo_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    weibo_btn.frame=CGRectMake(109.25,70,67.5,64.5);
    [weibo_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sina-weibo" ofType:@"png"]] forState:UIControlStateNormal];
   [weibo_btn addTarget:self action:@selector(SinaWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [midbg_img addSubview:weibo_btn];
        
#pragma Tencet chat Button
    UIButton *tencet_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    tencet_btn.frame=CGRectMake(193.75,70,67.5,64.5);
    [tencet_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tecent-weibo" ofType:@"png"]] forState:UIControlStateNormal];
    [tencet_btn addTarget:self action:@selector(TencentWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [midbg_img addSubview:tencet_btn];
      
#pragma SMS Button
    UIButton *sms_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    sms_btn.frame=CGRectMake(24.75+30,157.5,67.5,64.5);
    [sms_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sms" ofType:@"png"]] forState:UIControlStateNormal];
    [sms_btn addTarget:self action:@selector(message_btn:) forControlEvents:UIControlEventTouchUpInside];
    [midbg_img addSubview:sms_btn];
    
    
#pragma EMAIL Button
    UIButton *email_btn =[UIButton buttonWithType:UIButtonTypeCustom];
    email_btn.frame=CGRectMake(109.25+50,157.5,67.5,64.5);
    [email_btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]] forState:UIControlStateNormal];
    [email_btn addTarget:self action:@selector(openMail:) forControlEvents:UIControlEventTouchUpInside];
    [midbg_img addSubview:email_btn];
    
	// Do any additional setup after loading the view.
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



//-(void)TencentWeibo:(id)sender{
//    
//    
//    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:REDIRECTURI];
//    [engine setRootViewController:self];
//    
//    self.weiboEngine = engine;
//    
//    [self.weiboEngine logInWithDelegate:self
//                         onSuccess:@selector(onSuccessLogin)
//                         onFailure:@selector(onFailureLogin:)];
//    
//
//
//}
//
//- (void)onSuccessLogin
//{
//    
//}
//
////Login failed callback
//- (void)onFailureLogin:(NSError *)error
//{
//    
//    NSString *message1 = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
//                                                        message:message1
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//    [alertView show];
//    [alertView release];
//    [message1 release];
//}
//
//
//-(void)SinaWeibo:(id)sender{
//    //working with english content
//      
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
//    {
//        SLComposeViewController *swSheet = [SLComposeViewController
//                                            composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//        
//  
//        [swSheet setInitialText:[NSString stringWithFormat:@"%@\n%@\n%@ | %@ | %@",eMailSubjectstr,eMaildetailmsgstr,eMailaddNewsstr,eMailaddCitystr,eMailaddTimestr ]];
//        [self presentViewController:swSheet animated:YES completion:nil];
//    }
//    else
//    {
//        //Error alert  
//    }  //    ACAccountStore *accountStore1 = [[ACAccountStore alloc] init];
//    
//}
//
//
//
//
//
//
//
//
//
//#pragma We Chat
//- (void)sendTextContent_WeChat{
//    NSString* nsText;
//    nsText =[NSString stringWithFormat:@"%@\n\n%@\n\n%@ | %@ | %@",eMailSubjectstr,eMaildetailmsgstr,eMailaddNewsstr,eMailaddCitystr,eMailaddTimestr ];
//    
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
//    req.bText = YES;
//    req.text = nsText;
//    req.scene = _scene;
//    
//    [WXApi sendReq:req];
//}
//
//
//
//
//#pragma Message Button Action
//-(IBAction)message_btn:(id)sender{
//        MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
//        if([MFMessageComposeViewController canSendText]){
//            controller.body = [NSString stringWithFormat:@"%@ \n%@ | %@ | %@", eMaildetailmsgstr,eMailaddNewsstr,eMailaddCitystr,eMailaddTimestr];
//            controller.messageComposeDelegate = self;
//            [self presentModalViewController:controller animated:YES];
//        }
//}
//
//
//#pragma Message Composer Delegate Metthod
//- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
//{
//	switch (result) {
//		case MessageComposeResultCancelled:
//			NSLog(@"Cancelled");
//			break;
//		case MessageComposeResultFailed:
//            alert=[[UIAlertView alloc]initWithTitle:@"Myapp" message:@"message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//            [alert release];
//		case MessageComposeResultSent:
//            
//			break;
//		default:
//			break;
//	}
//    
//	[self dismissModalViewControllerAnimated:YES];
//}
//
//
//
//#pragma mark - Open the mail interface
//- (IBAction)openMail:(id)sender
//{
//    if ([MFMailComposeViewController canSendMail]){
//        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
//        mailer.mailComposeDelegate = self;
//        [mailer setSubject:[NSString stringWithFormat:@"%@ (CNFA Add)",eMailSubjectstr]];
//     //   NSArray *toRecipients = [NSArray arrayWithObjects:@"reddanna.k@search-value.com", nil];
//     //   [mailer setToRecipients:toRecipients];
////        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
////        NSData *imageData = UIImagePNGRepresentation(myImage);
////        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
//
//        NSString *emailBody =[NSString stringWithFormat:@"%@ \n\n%@ | %@ | %@", eMaildetailmsgstr,eMailaddNewsstr,eMailaddCitystr,eMailaddTimestr];
//        [mailer setMessageBody:emailBody isHTML:NO];
//    
//        // only for iPad
//        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
//        
//        [self presentModalViewController:mailer animated:YES];
//        [mailer release];
//    }
//    else{
//        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Failure"
//                                                        message:@"Your device doesn't support the composer sheet"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles: nil];
//        [alert1 show];
//        [alert1 release];
//    }
//    
//}
//
//#pragma mark - MFMailComposeController delegate
//- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
//{
//	switch (result)
//	{
//		case MFMailComposeResultCancelled:
//			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
//			break;
//		case MFMailComposeResultSaved:
//			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
//			break;
//		case MFMailComposeResultSent:
//			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
//			break;
//		case MFMailComposeResultFailed:
//			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
//			break;
//		default:
//			NSLog(@"Mail not sent");
//			break;
//	}
//[self dismissModalViewControllerAnimated:YES];
//}
//
//
//
//-(void)share_btnAction{
//}
//
//-(void)back_btnAction{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
//}
//
//
////Authorization success callback
//- (void)onSuccessAuthorizeLogin
//{
//   // [indicatorView stopAnimating];
//    //[self onLogInOAuthButtonPressed];
//}
//
//- (void)postStart {
//    NSLog(@"%s", __FUNCTION__);
//    //    [self showAlertMessage:@"开始发送"];
//}
//
//- (void)createSuccess:(NSDictionary *)dict {
//    NSLog(@"%s %@", __FUNCTION__,dict);
//   
//    if (dict !=NULL) {
//        if ([[dict objectForKey:@"ret"] intValue] == 0) {
//            [self showAlertMessage:@"Message sent"];
//        }else {
//            [self showAlertMessage:@"Message not sent"];
//        }
//    }
//    
//}
//
//- (void)createFail:(NSError *)error {
//    NSLog(@"error is %@",error);
//    
//    [self showAlertMessage:@"Message not sent"];
//}
//
//- (void)showAlertMessage:(NSString *)msg {
//    
//    
//    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
//                                                       message:msg
//                                                      delegate:self
//                                             cancelButtonTitle:@"ok"
//                                             otherButtonTitles:nil];
//    [alertView show];
//    [alertView release];
//    
//}
//
//
//-(void)onLoginFailed:(WBErrCode)errCode msg:(NSString*)msg;
//{
//    
//    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Login failed" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    [av show];
//}
//
//-(void)onLoginSuccessed:(NSString*)name token:(WBToken*)token;
//{
//    NSString* msg = [NSString stringWithFormat:@"name=%@\n openid=%@\n token=%@\n expire=%u\n refreshToken=%@ \n omasToken=%@ omasKey = %@\n",name,token.openid,token.accessToken,token.expires,token.refreshToken, token.omasKey, token.omasToken];
//    
//    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Login successful" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    [av show];
//}
//- (void)onLogin {
//    
//}
//- (void)onLogInOAuthButtonPressed
//{
//    UIImage * image  = [UIImage imageNamed:@"icon.png"];
//    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
//    //    UIImage *image = [UIImage imageNamed:path];
//    // 分享(自带 m登录功能)
//    NSString* nsText;
//    nsText =[NSString stringWithFormat:@"%@\n\n%@\n\n%@ | %@ | %@",eMailSubjectstr,eMaildetailmsgstr,eMailaddNewsstr,eMailaddCitystr,eMailaddTimestr ];
//    
//    [self.weiboEngine UIBroadCastMsgWithContent:nsText
//                                       andImage:image
//                                    parReserved:nil
//                                       delegate:self
//                                    onPostStart:@selector(postStart)
//                                  onPostSuccess:@selector(createSuccess:)
//                                  onPostFailure:@selector(createFail:)];

//}


@end