//
//  Brand.h
//  ipc
//
//  Created on 9/8/11.
//  Copyright 2011 OngSoft. All rights reserved.
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
