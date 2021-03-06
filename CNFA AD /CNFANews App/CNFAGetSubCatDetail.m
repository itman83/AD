//
//  CNFAGetSubCatDetail.m
//  CNFANews App
//
//  Created by iMac Apple on 13/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetSubCatDetail.h"
#import "CNFAGlobalDataClass.h"
@implementation CNFAGetSubCatDetail

@synthesize delegate;
-(void)callWebService:(NSString *)CatID{
    //	NSLog(@"callWebService fn caalled");
    CNFAGlobalDataClass *obj=[CNFAGlobalDataClass getInstance];
	NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              "<soap:Body>"
                              "<MediaMenu xmlns=\"http://www.cnfanads.com/webservices/index.php?action=findads&category_id=%@&cityid=%@/\" />"
                              "</soap:Body>"
                              "</soap:Envelope>",CatID,obj.cityId];
	
    
    NSURL *  url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=findads&category_id=%@&cityid=%@",CatID,obj.cityId]];
    
    NSLog(@"URL %@",url);
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
   	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: [NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=findads&category_id=%@cityid=%@",CatID,obj.cityId]forHTTPHeaderField:@"SOAPAction"];
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
    
   [delegate getAddnewsSubtitle:Nil getaddcatTitleName:Nil getaddCatText:Nil getaddcatCityname:Nil getadddescNews:Nil getaddCatadddTimeName:Nil getaddCatUpdateTimeStamp:Nil status:FALSE];

    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing:webData];
    
	webData = nil;
	[connection release];
    
    [delegate getAddnewsSubtitle:localsubcatid getaddcatTitleName:localsubcatName getaddCatText:localsubcatText getaddcatCityname:localAdddescCityName getadddescNews:localaddescNewsName  getaddCatadddTimeName:localcreatedTime getaddCatUpdateTimeStamp:localUpdateTme status:TRUE];
   
    [localsubcatid release];
    [localsubcatName release];
    [localsubcatText release];
    [localUpdateTme release];
    [localcreatedTime release];
     [localAdddescCityName release];
     [localaddescNewsName release];
//    CNFAGlobalDataClass *obj=[CNFAGlobalDataClass getInstance];
//    [obj setCityId:@""];
}


-(void)startParshing:(NSData *)myData{
     localsubcatid= [[NSMutableArray alloc] init];
    localsubcatName= [[NSMutableArray alloc] init];
    localsubcatText= [[NSMutableArray alloc] init];
    localUpdateTme= [[NSMutableArray alloc] init];
    localcreatedTime= [[NSMutableArray alloc] init];
    localAdddescCityName= [[NSMutableArray alloc] init];
    localaddescNewsName= [[NSMutableArray alloc] init];
    
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
		[localsubcatid addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"title"] == NSOrderedSame)
    	[localsubcatName addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"description"] == NSOrderedSame)
    	[localsubcatText addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"creation_time"] == NSOrderedSame)
    	[localcreatedTime addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"update_time"] == NSOrderedSame)
    	[localUpdateTme addObject:currentData];
   else if( [elementName caseInsensitiveCompare:@"city_id"] == NSOrderedSame)
    	[localaddescNewsName addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"city_name"] == NSOrderedSame)
    	[localAdddescCityName addObject:currentData];
    
    
    // NSLog(@"CCCC %@",localCityName);
    
}
@end