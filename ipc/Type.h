//
//  Type.h
//  ipc
//
//  Created on 9/8/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Type : NSObject {    
    NSString* _tid;
    NSString* _name;
    NSString* _desc;
    NSString* _image;
    NSInteger _style;
}

@property (nonatomic, retain) NSString *tid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, assign) NSInteger style;

- (id) initWithId:(NSString*)strId name:(NSString*)strName description:(NSString*)strDescription andImage:(NSString*)strImage andStyle:(NSInteger)c_style;

@end
