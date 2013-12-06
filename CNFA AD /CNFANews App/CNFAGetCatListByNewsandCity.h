//
//  CNFAGetCatListByNewsandCity.h
//  CNFANews App
//
//  Created by iMac Apple on 12/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>
 @protocol GetSearchdelegateByNewsID;
 @interface CNFAGetCatListByNewsandCity : NSObject<NSXMLParserDelegate>{
        NSMutableData * webData;
        NSString * currentData;
        
        NSMutableArray * localsubcatid;
        NSMutableArray * localsubcatName;
        NSMutableArray * localsubcatText;
        NSMutableArray * localaddescNewsName;
        NSMutableArray * localAdddescCityName;
        NSMutableArray * localUpdateTme;
        NSMutableArray * localcreatedTime;
        
        
        id <GetSearchdelegateByNewsID> delegate;
        
    }
    @property(nonatomic, retain)id <GetSearchdelegateByNewsID> delegate;
-(void)callWebService:(NSString *)newsID  getsearchtextID:(NSString *)searchtext;
    -(void)startParshing:(NSData *)myData;
    
    @end
    @protocol GetSearchdelegateByNewsID
    
    -(void)getAddnewsSubtitleByNewsIDsearch:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)cattext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp   status:(BOOL)value;
    @end
    
