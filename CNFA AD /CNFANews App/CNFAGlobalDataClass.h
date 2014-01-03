//
//  CNFAGlobalDataClass.h
//  CNFANews App
//
//  Created by iMac Apple on 25/10/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CNFAGlobalDataClass : NSObject
{
     Reachability* internetReachable;
     
}

@property (nonatomic, retain) NSString      *lognDone;
@property (nonatomic, retain) NSString      *cityId;
@property (nonatomic, retain) NSString      *cityId1;
@property (nonatomic, retain) NSIndexPath  *indPath;
+(CNFAGlobalDataClass*)getInstance;
-(NSString*) networkAvailable;
@end
