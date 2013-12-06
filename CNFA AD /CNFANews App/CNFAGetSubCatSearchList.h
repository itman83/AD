//
//  CNFAGetSubCatSearchList.h
//  CNFANews App
//
//  Created by iMac Apple on 20/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetSearchsubcategoryListDelegate;
@interface CNFAGetSubCatSearchList : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
    
    NSMutableArray * localsubcatid;
    NSMutableArray * localsubcatName;
    NSMutableArray * localsubcatText;
    NSMutableArray * localaddescNewsName;
    NSMutableArray * localAdddescCityName;
    NSMutableArray * localUpdateTme;
    NSMutableArray * localcreatedTime;
    
    
    id <GetSearchsubcategoryListDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetSearchsubcategoryListDelegate> delegate;
-(void)callWebService:(NSString *)cityID  getcateID:(NSString *)catID getnewsID:(NSString *)NewsID  gettexttext:(NSString *)searchtext;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetSearchsubcategoryListDelegate

-(void)getSearchListonSubcatView:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)cattext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp   status:(BOOL)value;
@end

