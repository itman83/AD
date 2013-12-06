//
//  WBMsgViewController.h
//  Dragon
//
//  Created by 崔 伸 on 13-11-12.
//  Copyright (c) 2013年 Dex Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBMsgViewController;
@protocol WBMsgViewControllerDelegate <NSObject>
//By Ye
-(void)WBMsgViewControllerFinishWith:(WBMsgViewController*)wbView Result:(BOOL)send;

@end
@interface WBMsgViewController : UIViewController
{
    
    IBOutlet UIBarButtonItem *cancelBtn;
    IBOutlet UIBarButtonItem *sendBtn;
    
}
@property (retain, nonatomic) IBOutlet UITextView *txtMsg;
@property(nonatomic,assign)id<WBMsgViewControllerDelegate>delegate;
- (IBAction)btnSend:(id)sender;

- (IBAction)btnCancel:(id)sender;

@end
