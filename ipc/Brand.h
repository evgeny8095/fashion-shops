//
//  Brand.h
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Brand : NSObject {    
    NSString* _bid;
    NSString* _name;
}

@property (nonatomic, retain) NSString *bid;
@property (nonatomic, retain) NSString *name;

- (id) initWithId:(NSString*)strId name:(NSString*)strName;

@end
