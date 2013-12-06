//
//  CNFAContactUsViewController.h
//  CNFANews App
//
//  Created by Dex on 22/06/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "CNFAGetContactUS.h"
#import "CNFAContactUSNewViewController.h"
@interface CNFAContactUsViewController : UIViewController<GetContactUsDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSArray *lbl_list;

    Reachability * reachability ;
    NetworkStatus remoteHostStatus;

    UITextField * userName_Txt;
    UITextField * email_Txt;
    UITextField *phone_Txt;
    UITextField *city_Txt;
    UITextView *text_view;
    UIScrollView *maingScrollView;
    
    UIView * tempindbg;
    UIActivityIndicatorView *spinner;
    
    UILabel *msg_lbl;
}

@end
