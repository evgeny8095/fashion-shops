//
//  ApplicationService.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HttpRequest.h"

@interface ApplicationService : NSObject {
    NSMutableDictionary* _categoryDict;
    NSMutableDictionary* _typeDict;
    NSMutableDictionary* _storeDict;
    NSMutableDictionary* _brandDict;
    NSMutableDictionary* _productDict;
}

-(NSMutableDictionary*) categoryDict;
-(NSMutableDictionary*) typeDict;
-(NSMutableDictionary*) storeDict;
-(NSMutableDictionary*) brandDict;
-(NSMutableDictionary*) productDict;

-(void) loadCategories;
-(void) gotCategories: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedCategory;

-(void) loadTypes;
-(void) gotTypes: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedType;

-(void) loadStores;
-(void) gotStores: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedStore;

-(void) loadBrands;
-(void) gotBrands: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedBrand;

-(void) loadProducts;
-(void) gotProducts: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedProduct;

@end
