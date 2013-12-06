//
//  CNFAGetAboutUSService.m
//  CNFANews App
//
//  Created by iMac Apple on 08/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetAboutUSService.h"

@implementation CNFAGetAboutUSService
@synthesize delegate;
-(void)callWebService:(NSString *)Listtype{
    //	NSLog(@"callWebService fn caalled");
    localContent=@"";
	NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              "<soap:Body>"
                              "<MediaMenu xmlns=\"http://www.cnfanads.com/webservices/index.php?action=%@/\" />"
                              "</soap:Body>"
                              "</soap:Envelope>",Listtype];
	
    
    NSURL *  url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=%@",Listtype]];
    
    NSLog(@"ABOUT US : URL : %@",url);
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
   	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: [NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=%@",Listtype]forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: [NSString stringWithFormat:@"%d",[soapMessage length]] forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    



	 NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    [connection start];
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
    //[delegate getcontentLists:Nil getTimeStamp:Nil status:FALSE];
    [delegate getcontentLists:nil status:FALSE];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
//	[self startParshing:webData];
    NSError *jsonParsingError = nil;
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:&jsonParsingError];
    
   // NSLog(@"WEATHER CITY  :::%@",[json objectForKey:@"content"] );
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
    } else {
         [localcontent_Name addObject:[json objectForKey:@"content"] ];
        localContent=[NSString stringWithFormat:@"%@",[json objectForKey:@"content"]];
    }
  
    

	webData = nil;
	[connection release];
    
    
    //[delegate getcontentLists:localcontent_Name getTimeStamp:localTimestamp  status:YES];
    [delegate getcontentLists:localContent status:YES];
    [localTimestamp release];
    [localcontent_Name release];
}


-(void)startParshing:(NSData *)myData{
    
    localTimestamp= [[NSMutableArray alloc] init];
    localcontent_Name= [[NSMutableArray alloc] init];
    
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:myData];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:YES];
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
	
    
    
    if( [elementName caseInsensitiveCompare:@"content"] == NSOrderedSame)
    {
         NSLog(@"currentData : %@",currentData);
        [localcontent_Name addObject:currentData];
    }
		
    else if( [elementName caseInsensitiveCompare:@"update_time"] == NSOrderedSame)
    	[localTimestamp addObject:currentData];
//    NSLog(@"CCCC %@",localCity_ID);
    
}

@end