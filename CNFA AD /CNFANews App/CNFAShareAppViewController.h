//
//  CNFAShareAppViewController.h
//  CNFANews App
//
//  Created by Dex on 27/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
//#import "TCWBEngine.h"
#import <MessageUI/MessageUI.h>

@interface CNFAShareAppViewController : UIViewController<UIAlertViewDelegate,WXApiDelegate,MFMailComposeViewControllerDelegate>{
    NSString* m_nsLastText;
    UIAlertView *alert;
     enum WXScene _scene;
}
//-(void)weibo_btnAction:(id)sender;
//- (void) sendTextContent:(NSString*)nsText;
@property (nonatomic, retain) NSString* eMailSubjectstr;
@property (nonatomic, retain) NSString* eMaildetailmsgstr;
@property (nonatomic, retain) NSString* eMailaddCitystr;
@property (nonatomic, retain) NSString* eMailaddNewsstr;
@property (nonatomic, retain) NSString* eMailaddTimestr;

//@property (nonatomic, retain) TCWBEngine   *weiboEngine;


//- (void)showAlertMessage:(NSString *)msg;
//- (void)onLogInOAuthButtonPressed;

@end
