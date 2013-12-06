//
//  CNFAGetContactUS.m
//  CNFANews App
//
//  Created by iMac Apple on 09/07/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetContactUS.h"

@implementation CNFAGetContactUS

@synthesize delegate;
//-(void)callWebService:(NSString *)Listtype{
    //	NSLog(@"callWebService fn caalled");


-(void)callWebService:(NSString *)name getemaiID:(NSString *)emailid getphone:(NSString *)phoneno getsubject:(NSString *)subjectname getmessage:(NSString *)messagetxt{
      NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              "<soap:Body>"
                              "<MediaMenu xmlns=\"http://www.cnfanads.com/webservices/index.php?action=contactus&name=%@&email=%@&phone=%@&subject=%@&message=%@/\" />"
                              "</soap:Body>"
                              "</soap:Envelope>",name,emailid,phoneno,subjectname,messagetxt];
	
    
    NSURL *  url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=contactus&name=%@&email=%@&phone=%@&subject=%@&message=%@",name,emailid,phoneno,subjectname,messagetxt]];
    
    NSLog(@"URLeewfrew %@",url);
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
   	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: [NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=contactus&name=%@&email=%@&phone=%@&subject=%@&message=%@",name,emailid,phoneno,subjectname,messagetxt]forHTTPHeaderField:@"SOAPAction"];
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
    [delegate getmsgLists:Nil status:FALSE];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing:webData];
       
	webData = nil;
	[connection release];
    
    
    [delegate getmsgLists:localsuccessresult status:TRUE];
    
    [localsuccessresult release];
   
}


-(void)startParshing:(NSData *)myData{
    
    localsuccessresult= [[NSMutableArray alloc] init];
   
    
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
	if( [elementName caseInsensitiveCompare:@"result"] == NSOrderedSame)
		[localsuccessresult addObject:currentData];
}

@end