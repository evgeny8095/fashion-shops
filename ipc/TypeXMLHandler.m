//
//  TypeXMLHandler.m
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeXMLHandler.h"


@implementation TypeXMLHandler

-(id) initWithTypeDict:(NSMutableDictionary *)typeDict{
    if (self = [super init]) {
        _typeDict = typeDict;
        _count = [[NSNumber alloc] init];
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"types"]){
        return _count;
    }
    if ([elementName isEqualToString:@"type"]) {
		_currentObject = [[Type alloc] init];
		return _currentObject;
	}
    if ([elementName isEqualToString:@"name"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"image"])
    {
        return _currentObject;
    }
	return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"types"]){
        [_count release];
        _count = [[NSNumber alloc] initWithInteger:[[attributeDict objectForKey:@"count"] intValue]];
    }
    if ([elementName isEqualToString:@"type"]) {
        [_currentObject setTid:[attributeDict objectForKey:@"id"]];
    }
}

-(void) afterElementEnding:(NSString *)elementName{
    if ([elementName isEqualToString:@"type"]) {
        [_typeDict setObject:_currentObject forKey:_currentObject.tid];
		[_currentObject release];
		_currentObject = nil;
        [_chars release];
        _chars = nil;
	}
    if ([elementName isEqualToString:@"name"]){
        _currentObject.name = _chars;
    }
    if ([elementName isEqualToString:@"description"]) {
        _currentObject.desc = _chars;
    }
    if ([elementName isEqualToString:@"image"]) {
        _currentObject.image = _chars;
    }
}

-(NSString*) getWrappedRootNode
{
	return @"types";
}

-(void) dealloc
{
	[super dealloc];
}

@end

