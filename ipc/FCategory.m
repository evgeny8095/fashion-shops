//
//  FCategory.m
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FCategory.h"


@implementation FCategory
@dynamic cid;
@dynamic name;
@dynamic desc;
@dynamic image;

-(void) copyFromCategory:(Category *)category
{
    [self setCid:[category cid]];
    [self setName:[category name]];
    [self setDesc:[category desc]];
    [self setImage:[category image]];
}

-(Category*) toCategory
{
    Category* category = [[Category alloc] init];
    category.cid = self.cid;
    category.name = self.name;
    category.desc = self.desc;
    category.image = self.image;
    return category;
}

@end
