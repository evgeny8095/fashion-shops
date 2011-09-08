//
//  Product.h
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Type.h"
#import "Category.h"
#import "Store.h"
#import "Brand.h"


@interface Product : NSObject {
    NSString* _pid;
    NSString* _name;
    NSInteger _price;
    NSString* _desc;
    NSString* _image;
    NSInteger _rating;
    NSString* _url;
    Store* _store;
    NSMutableDictionary* _types;
    NSMutableDictionary* _categories;
    NSMutableDictionary* _brands;
}

@property (nonatomic, retain) NSString *pid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) Store *store;
@property (nonatomic, retain) NSMutableDictionary *types;
@property (nonatomic, retain) NSMutableDictionary *categories;
@property (nonatomic, retain) NSMutableDictionary *brands;


- (id) initWithId:(NSString*)strId
             name:(NSString*)strName
            price:(NSInteger)c_price
      description:(NSString*)strDescription
            image:(NSString*)strImage
           rating:(NSInteger)c_rating
              url:(NSString*)strUrl
              map:(NSString*)strMap
            store:(Store*)store
            types:(NSMutableDictionary*)types
       categories:(NSMutableDictionary*)categories
           brands:(NSMutableDictionary*)brands;

@end
