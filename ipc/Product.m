//
//  Product.m
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Product.h"


@implementation Product
@synthesize pid = _pid;
@synthesize name = _name;
@synthesize price = _price;
@synthesize desc = _desc;
@synthesize image = _image;
@synthesize url = _url;
@synthesize rating = _rating;
@synthesize types = _types;
@synthesize categories = _categories;
@synthesize store = _store;
@synthesize brand = _brand;

-(id) init
{
	if (self = [super init]) {
		_pid = nil;
		_name = nil;
        _price = 0;
		_desc = nil;
        _image = nil;
        _url = nil;
        _rating = 0;
        _types = [[NSMutableDictionary alloc] init];
        _categories = [[NSMutableDictionary alloc] init];
        _store = [[Store alloc] init];
        _brand = [[Brand alloc] init];
	}
	return self;
}

- (id) initWithId:(NSString*)strId
             name:(NSString*)strName
            price:(NSInteger)c_price
      description:(NSString*)strDescription
            image:(NSString*)strImage
           rating:(NSInteger)c_rating
              url:(NSString*)strUrl
              map:(NSString*)strMap
            store:(Store*)c_store
            brand:(Brand*)c_brand
            types:(NSMutableDictionary*)c_types
       categories:(NSMutableDictionary*)c_categories
{
    if (self = [super init]) {
        _pid = strId;
		_name = strName;
        _price = c_price;
		_desc = strDescription;
        _image = strImage;
        _url = strUrl;
        _rating = c_rating;
        _store = c_store;
        _brand = c_brand;
        _types = c_types;
        _categories = c_categories;
	}
    
    return self;
}

-(void) dealloc
{		
	[_pid release];
    [_name release];
    [_desc release];
    [_image release];
    [_url release];
    [_types release];
    _types = nil;
    [_categories release];
    _categories = nil;
    [_store release];
    _store = nil;
    [_brand release];
    _brand = nil;
	[super dealloc];
}

@end
