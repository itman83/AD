//
//  CNFAGetNewsTitle.h
//  CNFANews App
//
//  Created by iMac Apple on 02/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>
 @protocol GetNewsListDelegate;
 @interface CNFAGetNewsTitle : NSObject<NSXMLParserDelegate>{
        NSMutableData * webData;
        NSString * currentData;
        NSMutableArray * localCountriesArray;
        NSMutableArray * localCountriesArray1;
     
      NSMutableArray * localnewsID;
      NSMutableArray * localimageName;
      NSMutableArray * localImageURL;
      NSMutableArray * localNewsTitle;
      NSMutableArray * localTimestamp;
      NSMutableArray * localstatus;
     
        id <GetNewsListDelegate> delegate;
        
    }
 @property(nonatomic, retain)id <GetNewsListDelegate> delegate;
-(void)callWebService:(NSString *)Listtype;
 -(void)startParshing:(NSData *)myData;
    
@end
@protocol GetNewsListDelegate
    
-(void)getNewsTitleList:(NSMutableArray *)newsid  getNewsTitle:(NSMutableArray *)newstitle getImageName:(NSMutableArray *)imagename  getImageUrl:(NSMutableArray *)imageurl getTimeStamp:(NSMutableArray *)timestamp  status:(BOOL)value;
    @end
    
