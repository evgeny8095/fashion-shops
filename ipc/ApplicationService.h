//
//  ApplicationService.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HttpRequest.h"

@interface ApplicationService : NSObject {
    NSMutableDictionary* _categoryDict;	
}

-(NSMutableDictionary*) categoryDict;

-(void) loadCategories;
-(void)gotCategories: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedCategory;

@end
