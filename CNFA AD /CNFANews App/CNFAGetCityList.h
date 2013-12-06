//
//  CNFAGetCityList.h
//  CNFANews App
//
//  Created by Jiya on 7/7/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetCityListDelegate;
@interface CNFAGetCityList : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
    
    NSMutableArray * localCity_ID;
    NSMutableArray * localCity_Name;
    NSMutableArray * localcityTimestamp;
    NSMutableArray * localProvince;
    id <GetCityListDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetCityListDelegate> delegate;
-(void)callWebService:(NSString *)Listtype;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetCityListDelegate

-(void)getCityLists:(NSMutableArray *)CityID  getCityTitleName :(NSMutableArray *)CityTitleName  getupdateTime:(NSMutableArray *)updatetimestamp  getProvince:(NSMutableArray *)province  status:(BOOL)value;
@end

