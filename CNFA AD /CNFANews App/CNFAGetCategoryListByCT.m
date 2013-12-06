//
//  CNFAGetCategoryListByCT.m
//  CNFANews App
//
//  Created by iMac Apple on 10/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetCategoryListByCT.h"

@implementation CNFAGetCategoryListByCT
@synthesize delegate;
-(void)callWebService:(NSString *)Listtype{
    //	NSLog(@"callWebService fn caalled");
	NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              "<soap:Body>"
                              "<MediaMenu xmlns=\"http://www.cnfanads.com/webservices/index.php?action=news_city&name=%@/\" />"
                              "</soap:Body>"
                              "</soap:Envelope>",Listtype];
	
    
    NSURL *  url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=news_city&name=%@",Listtype]];
    
    NSLog(@"URL %@",url);
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
   	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: [NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=news_city&name=%@",Listtype]forHTTPHeaderField:@"SOAPAction"];
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
    [delegate getCatNewsTitleList:Nil getcatTitle:localcatTitle getcatImageName:Nil getcatImageUrl:Nil getCatUpdateTimeStamp:Nil getNewsID:Nil getNewsName:Nil getNewsUpdateTime:Nil status:FALSE];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing:webData];
    
	webData = nil;
	[connection release];
    
    [delegate getCatNewsTitleList:localcatID getcatTitle:localcatTitle getcatImageName:localcatimageName getcatImageUrl:localcatImageURL getCatUpdateTimeStamp:localCatTimestamp getNewsID:localNewsID getNewsName:localNewsTitle getNewsUpdateTime:localNewsTimeStamp status:YES];
 
    [localcatID release];
    [localcatimageName release];
    [localcatImageURL release];
    [localcatTitle release];
    [localCatTimestamp release];
    [localNewsID release];
    [localNewsTitle release];
    [localNewsTimeStamp release];
    
}


-(void)startParshing:(NSData *)myData{
   
    localcatID= [[NSMutableArray alloc] init];
    localcatimageName= [[NSMutableArray alloc] init];
    localcatImageURL= [[NSMutableArray alloc] init];
    localcatTitle= [[NSMutableArray alloc] init];
    localCatTimestamp= [[NSMutableArray alloc] init];
   
    localNewsID= [[NSMutableArray alloc] init];
    localNewsTitle= [[NSMutableArray alloc] init];
    localNewsTimeStamp= [[NSMutableArray alloc] init];
    
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


    if( [elementName caseInsensitiveCompare:@"category_id"] == NSOrderedSame)
		[localcatID addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"image"] == NSOrderedSame)
    	[localcatimageName addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"logo"] == NSOrderedSame)
    	[localcatImageURL addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"category_name"] == NSOrderedSame)
    	[localcatTitle addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"update_time"] == NSOrderedSame)
    	[localCatTimestamp addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"id"] == NSOrderedSame)
    	[localNewsID addObject:currentData];
     else if( [elementName caseInsensitiveCompare:@"newspaper_name"] == NSOrderedSame)
    	[localNewsTitle addObject:currentData];
     else if( [elementName caseInsensitiveCompare:@"news_update_time"] == NSOrderedSame)
    	[localNewsTimeStamp addObject:currentData];
    
    
    NSLog(@"CCCC %@",localCityName);
    
}
@end