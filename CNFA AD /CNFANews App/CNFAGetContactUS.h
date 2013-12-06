//
//  CNFAGetContactUS.h
//  CNFANews App
//
//  Created by iMac Apple on 09/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetContactUsDelegate;
@interface CNFAGetContactUS : NSObject<NSXMLParserDelegate>{
    NSMutableData * webData;
    NSString * currentData;
    
    NSMutableArray * localsuccessresult;
       id <GetContactUsDelegate> delegate;
    
}


@property(nonatomic, retain)id <GetContactUsDelegate> delegate;
-(void)callWebService:(NSString *)name getemaiID:(NSString *)emailid getphone:(NSString *)phoneno getsubject:(NSString *)subjectname getmessage:(NSString *)messagetxt;
-(void)startParshing:(NSData *)myData;

@end
@protocol GetContactUsDelegate

-(void)getmsgLists:(NSMutableArray *)successmsg    status:(BOOL)value;
@end

