//
//  CNFAFavoritesViewController.h
//  CNFANews App
//
//  Created by Dex on 06/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <sqlite3.h>
#import "CNFASubCategoryDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CNFACategoryNewsViewController.h"
#import "Reachability.h"

@interface CNFAFavoritesViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    UITextField * searchbar_Txt;
    Reachability * reachability ;
    NetworkStatus remoteHostStatus;
    BOOL ISSearchEnable;
    UIButton * back_btn;
    
    sqlite3_stmt *InsertStatement;;
    sqlite3 * database;
     UIImageView *mainbg_img;
     UIImageView *navbarimage;
     UITableView *tableview;
  
    UILabel* celltxt_lbl;
    UILabel* celltxt_lbl3;
    NSMutableArray *AddIDarr;
      NSMutableArray *AddTitlearr;
      NSMutableArray *AddDetailTextarr;
      NSMutableArray *AddCreatedTimearr;
      NSMutableArray *AddNewsNamearr;
      NSMutableArray *AddCityNamearr;
      NSMutableArray *UpdateTimearr;
    CGPoint _originalCenter;
    UIButton *navrightbtn;
   UILabel* noresult_lbl;
}
@property(nonatomic,retain)UIButton *b1;
@end
