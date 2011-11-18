//
//  Store.m
//  ipc
//
//  Created on 9/8/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "Store.h"


@implementation Store
@synthesize sid = _sid;
@synthesize name = _name;
@synthesize address = _address;
@synthesize desc = _desc;
@synthesize logo = _logo;
@synthesize url = _url;
@synthesize map = _map;
@synthesize rating = _rating;
@synthesize phone = _phone;

-(id) init
{
	if (self = [super init]) {
		_sid = nil;
		_name = nil;
        _address = nil;
		_desc = nil;
        _logo = nil;
        _url = nil;
        _map = nil;
        _rating = 0;
        _phone = nil;
	}
	return self;
}

- (id) initWithId:(NSString*)strId
             name:(NSString*)strName
      description:(NSString*)strDescription
          address:(NSString*)strAddress
             logo:(NSString*)strLogo
              url:(NSString*)strUrl
              map:(NSString*)strMap
           rating:(NSInteger)c_rating
         andPhone:(NSString*)strPhone
{
    if (self = [super init]) {
        _sid = strId;
		_name = strName;
        _address = strAddress;
		_desc = strDescription;
        _logo = strLogo;
        _url = strUrl;
        _map = strMap;
        _rating = c_rating;
        _phone = strPhone;
	}
    
    return self;
}

-(void) dealloc
{		
	[_sid release];
    [_name release];
    [_address release];
    [_desc release];
    [_logo release];
    [_url release];
    [_map release];
    [_phone release];
	[super dealloc];
}

@end
