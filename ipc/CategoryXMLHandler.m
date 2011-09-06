//
//  CategoryXMLHandler.m
//  ipc
//
//  Created by Mahmood1 on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryXMLHandler.h"


@implementation CategoryXMLHandler

-(id) initWithCategoryDict:(NSMutableDictionary *)categoryDict{
    if (self = [super init]) {
        _categoryDict = categoryDict;
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"category"]) {
		_currentObject = [[Category alloc] init];
		return _currentObject;
	}
	return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict{
    _currentObject.cid = [attributeDict objectForKey:@"id"];
    _currentObject.name = [attributeDict objectForKey:@"name"];
    _currentObject.desc = [attributeDict objectForKey:@"description"];
    _currentObject.imageName = [attributeDict objectForKey:@"image"];
}

-(void) afterElementEnding:(NSString *)elementName{
    if ([elementName isEqualToString:@"category"]) {
        [_categoryDict setObject:_currentObject forKey:_currentObject.cid];
		[_currentObject release];
		_currentObject = nil;
	}
}

-(NSString*) getWrappedRootNode
{
	return @"categories";
}

-(void) dealloc
{
	[super dealloc];
}

@end
