//
//  Type.m
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Type.h"


@implementation Type
@synthesize tid = _tid, name = _name, desc = _desc, imageName = _imageName;

-(id) init
{
	if (self = [super init]) {
		_tid = nil;
		_name = nil;
		_desc = nil;
        _imageName = nil;
	}
	return self;
}

-(id) initWithId:(NSString *)strId
            name:(NSString *)strName
     description:(NSString *)strDescription
    andImageName:(NSString *)strImageName{
    if (self = [super init]) {
        _tid = strId;
        _name = strName;
        _desc = strDescription;
        _imageName = strImageName;
	}
	return self;
}

-(void) dealloc
{		
	[_tid release];
    [_name release];
    [_desc release];
    [_imageName release];
	[super dealloc];
}

@end