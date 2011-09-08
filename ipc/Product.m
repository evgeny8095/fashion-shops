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
@synthesize brands = _brands;

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
        _brands = [[NSMutableDictionary alloc] init];
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
            types:(NSMutableDictionary*)c_types
       categories:(NSMutableDictionary*)c_categories
           brands:(NSMutableDictionary*)c_brands
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
        _types = c_types;
        _categories = c_categories;
        _brands = c_brands;
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
    [_brands release];
    _brands = nil;
	[super dealloc];
}

@end
