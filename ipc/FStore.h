//
//  FStore.h
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Store.h"

@interface FStore : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * sid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * map;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * phone;

-(void) copyFromStore:(Store*)store;
-(Store*) toStore;

@end
