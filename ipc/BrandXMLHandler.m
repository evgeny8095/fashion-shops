//
//  BrandXMLHandler.m
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BrandXMLHandler.h"


@implementation BrandXMLHandler
-(id) initWithBrandDict:(NSMutableDictionary *)brandDict{
    if (self = [super init]) {
        _brandDict = brandDict;
        _count = [[NSNumber alloc] init];
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"brands"]){
        return _count;
    }
    if ([elementName isEqualToString:@"brand"]) {
		_currentObject = [[Brand alloc] init];
		return _currentObject;
	}
    if ([elementName isEqualToString:@"name"])
    {
        return _currentObject;
    }
	return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"brands"]){
        [_count release];
        _count = [[NSNumber alloc] initWithInteger:[[attributeDict objectForKey:@"count"] intValue]];
    }
    if ([elementName isEqualToString:@"brand"]) {
        [_currentObject setBid:[attributeDict objectForKey:@"id"]];
    }
}

-(void) afterElementEnding:(NSString *)elementName{
    if ([elementName isEqualToString:@"brand"]) {
        [_brandDict setObject:_currentObject forKey:_currentObject.bid];
		[_currentObject release];
		_currentObject = nil;
        [_chars release];
        _chars = nil;
	}
    if ([elementName isEqualToString:@"name"]){
        _currentObject.name = _chars;
    }
}

-(NSString*) getWrappedRootNode
{
	return @"brands";
}

-(void) dealloc
{
	[super dealloc];
}

@end