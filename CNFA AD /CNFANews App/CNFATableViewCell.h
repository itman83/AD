//
//  CNFATableViewCell.h
//  CNFANews App
//
//  Created by iMac Apple on 06/11/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNFATableViewCell : UITableViewCell<UIGestureRecognizerDelegate>
{
    UIButton* _crossLabel;
    int dragged;
    int tagg;
    NSIndexPath *indPath;
   
}

@end
