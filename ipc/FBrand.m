//
//  FBrand.m
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FBrand.h"


@implementation FBrand
@dynamic bid;
@dynamic name;

-(void) copyFromBrand:(Brand *)brand
{
    [self setBid:[brand bid]];
    [self setName:[brand name]];
}

@end
