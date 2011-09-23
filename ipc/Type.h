//
//  Type.h
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Type : NSObject {    
    NSString* _tid;
    NSString* _name;
    NSString* _desc;
    NSString* _image;
}

@property (nonatomic, retain) NSString *tid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *image;

- (id) initWithId:(NSString*)strId name:(NSString*)strName description:(NSString*)strDescription andImage:(NSString*)strImage;

@end
