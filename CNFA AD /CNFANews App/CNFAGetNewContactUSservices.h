//
//  CNFAGetNewContactUSservices.h
//  CNFANews App
//
//  Created by iMac Apple on 22/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetContactUSNewDelegate;
@interface CNFAGetNewContactUSservices : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
    
    NSMutableArray * localID;
    NSMutableArray * localAddress;
    NSMutableArray * localphoneno;
    NSMutableArray * localfaxno;
    NSMutableArray * localemail;
    NSMutableArray * localwebsite;
    NSMutableArray * localEweibo;
    NSMutableArray * localrenron;
    
    id <GetContactUSNewDelegate> delegate;
    
}
@property(nonatomic, retain)id <GetContactUSNewDelegate> delegate;
-(void)callWebService:(NSString *)Listtype;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetContactUSNewDelegate



-(void)getcontentLists:(NSMutableArray *)ContactID  getAddress:(NSMutableArray *)AddressText getPhoneNo:(NSMutableArray *)PhoneNo getFaxNo:(NSMutableArray *)FaxNo  getEmailID:(NSMutableArray *)EmailID getwebsiteName:(NSMutableArray *)webName getEweiboLink:(NSMutableArray *)EweiboLink  getRenrenLink:(NSMutableArray *)RenrenLink  status:(BOOL)value;


@end

