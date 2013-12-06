//
//  CNFAGetCityList.m
//  CNFANews App
//
//  Created by Jiya on 7/7/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetCityList.h"

@implementation CNFAGetCityList
@synthesize delegate;
-(void)callWebService:(NSString *)Listtype{
    //	NSLog(@"callWebService fn caalled");
	NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              "<soap:Body>"
                              "<MediaMenu xmlns=\"http://www.cnfanads.com/webservices/index.php?action=%@/\" />"
                              "</soap:Body>"
                              "</soap:Envelope>",Listtype];
	
    // http://www.cnfanads.com/webservices/index.php?action=city
    NSURL *  url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=%@",Listtype]];
    
    NSLog(@"URL %@",url);
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
   	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: [NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=%@",Listtype]forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: [NSString stringWithFormat:@"%d",[soapMessage length]] forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	webData = [[NSMutableData data] retain];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	[connection release];
	[webData release];
	webData = nil;
    [delegate getCityLists:Nil getCityTitleName:Nil getupdateTime:Nil getProvince:Nil status:FALSE];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing:webData];
    
   	webData = nil;
	[connection release];
    
    
    [delegate getCityLists:localCity_ID getCityTitleName:localCity_Name  getupdateTime:localcityTimestamp getProvince:localProvince status:YES];
    
     [localCity_ID release];
     [localCity_Name release];
     [localcityTimestamp release];
    [localProvince release];
}


-(void)startParshing:(NSData *)myData{
    
    localCity_ID= [[NSMutableArray alloc] init];
    localCity_Name= [[NSMutableArray alloc] init];
    localcityTimestamp= [[NSMutableArray alloc] init];
    localProvince=[[NSMutableArray alloc] init];
    
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:myData];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
	[parser parse];
	[parser release];
	[pool release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentData = @"";
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	currentData = [[currentData stringByAppendingString:string] mutableCopy];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
    
    
    if( [elementName caseInsensitiveCompare:@"id"] == NSOrderedSame)
		[localCity_ID addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"city_name"] == NSOrderedSame)
    	[localCity_Name addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"update_time"] == NSOrderedSame)
    	[localcityTimestamp addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"province"] == NSOrderedSame)
    	[localProvince addObject:currentData];

   // NSLog(@"CCCC %@",localCity_Name);
    
}

@end