//
//  ApplicationService.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "Type.h"

@protocol ApplicationServiceDelegate

@optional
-(void) didFinishParsingCategory:(NSMutableDictionary*)categoryDict;

@end

@interface ApplicationService : NSObject {
    NSMutableDictionary* _categoryDict;
    NSMutableDictionary* _categoryForTypeDict;
    NSMutableDictionary* _typeDict;
    NSMutableDictionary* _storeDict;
    NSMutableDictionary* _brandDict;
    NSMutableDictionary* _productDict;
    BOOL _status;
	id<ApplicationServiceDelegate> _delegate;
}

@property (nonatomic,assign) id<ApplicationServiceDelegate> delegate;

-(NSMutableDictionary*) categoryDict;
-(NSMutableDictionary*) categoryForTypeDict;
-(NSMutableDictionary*) typeDict;
-(NSMutableDictionary*) storeDict;
-(NSMutableDictionary*) brandDict;
-(NSMutableDictionary*) productDict;
-(BOOL) finishParsing;

-(void) loadCategories;
-(void) loadCategoriesForType:(Type*)c_type;
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
