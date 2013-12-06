//
//  CNFAGetCityListandCat.h
//  CNFANews App
//
//  Created by Jiya on 7/7/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetCityCatListDelegate;
@interface CNFAGetCityListandCat : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
      
    NSMutableArray * localcatID;
    NSMutableArray * localcatimageName;
    NSMutableArray * localcatImageURL;
    NSMutableArray * localcatTitle;
    NSMutableArray * localNewsID;
    NSMutableArray * localcatstatus;
     NSMutableArray * localupdatetime;
     NSMutableArray * localupdatecitytime;
     NSMutableArray * localcatNumArt;
    
       
    
     NSMutableArray * localcityID;
      NSMutableArray * localCityName;
    
    id <GetCityCatListDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetCityCatListDelegate> delegate;
-(void)callWebService:(NSString *)Listtype;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetCityCatListDelegate

-(void)getCatCityTitleList:(NSMutableArray *)CatID  getcatTitle:(NSMutableArray *)CatTitle getcatImageName:(NSMutableArray *)catimageName  getcatImageUrl:(NSMutableArray *)Catimageurl getCatUpdateTimeStamp:(NSMutableArray *)catTimeStamp  getcatNumberArt:(NSMutableArray *)CatNumberArt  status:(BOOL)value;
@end

