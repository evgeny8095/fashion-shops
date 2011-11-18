//
//  RequestService.h
//  ipc
//
//  Created on 10/21/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"



@interface RequestService : NSObject {
    Boolean _isInfoNull;
    NSMutableDictionary* _information;
    NSString *_fullName;
    NSString *_phone;
    NSString *_email;
    NSString *_pid;
}

@property (nonatomic, assign) Boolean isInfoNull;
@property (nonatomic, assign) NSString *fullName;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *pid;

-(void) loadUserInformation;
-(void) saveUserInformation;
-(void) sentSingleProductRequest;
-(void) gotResponse:(NSData*)data byRequest:(HttpRequest*)req;

@end
