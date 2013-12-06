//
//  CNFAGetCityListandCat.m
//  CNFANews App
//
//  Created by Jiya on 7/7/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFAGetCityListandCat.h"

@implementation CNFAGetCityListandCat
@synthesize delegate;
-(void)callWebService:(NSString *)Listtype{
    //	NSLog(@"callWebService fn caalled");
	NSString * soapMessage = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                              "<soap:Body>"
                              "<MediaMenu xmlns=\"http://www.cnfanads.com/webservices/index.php?action=findcat&newspaper_id=%@/\" />"
                              "</soap:Body>"
                              "</soap:Envelope>",Listtype];
	
    
    NSURL *  url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=findcat&newspaper_id=%@",Listtype]];
    
    NSLog(@"URLrrrr %@",url);
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
   	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: [NSString stringWithFormat:@"http://www.cnfanads.com/webservices/index.php?action=findcat&newspaper_id=%@",Listtype]forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: [NSString stringWithFormat:@"%d",[soapMessage length]] forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
    NSLog(@"%@",theRequest);
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
    
    [delegate getCatCityTitleList:Nil getcatTitle:Nil getcatImageName:Nil getcatImageUrl:Nil getCatUpdateTimeStamp:Nil getcatNumberArt:Nil status:FALSE];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing:webData];
    
	webData = nil;
	[connection release];
    
   

    [delegate getCatCityTitleList:localcatID getcatTitle:localcatTitle getcatImageName:localcatimageName getcatImageUrl:localcatImageURL getCatUpdateTimeStamp:localupdatetime getcatNumberArt:localcatNumArt status:TRUE];
    
    [localcatID release];
    [localcatimageName release];
    [localcatImageURL release];
    [localcatTitle release];
    [localNewsID release];
    [localcatstatus release];
    [localcityID release];
    [localCityName release];
    [localcatNumArt release];
     [localupdatetime release];
     [localupdatecitytime release];
}


-(void)startParshing:(NSData *)myData{

    localcatID= [[NSMutableArray alloc] init];
    localcatimageName= [[NSMutableArray alloc] init];
    localcatImageURL= [[NSMutableArray alloc] init];
    localcatTitle= [[NSMutableArray alloc] init];
    localNewsID= [[NSMutableArray alloc] init];
    localcatstatus= [[NSMutableArray alloc] init];
    localcityID= [[NSMutableArray alloc] init];
    localCityName= [[NSMutableArray alloc] init];
    localupdatetime= [[NSMutableArray alloc] init];
    localupdatecitytime= [[NSMutableArray alloc] init];
    localcatNumArt=[[NSMutableArray alloc] init];
     
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
		[localcatID addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"image"] == NSOrderedSame)
    	[localcatimageName addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"logo"] == NSOrderedSame)
    	[localcatImageURL addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"category"] == NSOrderedSame)
    	[localcatTitle addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"update_time"] == NSOrderedSame)
        [localupdatetime addObject:currentData];
    else if( [elementName caseInsensitiveCompare:@"total_ads"] == NSOrderedSame)
        [localcatNumArt addObject:currentData];
 }
@end