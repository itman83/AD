//
//  CNFAGetNewContactUSservices.m
//  CNFANews App
//
//  Created by iMac Apple on 22/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetNewContactUSservices.h"

@implementation CNFAGetNewContactUSservices
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
    [delegate getcontentLists:Nil getAddress:Nil getPhoneNo:Nil getFaxNo:Nil getEmailID:Nil getwebsiteName:Nil getEweiboLink:Nil getRenrenLink:Nil status:FALSE];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing:webData];
    
	webData = nil;
	[connection release];
    
    
    [delegate getcontentLists:localID getAddress:localAddress getPhoneNo:localphoneno getFaxNo:localfaxno getEmailID:localemail getwebsiteName:localwebsite getEweiboLink:localEweibo getRenrenLink:localrenron status:YES];
    [localID release];
    [localAddress release];
    
    [localphoneno release];
    [localfaxno release];
    [localemail release];
    [localwebsite release];
    [localEweibo release];
    [localrenron release];

    
}


-(void)startParshing:(NSData *)myData{
    localID= [[NSMutableArray alloc] init];
    localAddress= [[NSMutableArray alloc] init];
    localphoneno= [[NSMutableArray alloc] init];
    localfaxno= [[NSMutableArray alloc] init];
    localemail= [[NSMutableArray alloc] init];
    localwebsite= [[NSMutableArray alloc] init];
    localEweibo= [[NSMutableArray alloc] init];
    localrenron= [[NSMutableArray alloc] init];

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
		[localID addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"address"] == NSOrderedSame)
    	[localAddress addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"phone_no"] == NSOrderedSame)
    	[localphoneno addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"fax_no"] == NSOrderedSame)
    	[localfaxno addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"mail_id"] == NSOrderedSame)
    	[localemail addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"website_name"] == NSOrderedSame)
    	[localwebsite addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"social_url1"] == NSOrderedSame)
    	[localEweibo addObject:currentData];
   else if( [elementName caseInsensitiveCompare:@"social_url2"] == NSOrderedSame)
    	[localrenron addObject:currentData];

    //    NSLog(@"CCCC %@",localCity_ID);
    
}

@end