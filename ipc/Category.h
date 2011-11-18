//
//  Category.h
//  ipc
//
//  Created on 9/6/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Category : NSObject {
    NSString* _cid;
    NSString* _name;
    NSString* _desc;
    NSString* _image;
}

@property (nonatomic, retain) NSString *cid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *image;

- (id) initWithId:(NSString*)strId name:(NSString*)strName description:(NSString*)strDescription andImageName:(NSString*)strImage;

@end
