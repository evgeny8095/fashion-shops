//
//  Product.h
//  ipc
//
//  Created on 9/8/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Type.h"
#import "Category.h"
#import "Store.h"
#import "Brand.h"

@interface Product : NSObject {
    NSString* _pid;
    NSString* _name;
    NSInteger _price;
    NSInteger _discount;
    NSString* _desc;
    NSString* _image;
    NSInteger _rating;
    NSString* _url;
    Store* _store;
    Brand* _brand;
    NSMutableDictionary* _types;
    NSMutableDictionary* _categories;
}

@property (nonatomic, retain) NSString *pid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger discount;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) Store *store;
@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) NSMutableDictionary *types;
@property (nonatomic, retain) NSMutableDictionary *categories;


- (id) initWithId:(NSString*)strId
             name:(NSString*)strName
            price:(NSInteger)c_price
         discount:(NSInteger)c_discount
      description:(NSString*)strDescription
            image:(NSString*)strImage
           rating:(NSInteger)c_rating
              url:(NSString*)strUrl
              map:(NSString*)strMap
            store:(Store*)store
            brand:(Brand*)brand
            types:(NSMutableDictionary*)types
       categories:(NSMutableDictionary*)categories;

@end
