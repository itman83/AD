//
//  CNFAGetNewsListByCtID.m
//  CNFANews App
//
//  Created by iMac Apple on 20/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetNewsListByCtID.h"

@implementation CNFAGetNewsListByCtID
@synthesize delegate;



-(void)callWebService:(NSString *)CityID{
    //	NSLog(@"callWebService fn caalled");
	NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              "<soap:Body>"
                              "<MediaMenu xmlns=\"http://www.cnfanads.com/webservices/index.php?action=findnews&city_id=%@/\" />"
                              "</soap:Body>"
                              "</soap:Envelope>",CityID];
	
   
    NSURL *  url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=findnews&city_id=%@",CityID]];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSLog(@"CITY---NEWSPAPER ---%@",url);
   	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: [NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=findnews&city_id=%@",CityID]forHTTPHeaderField:@"SOAPAction"];
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
    [delegate getNewsTitleListByCity:Nil getNewsTitle:Nil getImageName:Nil getImageUrl:Nil getTimeStamp:Nil  status:FALSE];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing:webData];
    
    //	NSString * XmlDataHere= [[NSString alloc]initWithBytes:[webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    //	NSLog(@"1111111%@\n\n", XmlDataHere);
	
    //   NSLog(@"localCountriesArray = %@",localCountriesArray);
    
	webData = nil;
	[connection release];
    [delegate getNewsTitleListByCity:localnewsID getNewsTitle:localNewsTitle getImageName:localimageName getImageUrl:localImageURL getTimeStamp:localTimestamp  status:TRUE];
    [localCountriesArray release];
    
}


-(void)startParshing:(NSData *)myData{
    localCountriesArray = [[NSMutableArray alloc] init];
    localCountriesArray1 = [[NSMutableArray alloc] init];
    
    localnewsID= [[NSMutableArray alloc] init];
    localimageName= [[NSMutableArray alloc] init];
    localImageURL= [[NSMutableArray alloc] init];
    localNewsTitle= [[NSMutableArray alloc] init];
    localTimestamp= [[NSMutableArray alloc] init];
    localstatus= [[NSMutableArray alloc] init];
    
    
    
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
		[localnewsID addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"image"] == NSOrderedSame)
    	[localimageName addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"logo"] == NSOrderedSame)
    	[localImageURL addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"newspaper_name"] == NSOrderedSame)
    	[localNewsTitle addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"update_time"] == NSOrderedSame)
    	[localTimestamp addObject:currentData];
    //else if( [elementName caseInsensitiveCompare:@"view"] == NSOrderedSame)
    //	[localstatus addObject:currentData];
}

@end