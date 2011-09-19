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
#import "Category.h"

@protocol ApplicationServiceDelegate

@optional
-(void) didFinishParsingCategory:(NSMutableDictionary*)categoryDict;
-(void) didFinishParsingProduct:(NSMutableArray *)productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end;

@end

@interface ApplicationService : NSObject {
    NSMutableDictionary* _categoryDict;
    NSMutableDictionary* _categoryForTypeDict;
    NSMutableDictionary* _typeDict;
    NSMutableDictionary* _storeDict;
    NSMutableDictionary* _brandDict;
    NSMutableDictionary* _productDict;
    NSMutableArray* _productArray;
    BOOL _status;
	id<ApplicationServiceDelegate> _delegate;
    NSInteger _totalProduct;
    NSInteger _startPosition;
    NSInteger _endPosition;
}

@property (nonatomic,assign) id<ApplicationServiceDelegate> delegate;
@property (nonatomic,assign) NSInteger totalProduct;
@property (nonatomic,assign) NSInteger startPosition;
@property (nonatomic,assign) NSInteger endPosition;

-(NSMutableDictionary*) categoryDict;
-(NSMutableDictionary*) categoryForTypeDict;
-(NSMutableDictionary*) typeDict;
-(NSMutableDictionary*) storeDict;
-(NSMutableDictionary*) brandDict;
-(NSMutableDictionary*) productDict;
-(NSMutableArray*) productArray;
-(void) clearProducts;


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
-(void) loadProductsForType:(Type*)c_type forCatetory:(Category*)c_category;
-(void) loadProductsForType:(Type*)c_type forCatetory:(Category*)c_category from:(NSInteger)start to:(NSInteger)end;
-(void) gotProducts: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedProduct;

@end

