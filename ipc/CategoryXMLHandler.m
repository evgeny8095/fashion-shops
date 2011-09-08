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
        _count = [[NSNumber alloc] init];
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
    if ([elementName isEqualToString:@"description"]){
        return _description;
    }
    if ([elementName isEqualToString:@"image"]){
        return _image;
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
        _currentObject.name = _chars;
        NSLog(@"name: %@", _currentObject.name);
    }
    if ([elementName isEqualToString:@"description"]) {
        _currentObject.desc = _chars;
        NSLog(@"description: %@", _currentObject.desc);
    }
    if ([elementName isEqualToString:@"image"]) {
        _currentObject.imageName = _chars;
        NSLog(@"image: %@", _currentObject.imageName);
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
