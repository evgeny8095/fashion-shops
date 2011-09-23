//
//  FProduct.h
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Product.h"

@class FBrand, FCategory, FStore, FType;

@interface FProduct : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * pid;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet* categories;
@property (nonatomic, retain) NSSet* typies;
@property (nonatomic, retain) FStore * store;
@property (nonatomic, retain) FBrand * brand;

-(void) copyFromProduct:(Product*)product;

@end
