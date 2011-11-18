//
//  ApplicationService.h
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 OngSoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "Type.h"
#import "Category.h"

@protocol ApplicationServiceDelegate

@optional
-(void) didFinishParsingType:(NSMutableDictionary*)typeDict andArray:(NSMutableArray*)typeArray;
-(void) didFinishParsingCategory:(NSMutableDictionary*)categoryDict andArray:(NSMutableArray*)categoryArray;
-(void) didFinishParsingProduct:(NSMutableArray *)c_productArray withPageDict:(NSMutableDictionary *)c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page;
-(void) didFinishParsingFavouriteProduct:(NSMutableArray *)c_productArray withPageDict:(NSMutableDictionary *)c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page;
-(void) didFinishParsingFeatureProduct:(NSMutableArray *)c_productArray withPageDict:(NSMutableDictionary*)c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page;
-(void) didFinishParsingSalesProduct:(NSMutableArray *)c_productArray withPageDict:(NSMutableDictionary *)c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page;
-(void) didFinishParsingFilterProduct:(NSMutableArray*)c_productArray withPageDict:(NSMutableDictionary *)c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page;
@end

@interface ApplicationService : NSObject {
    NSMutableDictionary* _categoryDict;
    NSMutableDictionary* _categoryForTypeDict;
    NSMutableArray* _categoryForTypeArray;
    NSMutableDictionary* _typeDict;
    NSMutableArray* _typeArray;
    NSMutableDictionary* _storeDict;
    NSMutableDictionary* _brandDict;
    
    NSMutableArray* _productArray;
    NSMutableDictionary* _productPages;
    
    NSMutableArray* _favoriteProductArray;
    NSMutableDictionary* _favoriteProductPages;
    
    NSMutableArray* _featureProductList;
    NSMutableArray* _featureProductArray;
    NSMutableDictionary* _featureProductPages;
    
    NSMutableArray* _salesProductArray;
    NSMutableDictionary* _salesProductPages;
    
    NSMutableArray* _filteredProductArray;
    NSMutableDictionary* _filteredProductPages;
    
	id<ApplicationServiceDelegate> _delegate;
    id<ApplicationServiceDelegate> _delegate2;
    id<ApplicationServiceDelegate> _delegate3;
    id<ApplicationServiceDelegate> _delegate4;
    NSInteger _totalProduct;
    NSInteger _startPosition;
    NSInteger _endPosition;
    NSInteger _pagePosition;
    NSInteger _totalSalesProduct;
    NSInteger _viewIndex;
    NSInteger _previousViewIndex;
    NSInteger _homeViewIndex;
}

@property (nonatomic,assign) id<ApplicationServiceDelegate> delegate;
@property (nonatomic,assign) id<ApplicationServiceDelegate> delegate2;
@property (nonatomic,assign) id<ApplicationServiceDelegate> delegate3;
@property (nonatomic,assign) id<ApplicationServiceDelegate> delegate4;
@property (nonatomic,assign) NSInteger totalProduct;
@property (nonatomic,assign) NSInteger startPosition;
@property (nonatomic,assign) NSInteger endPosition;
@property (nonatomic,assign) NSInteger pagePosition;
@property (nonatomic,assign) NSInteger totalSalesProducts;
@property (nonatomic, assign) NSInteger viewIndex;
@property (nonatomic, assign) NSInteger previousViewIndex;
@property (nonatomic, assign) NSInteger homeViewIndex;

-(NSMutableDictionary*) categoryDict;
-(NSMutableDictionary*) categoryForTypeDict;
-(NSMutableArray*) categoryForTypeArray;
-(NSMutableDictionary*) typeDict;
-(NSMutableArray*) typeArray;
-(NSMutableDictionary*) storeDict;
-(NSMutableDictionary*) brandDict;
-(NSMutableDictionary*) productPages;
-(NSMutableArray*) productArray;
-(NSMutableArray*) favouriteProductArray;
-(NSMutableArray*) featureProductArray;
-(NSMutableArray*) featureProductList;
-(NSMutableArray*) salesProductArray;
-(NSMutableArray*) filteredProductArray;
-(void) clearCategory;
-(void) clearProducts;
-(void) clearSalesProducts;
-(void) clearFavouriteProduct;
-(void) shuffleFeatureProductList;
-(void) clearFilteredProducts;
-(void) clearTypies;

-(void) loadCategories;
-(void) gotCategories:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedCategory;

-(void) loadCategoriesForType:(Type*)c_type;
-(void) gotCategoriesForType:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedCategoryForType;

-(void) loadTypes;
-(void) gotTypes:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedType;

-(void) loadStores;
-(void) gotStores:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedStore;

-(void) loadBrands;
-(void) gotBrands:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedBrand;

-(void) loadProducts;
-(void) loadProductsForType:(Type*)c_type forCatetory:(Category*)c_category;

-(void) loadProductsForType:(Type*)c_type forCatetory:(Category*)c_category from:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page;
-(void) gotProducts: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedProduct;

-(void) loadProductsForProductIds:(NSString*)ids from:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page;
-(void) gotFavouriteProducts: (NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedFavouriteProduct;

-(void) loadFeatureProductsList;
-(void) gotFeatureProductsList:(NSData *)data byRequest:(HttpRequest *)req;
-(void) didParsedFeatureProductsList;

-(void) loadProductsOfFeatureShopFrom:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page;
-(void) gotFeatureProducts:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedFeatureProduct;

-(void) loadProductsOnSalesFrom:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page;
-(void) gotSalesProducts:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedSalesProducts;

-(void) loadFilteredProductFrom:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page hasKeywords:(NSString*)keywords hasTypes:(NSString*)typies hasBrands:(NSString*)brands ofStores:(NSString*)stores inCategories:(NSString*)categories hasTopPrice:(NSString*)topPrice hasBottomPrice:(NSString*)bottomPrice;
-(void) gotFilteredProduct:(NSData*)data byRequest:(HttpRequest*)req;
-(void) didParsedFilteredProduct;

@end

