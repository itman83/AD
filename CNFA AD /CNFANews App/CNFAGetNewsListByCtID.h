//
//  CNFAGetNewsListByCtID.h
//  CNFANews App
//
//  Created by iMac Apple on 20/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetNewsListDelegateByCT;
@interface CNFAGetNewsListByCtID : NSObject<NSXMLParserDelegate>{
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
    
    id <GetNewsListDelegateByCT> delegate;
    
}
@property(nonatomic, retain)id <GetNewsListDelegateByCT> delegate;
-(void)callWebService:(NSString *)CityID;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetNewsListDelegateByCT

-(void)getNewsTitleListByCity:(NSMutableArray *)newsid  getNewsTitle:(NSMutableArray *)newstitle getImageName:(NSMutableArray *)imagename  getImageUrl:(NSMutableArray *)imageurl getTimeStamp:(NSMutableArray *)timestamp  status:(BOOL)value;
@end

