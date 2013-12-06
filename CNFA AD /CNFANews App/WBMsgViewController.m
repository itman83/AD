//
//  WBMsgViewController.m
//  Dragon
//
//  Created by 崔 伸 on 13-11-12.
//  Copyright (c) 2013年 Dex Consulting. All rights reserved.
//

#import "WBMsgViewController.h"

@interface WBMsgViewController ()

@end

@implementation WBMsgViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        CGRect r = [ UIScreen mainScreen ].applicationFrame;
//        self.view.frame=r;
        
       
        cancelBtn.title=@"取消";
        sendBtn.title=@"确认";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //64
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
    {
        cancelBtn.title=@"取消";
        sendBtn.title=@"确认";
        self.txtMsg.frame=CGRectMake(0, 64, self.txtMsg.frame.size.width, self.txtMsg.frame.size.height);
    }
   // [self.txtMsg becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [cancelBtn release];
    [sendBtn release];
    [cancelBtn release];
    [_txtMsg release];
    [super dealloc];
}
- (void)viewDidUnload {
    [cancelBtn release];
    cancelBtn = nil;
    [sendBtn release];
    sendBtn = nil;
    [cancelBtn release];
    cancelBtn = nil;
    [self setTxtMsg:nil];
    [super viewDidUnload];
}
//By Ye
- (IBAction)btnSend:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate WBMsgViewControllerFinishWith:self Result:YES];
    }];
}
//By Ye
- (IBAction)btnCancel:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate WBMsgViewControllerFinishWith:self Result:NO];
    }];
}
@end
