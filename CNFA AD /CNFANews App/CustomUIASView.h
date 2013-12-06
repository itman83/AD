//
//  CustomUIASView.h
//  CustomUIASView
//
//  Created by Cory D. Wiles on 1/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomUIASView : UIView {
  UIButton *weChatButton;
  UIButton *emailButton;
  UIButton *sinaweiboButton;
  UIButton *tencentButton;
  UIButton *smsButton;
  UIButton *cancleBtn;
    
}

@property (nonatomic, retain) UIButton *weChatButton;
@property (nonatomic, retain) UIButton *emailButton;
@property (nonatomic, retain) UIButton *sinaweiboButton;
@property (nonatomic, retain) UIButton *tencentButton;
@property (nonatomic, retain) UIButton *smsButton;
@property (nonatomic, retain) UIButton *cancleBtn;

@end
