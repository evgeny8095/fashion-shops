//
//  ProductXMLHandler.m
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProductXMLHandler.h"


@implementation ProductXMLHandler
-(id) initWithProductDict:(NSMutableDictionary *)productDict productArray:(NSMutableArray*)productArray andApplication:(ApplicationService *)AppSer{
    if (self = [super init]) {
        _productDict = productDict;
        _productArray = productArray;
        _typeDict = nil;
        _categoryDict = nil;
        c_typeDict = [AppSer typeDict];
        c_categoryDict = [AppSer categoryDict];
        c_storeDict = [AppSer storeDict];
        c_brandDict = [AppSer brandDict];
        c_appSrv = AppSer;
    }
    return self;
}

-(id) initObjectAfterElementStarting:(NSString *)elementName{
    if ([elementName isEqualToString:@"products"]){
        return _productArray;
    }
    if ([elementName isEqualToString:@"product"]) {
        if (_currentObject == nil) {
            _currentObject = [[Product alloc] init];
            return _currentObject;
        }
	}
    if ([elementName isEqualToString:@"name"]
        || [elementName isEqualToString:@"price"]
        || [elementName isEqualToString:@"description"]
        || [elementName isEqualToString:@"image"]
        || [elementName isEqualToString:@"rating"]
        || [elementName isEqualToString:@"url"]
        || [elementName isEqualToString:@"store"]
        || [elementName isEqualToString:@"brand"]
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
    return nil;
}

-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"products"]){
        totalProduct = [[attributeDict objectForKey:@"count"] intValue];
        [c_appSrv setTotalProduct:totalProduct];
        startPosition = [[attributeDict objectForKey:@"start"] intValue];
        [c_appSrv setStartPosition:startPosition];
        endPosition = [[attributeDict objectForKey:@"end"] intValue];
        [c_appSrv setEndPosition:endPosition];
    }
    if ([elementName isEqualToString:@"product"]) {
        _currentObject.pid = [attributeDict objectForKey:@"id"];
    }
}

-(void) afterElementEnding:(NSString *)elementName{
    if ([elementName isEqualToString:@"product"]) {
        //[_productDict setObject:_currentObject forKey:_currentObject.pid];
        [_productArray addObject:_currentObject];
		[_currentObject release];
		_currentObject = nil;
        [_chars release];
        _chars = nil;
	}
    if ([elementName isEqualToString:@"name"]){
        _currentObject.name = _chars;
        //NSLog(@"name: %@", _chars);
    }
    if ([elementName isEqualToString:@"price"]) {
        _currentObject.price = [_chars intValue];
    }
    if ([elementName isEqualToString:@"description"]) {
        _currentObject.desc = _chars;
    }
    if ([elementName isEqualToString:@"image"]) {
        _currentObject.image = _chars;
    }
    if ([elementName isEqualToString:@"url"]) {
        _currentObject.url = _chars;
    }
    if ([elementName isEqualToString:@"rating"]) {
        _currentObject.rating = [_chars intValue];
    }
    if ([elementName isEqualToString:@"store"]){
        _currentObject.store = [c_storeDict objectForKey:_chars];
    }
    if ([elementName isEqualToString:@"brand"]) {
        _currentObject.brand = [c_brandDict objectForKey:_chars];
    }
    if ([elementName isEqualToString:@"type"]) {
        Type *type = [c_typeDict objectForKey:_chars];
        if (type != nil) {
            [_typeDict setObject:type forKey:_chars];
        }        
    }
    if ([elementName isEqualToString:@"category"]){
        Category *category = [c_categoryDict objectForKey:_chars];
        if (category != nil) {
            [_categoryDict setObject:category forKey:_chars];
        }        
    }    
}

-(NSString*) getWrappedRootNode
{
	return @"products";
}

-(void) dealloc
{
	[super dealloc];
}

@end
