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
        _count = [[NSNumber alloc] initWithInteger:0];
        _name = [[NSString alloc] init];
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"categories"]){
        return _count;
    }
    if ([elementName isEqualToString:@"category"]) {
		_currentObject = [[Category alloc] init];
		return _currentObject;
	}
    if ([elementName isEqualToString:@"name"]){
        return _name;
    }
	return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"categories"]){
        [_count release];
        _count = [[NSNumber alloc] initWithInteger:[[attributeDict objectForKey:@"count"] intValue]];
        NSLog(@"count: %i", [_count intValue]);
    }
    if ([elementName isEqualToString:@"category"]) {
        _currentObject.cid = [attributeDict objectForKey:@"id"];
        //_currentObject.name = [attributeDict objectForKey:@"name"];
        //_currentObject.desc = [attributeDict objectForKey:@"description"];
        //_currentObject.imageName = [attributeDict objectForKey:@"image"];
    }
}

-(void) afterElementEnding:(NSString *)elementName{
    if ([elementName isEqualToString:@"category"]) {
        [_categoryDict setObject:_currentObject forKey:_currentObject.cid];
        NSLog(@"Category Id: %@", _currentObject.cid);
		[_currentObject release];
		_currentObject = nil;
        [_chars release];
        _chars = nil;
	}
    if ([elementName isEqualToString:@"name"]){
        //_currentObject.name = [[NSString alloc] initWithData:_chars encoding:nsutf];
        [_chars release];
        _chars = nil;
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
