//
//  FType.h
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Type.h"


@interface FType : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * tid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * image;

-(void) copyFromType:(Type*)type;
-(Type*) toType;

@end