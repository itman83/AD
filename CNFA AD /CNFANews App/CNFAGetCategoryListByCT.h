//
//  CNFAGetCategoryListByCT.h
//  CNFANews App
//
//  Created by iMac Apple on 10/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GetNewsCatListDelegate;
@interface CNFAGetCategoryListByCT : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
    
    NSMutableArray * localcatID;
    NSMutableArray * localcatimageName;
    NSMutableArray * localcatImageURL;
    NSMutableArray * localcatTitle;
    NSMutableArray * localCatTimestamp;
    
    NSMutableArray * localNewsID;
    NSMutableArray * localNewsTitle;
    NSMutableArray * localNewsTimeStamp;
    
    
    
    
    NSMutableArray * localcityID;
    NSMutableArray * localCityName;
    
    id <GetNewsCatListDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetNewsCatListDelegate> delegate;
-(void)callWebService:(NSString *)Listtype;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetNewsCatListDelegate


-(void)getCatNewsTitleList:(NSMutableArray *)CatID  getcatTitle:(NSMutableArray *)CatTitle getcatImageName:(NSMutableArray *)catimageName  getcatImageUrl:(NSMutableArray *)Catimageurl getCatUpdateTimeStamp:(NSMutableArray *)CatUpdateTime getNewsID:(NSMutableArray *)newsId getNewsName:(NSMutableArray *)newsTitle  getNewsUpdateTime:(NSMutableArray *)NewsUpdateTime   status:(BOOL)value;
@end
