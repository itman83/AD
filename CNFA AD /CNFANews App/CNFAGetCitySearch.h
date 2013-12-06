//
//  CNFAGetCitySearch.h
//  CNFANews App
//
//  Created by iMac Apple on 09/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetCityListbySearchDelegate;
@interface CNFAGetCitySearch : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
       
    NSMutableArray * localCityID;
    NSMutableArray * localCityName;
    NSMutableArray * localcityTime;
    
    id <GetCityListbySearchDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetCityListbySearchDelegate> delegate;
-(void)callWebService:(NSString *)Listtype;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetCityListbySearchDelegate

-(void)getCityTitleListBySearch:(NSMutableArray *)Cityids  getCityName:(NSMutableArray *)citynames getTimsstamp:(NSMutableArray *)timestamp   status:(BOOL)value;
@end
