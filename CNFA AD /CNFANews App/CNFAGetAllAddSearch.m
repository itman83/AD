//
//  CNFAGetAllAddSearch.m
//  CNFANews App
//
//  Created by iMac Apple on 15/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetAllAddSearch.h"

@implementation CNFAGetAllAddSearch
@synthesize delegate;
-(void)callWebService:(NSString *)CatID{
    
    	NSLog(@"CatID --------->%@",CatID);
	NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              "<soap:Body>"
                              "<MediaMenu xmlns=\"http://www.cnfanads.com/webservices/index.php?action=search_all&ads=%@/\" />"
                              "</soap:Body>"
                              "</soap:Envelope>",CatID];
	
    
    NSLog(@"soapMessage----------------> %@",soapMessage);
    
    
    NSURL *  url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=search_all&ads=%@",CatID] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSLog(@"URL %@",url);
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
   	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: [NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=search_all&ads=%@",CatID]forHTTPHeaderField:@"SOAPAction"];
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
    
    [delegate getAddnewsSubtitleByAllSearch:Nil getaddcatTitleName:Nil getaddCatText:Nil getaddcatCityname:Nil getadddescNews:Nil getaddCatadddTimeName:Nil getaddCatUpdateTimeStamp:Nil  status:FALSE];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing:webData];
    
	webData = nil;
	[connection release];
    
    [delegate getAddnewsSubtitleByAllSearch:localsubcatid getaddcatTitleName:localsubcatName getaddCatText:localsubcatText getaddcatCityname:localAdddescCityName getadddescNews:localaddescNewsName  getaddCatadddTimeName:localcreatedTime getaddCatUpdateTimeStamp:localUpdateTme  status:TRUE];
    
    [localsubcatid release];
    [localsubcatName release];
    [localsubcatText release];
    [localUpdateTme release];
    [localcreatedTime release];
    [localAdddescCityName release];
    [localaddescNewsName release];
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
    else if( [elementName caseInsensitiveCompare:@"ads_title"] == NSOrderedSame)
    	[localsubcatName addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"ads_desc"] == NSOrderedSame)
    	[localsubcatText addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"creation_time"] == NSOrderedSame)
    	[localcreatedTime addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"update_time"] == NSOrderedSame)
    	[localUpdateTme addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"newspaper_name"] == NSOrderedSame)
    	[localaddescNewsName addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"city-name"] == NSOrderedSame)
    	[localAdddescCityName addObject:currentData];
//    else if( [elementName caseInsensitiveCompare:@"newspaper_name"] == NSOrderedSame)
//    	[localaddescNewsName addObject:currentData];
    
}
@end