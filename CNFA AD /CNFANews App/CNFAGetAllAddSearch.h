//
//  CNFAGetAllAddSearch.h
//  CNFANews App
//
//  Created by iMac Apple on 15/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetSubCatAddDetailBYAllSearch;
     @interface CNFAGetAllAddSearch : NSObject<NSXMLParserDelegate>{
         NSMutableData * webData;
         NSString * currentData;
         
         NSMutableArray * localsubcatid;
         NSMutableArray * localsubcatName;
         NSMutableArray * localsubcatText;
         NSMutableArray * localaddescNewsName;
         NSMutableArray * localAdddescCityName;
         NSMutableArray * localUpdateTme;
         NSMutableArray * localcreatedTime;
         
         
         id <GetSubCatAddDetailBYAllSearch> delegate;
         
     }
     @property(nonatomic, retain)id <GetSubCatAddDetailBYAllSearch> delegate;
     -(void)callWebService:(NSString *)CatID;
     -(void)startParshing:(NSData *)myData;
     
     @end
     @protocol GetSubCatAddDetailBYAllSearch
     
     -(void)getAddnewsSubtitleByAllSearch:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)cattext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp   status:(BOOL)value;
     @end
     
