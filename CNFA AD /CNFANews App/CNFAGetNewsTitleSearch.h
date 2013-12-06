//
//  CNFAGetNewsTitleSearch.h
//  CNFANews App
//
//  Created by iMac Apple on 06/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GetNewsListbySearchDelegate;
@interface CNFAGetNewsTitleSearch : NSObject<NSXMLParserDelegate>{
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
    
    id <GetNewsListbySearchDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetNewsListbySearchDelegate> delegate;
-(void)callWebService:(NSString *)Listtype;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetNewsListbySearchDelegate

-(void)getNewsTitleListBySearch:(NSMutableArray *)newsid  getNewsTitle:(NSMutableArray *)newstitle getImageName:(NSMutableArray *)imagename  getImageUrl:(NSMutableArray *)imageurl getTimeStamp:(NSMutableArray *)timestamp  status:(BOOL)value;
@end

