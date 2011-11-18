//
//  Brand.m
//  ipc
//
//  Created on 9/8/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "Brand.h"


@implementation Brand
@synthesize bid = _bid, name = _name;

-(id) init
{
	if (self = [super init]) {
		_bid = nil;
		_name = nil;
	}
	return self;
}

-(id) initWithId:(NSString *)strId
            name:(NSString *)strName
{
    if (self = [super init]) {
        _bid = strId;
        _name = strName;
	}
	return self;
}

-(void) dealloc
{		
	[_bid release];
    [_name release];
	[super dealloc];
}

@end
