//
//  Store.h
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Store : NSObject {
    NSString* _sid;
    NSString* _name;
    NSString* _address;
    NSString* _desc;
    NSString* _logo;
    NSString* _url;
    NSString* _map;
    NSInteger _rating;
    NSString* _phone;
}
@property (nonatomic, retain) NSString *sid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *map;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, retain) NSString *phone;

- (id) initWithId:(NSString*)strId
             name:(NSString*)strName
      description:(NSString*)strDescription
          address:(NSString*)strAddress
             logo:(NSString*)strLogo
              url:(NSString*)strUrl
              map:(NSString*)strMap
           rating:(NSInteger)rating
         andPhone:(NSString*)strPhone;

@end
