//
//  CNFAGlobalDataClass.m
//  CNFANews App
//
//  Created by iMac Apple on 25/10/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGlobalDataClass.h"

@implementation CNFAGlobalDataClass
@synthesize lognDone,indPath;
static CNFAGlobalDataClass *instance =nil;
+(CNFAGlobalDataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [CNFAGlobalDataClass new];
        }
    }
    return instance;
}
-(NSString *)networkAvailable
{
    NSString *status;
    internetReachable = [[Reachability reachabilityForInternetConnection] retain];
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    
    
    
    NSLog(@"%d",internetStatus);
    
    if (internetStatus==0) {
        status=@"NotReachable";
    } else {
        status=@"Reachable";
    }
    return status;
    
    
    
}

@end
