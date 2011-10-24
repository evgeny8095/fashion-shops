//
//  RequestService.h
//  ipc
//
//  Created by Mahmood1 on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
    NSMutableArray* _cart;
}

@property (nonatomic, assign) Boolean isInfoNull;
@property (nonatomic, assign) NSString *fullName;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *pid;
@property (nonatomic, retain) NSMutableArray *cart;

-(void) loadUserInformation;
-(void) saveUserInformation;
-(void) sentSingleProductRequest;
-(void) gotResponse:(NSData*)data byRequest:(HttpRequest*)req;

@end
