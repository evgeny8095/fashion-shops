//
//  FStore.m
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FStore.h"


@implementation FStore
@dynamic sid;
@dynamic name;
@dynamic address;
@dynamic desc;
@dynamic logo;
@dynamic url;
@dynamic map;
@dynamic rating;
@dynamic phone;

-(void) copyFromStore:(Store *)store
{
    [self setSid:[store sid]];
    [self setName:[store name]];
    [self setAddress:[store address]];
    [self setDesc:[store desc]];
    [self setLogo:[store logo]];
    [self setUrl:[store url]];
    [self setMap:[store map]];
    [self setRating:[NSNumber numberWithInt:[store rating]]];
    [self setPhone:[store phone]];
}

@end
