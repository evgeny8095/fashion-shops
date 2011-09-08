//
//  ProductXMLHandler.m
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProductXMLHandler.h"


@implementation ProductXMLHandler
-(id) initWithProductDict:(NSMutableDictionary *)productDict andApplication:(ApplicationService *)AppSer{
    if (self = [super init]) {
        _productDict = productDict;
        _count = [[NSNumber alloc] init];
        _typeDict = nil;
        _categoryDict = nil;
        _brandDict = nil;
        c_typeDict = [AppSer typeDict];
        c_categoryDict = [AppSer categoryDict];
        c_storeDict = [AppSer storeDict];
        c_brandDict = [AppSer brandDict];
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"products"]){
        return _count;
    }
    if ([elementName isEqualToString:@"product"]) {
		_currentObject = [[Product alloc] init];
		return _currentObject;
	}
    if ([elementName isEqualToString:@"name"]
        || [elementName isEqualToString:@"price"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"image"]
        || [elementName isEqualToString:@"rating"]
        || [elementName isEqualToString:@"url"]
        || [elementName isEqualToString:@"store"]
        ){
        return _currentObject;
    }
    if ([elementName isEqualToString:@"types"]) {
        if (_typeDict == nil) {
            _typeDict = [[NSMutableDictionary alloc] init];
            return _typeDict;
        }
    }
    if ([elementName isEqualToString:@"type"]) {
        return _typeDict;
    }
    if ([elementName isEqualToString:@"categories"]) {
        if (_categoryDict == nil) {
            _categoryDict = [[NSMutableDictionary alloc] init];
            return _categoryDict;
        }
    }
    if ([elementName isEqualToString:@"category"]) {
        return _categoryDict;
    }
    if ([elementName isEqualToString:@"brands"]) {
        if (_brandDict == nil) {
            _brandDict = [[NSMutableDictionary alloc] init];
            return _brandDict;
        }
    }
    if ([elementName isEqualToString:@"brand"]) {
        return _brandDict;
    }
    return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"products"]){
        [_count release];
        _count = [[NSNumber alloc] initWithInteger:[[attributeDict objectForKey:@"count"] intValue]];
        NSLog(@"count: %i", [_count intValue]);
    }
    if ([elementName isEqualToString:@"product"]) {
        _currentObject.pid = [attributeDict objectForKey:@"id"];
    }
}

-(void) afterElementEnding:(NSString *)elementName{
    if ([elementName isEqualToString:@"product"]) {
        [_productDict setObject:_currentObject forKey:_currentObject.pid];
        NSLog(@"Store Id: %@", _currentObject.pid);
		[_currentObject release];
		_currentObject = nil;
        [_chars release];
        _chars = nil;
	}
    if ([elementName isEqualToString:@"name"]){
        _currentObject.name = _chars;
        NSLog(@"name: %@", _currentObject.name);
    }
    if ([elementName isEqualToString:@"price"]) {
        _currentObject.price = [_chars intValue];
        NSLog(@"address: %@", _currentObject.price);
    }
    if ([elementName isEqualToString:@"description"]) {
        _currentObject.desc = _chars;
        NSLog(@"description: %@", _currentObject.desc);
    }
    if ([elementName isEqualToString:@"image"]) {
        _currentObject.image = _chars;
        NSLog(@"image: %@", _currentObject.image);
    }
    if ([elementName isEqualToString:@"url"]) {
        _currentObject.url = _chars;
        NSLog(@"url: %@", _currentObject.url);
    }
    if ([elementName isEqualToString:@"rating"]) {
        _currentObject.rating = [_chars intValue];
        NSLog(@"rating: %i", _currentObject.rating);
    }
    if ([elementName isEqualToString:@"store"]){
        _currentObject.store = [c_storeDict objectForKey:_chars];
    }
    if ([elementName isEqualToString:@"type"]) {
        //[_typeDict setObject: forKey:<#(id)#>
    }
    
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
