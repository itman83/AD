//
//  CNFAGetAboutUSService.h
//  CNFANews App
//
//  Created by iMac Apple on 08/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetaboutUSDelegate;
@interface CNFAGetAboutUSService : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
    
    NSMutableArray * localTimestamp;
    NSMutableArray * localcontent_Name;
    NSString *localContent;
    id <GetaboutUSDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetaboutUSDelegate> delegate;
-(void)callWebService:(NSString *)Listtype;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetaboutUSDelegate

//-(void)getcontentLists:(NSMutableArray *)ContentTitleName  getTimeStamp:(NSMutableArray *)ContentTimeStamp   status:(BOOL)value;
-(void)getcontentLists:(NSString *)ContentTitleName status:(BOOL)value;
@end

