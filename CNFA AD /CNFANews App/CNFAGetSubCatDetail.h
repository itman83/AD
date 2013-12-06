//
//  CNFAGetSubCatDetail.h
//  CNFANews App
//
//  Created by iMac Apple on 13/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetSubCatAddDetail;
@interface CNFAGetSubCatDetail : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
    
    NSMutableArray * localsubcatid;
    NSMutableArray * localsubcatName;
    NSMutableArray * localsubcatText;
     NSMutableArray * localaddescNewsName;
     NSMutableArray * localAdddescCityName;
    NSMutableArray * localUpdateTme;
    NSMutableArray * localcreatedTime;
    
    
    id <GetSubCatAddDetail> delegate;
    
}
@property(nonatomic, retain)id <GetSubCatAddDetail> delegate;
-(void)callWebService:(NSString *)CatID;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetSubCatAddDetail

-(void)getAddnewsSubtitle:(NSMutableArray *)addcategID  getaddcatTitleName:(NSMutableArray *)addcatName getaddCatText:(NSMutableArray *)addcatlogotext getaddcatCityname:(NSMutableArray *)addCityName getadddescNews:(NSMutableArray *)addNewsName  getaddCatadddTimeName:(NSMutableArray *)Timeadded getaddCatUpdateTimeStamp:(NSMutableArray *)addupdateTimeStamp  status:(BOOL)value;
@end

