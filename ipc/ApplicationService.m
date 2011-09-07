//
//  ApplicationService.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ApplicationService.h"
#import "CategoryXMLHandler.h"
#import "ipcGlobal.h"

@implementation ApplicationService

-(id) init
{
	if (self = [super init]) {
        _categoryDict = [[NSMutableDictionary alloc] init];
	} 
	return self;	
}

-(NSMutableDictionary*) categoryDict
{
    return _categoryDict;
}

#pragma mark -
#pragma mark loadCategories
-(void) loadCategories{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotCategories: byRequest:)];
	[req call:CATEGORIES_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void)gotCategories: (NSData*)data byRequest:(HttpRequest*)req
{
	NSLog(@"categories: %s", data.bytes);
    CategoryXMLHandler* handler = [[CategoryXMLHandler alloc] initWithCategoryDict:_categoryDict];
    //[handler setEndDocumentTarget:self andAction:@selector(didParsedCategory)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedCategory
{
//	for (Category* fr in _categoryDict) {
//		//[self loadFruitImage:fr];
//	}
}

@end
