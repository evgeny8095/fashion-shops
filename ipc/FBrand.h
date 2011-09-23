//
//  FBrand.h
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Brand.h"

@interface FBrand : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * bid;
@property (nonatomic, retain) NSString * name;

-(void) copyFromBrand:(Brand*)brand;
-(Brand*) toBrand;

@end
