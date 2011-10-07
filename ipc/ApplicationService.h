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
-(void) didFinishParsingCategory:(NSMutableDictionary*)categoryDict andArray:(NSMutableArray*)categoryArray;
-(void) didFinishParsingProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end;
-(void) didFinishParsingFavouriteProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end;
-(void) didFinishParsingFeatureProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end;
-(void) didFinishParsingSalesProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end;
@end

@interface ApplicationService : NSObject {
    NSMutableDictionary* _categoryDict;
    NSMutableDictionary* _categoryForTypeDict;
    NSMutableArray* _categoryForTypeArray;
    NSMutableDictionary* _typeDict;
    NSMutableDictionary* _storeDict;
    NSMutableDictionary* _brandDict;
    NSMutableDictionary* _productDict;
    NSMutableArray* _productArray;
    NSMutableArray* _favoriteProductArray;
    NSMutableArray* _featureProductArray;
    NSMutableArray* _featureProductList;
    NSMutableArray* _salesProductArray;
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
-(NSMutableArray*) categoryForTypeArray;
-(NSMutableDictionary*) typeDict;
-(NSMutableDictionary*) storeDict;
-(NSMutableDictionary*) brandDict;
-(NSMutableDictionary*) productDict;
-(NSMutableArray*) productArray;
-(NSMutableArray*) favouriteProductArray;
-(NSMutableArray*) featureProductArray;
-(NSMutableArray*) featureProductList;
-(NSMutableArray*) salesProductArray;
-(void) clearCategory;
-(void) clearProducts;
-(void) clearSalesProducts;
-(void) shuffleFeatureProductList;
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

-(void) loadProductsForProductIds:(NSString*)ids from:(NSInteger)start to:(NSInteger)end;
-(void) gotFavouriteProducts: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedFavouriteProduct;

-(void) loadFeatureProductsList;
-(void) gotFeatureProductsList:(NSData *)data byRequest:(HttpRequest *)req;
-(void) didParsedFeatureProductsList;

-(void) loadProductsOfFeatureShopFrom:(NSInteger)start to:(NSInteger)end;
-(void) gotFeatureProducts:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedFeatureProduct;

-(void) loadProductsOnSalesFrom:(NSInteger)start to:(NSInteger)end;
-(void) gotSalesProducts:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedSalesProducts;

@end

