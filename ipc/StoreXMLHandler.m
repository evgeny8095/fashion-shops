//
//  StoreXMLHandler.m
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StoreXMLHandler.h"


@implementation StoreXMLHandler
-(id) initWithStoreDict:(NSMutableDictionary *)storeDict{
    if (self = [super init]) {
        _storeDict = storeDict;
        _count = [[NSNumber alloc] init];
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"stores"]){
        return _count;
    }
    if ([elementName isEqualToString:@"store"]) {
		_currentObject = [[Store alloc] init];
		return _currentObject;
	}
    if ([elementName isEqualToString:@"name"]
        || [elementName isEqualToString:@"address"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"logo"]
        || [elementName isEqualToString:@"url"]
        || [elementName isEqualToString:@"map"]
        || [elementName isEqualToString:@"rating"]
        || [elementName isEqualToString:@"phone"]
        ){
        return _currentObject;
    }
    return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"stores"]){
        [_count release];
        _count = [[NSNumber alloc] initWithInteger:[[attributeDict objectForKey:@"count"] intValue]];
    }
    if ([elementName isEqualToString:@"store"]) {
        _currentObject.sid = [attributeDict objectForKey:@"id"];
    }
}

-(void) afterElementEnding:(NSString *)elementName{
    if ([elementName isEqualToString:@"store"]) {
        [_storeDict setObject:_currentObject forKey:_currentObject.sid];
		[_currentObject release];
		_currentObject = nil;
        [_chars release];
        _chars = nil;
	}
    if ([elementName isEqualToString:@"name"])
        _currentObject.name = _chars;
    if ([elementName isEqualToString:@"address"])
        _currentObject.address = _chars;
    if ([elementName isEqualToString:@"description"])
        _currentObject.desc = _chars;
    if ([elementName isEqualToString:@"logo"])
        _currentObject.logo = _chars;
    if ([elementName isEqualToString:@"url"])
        _currentObject.url = _chars;
    if ([elementName isEqualToString:@"map"])
        _currentObject.map = _chars;
    if ([elementName isEqualToString:@"rating"])
        _currentObject.rating = [_chars intValue];
    if ([elementName isEqualToString:@"phone"])
        _currentObject.phone = _chars;
    
}

-(NSString*) getWrappedRootNode
{
	return @"stores";
}

-(void) dealloc
{
	[super dealloc];
}

@end
