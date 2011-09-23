//
//  FType.m
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FType.h"


@implementation FType
@dynamic tid;
@dynamic name;
@dynamic desc;
@dynamic image;

-(void) copyFromType:(Type *)type
{
    [self setTid:[type tid]];
    [self setName:[type name]];
    [self setDesc:[type desc]];
    [self setImage:[type image]];
}

@end
