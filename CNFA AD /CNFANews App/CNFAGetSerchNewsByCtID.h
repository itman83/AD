//
//  CNFAGetSerchNewsByCtID.h
//  CNFANews App
//
//  Created by iMac Apple on 20/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetSearchNewsclassBYCTIDDelegate;
@interface CNFAGetSerchNewsByCtID : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
    
    NSMutableArray * localsubcatid;
    NSMutableArray * localsubcatName;
    NSMutableArray * localsubcatText;
    NSMutableArray * localaddescNewsName;
    NSMutableArray * localAdddescCityName;
    NSMutableArray * localUpdateTme;
    NSMutableArray * localcreatedTime;
    
    
    id <GetSearchNewsclassBYCTIDDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetSearchNewsclassBYCTIDDelegate> delegate;
-(void)callWebService:(NSString *)newsID  getsearchtextID:(NSString *)searchtext;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetSearchNewsclassBYCTIDDelegate

-(void)getAddnewsSubtitleByCTIDsearch:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)cattext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp   status:(BOOL)value;
@end

