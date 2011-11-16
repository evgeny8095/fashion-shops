//
//  ApplicationService.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ApplicationService.h"
#import "ipcGlobal.h"
#import "TypeXMLHandler.h"
#import "CategoryXMLHandler.h"
#import "StoreXMLHandler.h"
#import "BrandXMLHandler.h"
#import "ProductXMLHandler.h"
#import "ProductSliderViewController.h"

@implementation ApplicationService
@synthesize delegate = _delegate, delegate2 = _delegate2, delegate3 = _delegate3, delegate4 = _delegate4;
@synthesize totalProduct = _totalProduct, startPosition = _startPosition, endPosition = _endPosition, totalSalesProducts = _totalSalesProduct, pagePosition = _pagePosition;
@synthesize viewIndex = _viewIndex, previousViewIndex = _previousViewIndex, homeViewIndex = _homeViewIndex;

-(id) init
{
	if (self = [super init]) {
        _categoryDict = [[NSMutableDictionary alloc] init];
        _categoryForTypeArray = [[NSMutableArray alloc] init];
        _typeDict = [[NSMutableDictionary alloc] init];
        _typeArray = [[NSMutableArray alloc] init];
        _storeDict = [[NSMutableDictionary alloc] init];
        _brandDict = [[NSMutableDictionary alloc] init];
        
        _productPages = [[NSMutableDictionary alloc] init];
        _productArray = [[NSMutableArray alloc] init];
        
        _favoriteProductArray = [[NSMutableArray alloc] init];
        _favoriteProductPages = [[NSMutableDictionary alloc] init];
        
        _featureProductList = [[NSMutableArray alloc] init];
        _featureProductArray = [[NSMutableArray alloc] init];
        _featureProductPages = [[NSMutableDictionary alloc] init];
        
        _salesProductArray = [[NSMutableArray alloc] init];
        _salesProductPages = [[NSMutableDictionary alloc] init];
        
        _filteredProductArray = [[NSMutableArray alloc] init];
        _filteredProductPages = [[NSMutableDictionary alloc] init];
	} 
	return self;	
}

-(NSMutableDictionary*) categoryDict
{
    return _categoryDict;
}

-(NSMutableDictionary*) categoryForTypeDict
{
    return _categoryForTypeDict;
}

-(NSMutableArray*) categoryForTypeArray
{
    return _categoryForTypeArray;
}

-(NSMutableDictionary*) typeDict
{
    return _typeDict;
}

-(NSMutableArray*) typeArray
{
    return _typeArray;
}

-(NSMutableDictionary*) storeDict
{
    return _storeDict;
}

-(NSMutableDictionary*) brandDict
{
    return _brandDict;
}

-(NSMutableDictionary*) productPages
{
    return _productPages;
}

-(NSMutableArray*) productArray
{
    return _productArray;
}

-(NSMutableArray*) favouriteProductArray
{
    return _favoriteProductArray;
}

-(NSMutableArray*) featureProductArray
{
    return _featureProductArray;
}

-(NSMutableArray*) featureProductList
{
    return _featureProductList;
}

-(NSMutableArray*) salesProductArray
{
    return _salesProductArray;
}

-(NSMutableArray*) filteredProductArray
{
    return _filteredProductArray;
}

-(void)dealloc
{
    [_categoryDict release];
    [_categoryForTypeDict release];
    [_categoryForTypeArray release];
    [_typeDict release];
    [_storeDict release];
    [_brandDict release];
    [_productPages release];
    [_productArray release];
    [_favoriteProductArray release];
    [_featureProductArray release];
    [_featureProductList release];
    [_salesProductArray release];
    [super dealloc];
}

-(void) clearCategory
{
    //[_categoryDict release];
    //_categoryDict = [[NSMutableDictionary alloc] init];
    [_categoryForTypeDict release];
    _categoryForTypeDict = [[NSMutableDictionary alloc] init];
    [_categoryForTypeArray release];
    _categoryForTypeArray = [[NSMutableArray alloc] init];
}

-(void) clearProducts
{
    [_productPages release];
    _productPages = [[NSMutableDictionary alloc] init];
    [_productArray release];
    _productArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 1000; i++) {
        [_productArray addObject:[[Product alloc] init]];
    }
}

-(void) clearSalesProducts
{
    [_salesProductArray release];
    _salesProductArray = [[NSMutableArray alloc] init];
    [_salesProductPages release];
    _salesProductPages = [[NSMutableDictionary alloc] init];
}

-(void) clearFavouriteProduct
{
    [_favoriteProductArray release];
    _favoriteProductArray = [[NSMutableArray alloc] init];
    [_favoriteProductPages release];
    _favoriteProductPages = [[NSMutableDictionary alloc] init];
}

-(void) shuffleFeatureProductList
{
    NSUInteger count = [_featureProductList count];
    for (NSUInteger i = 0; i < count; i++) {
        NSUInteger nElement = count - 1;
        NSUInteger n = (random() % nElement) + 1;
        [_featureProductList exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

-(void) clearFilteredProducts
{
    [_filteredProductArray release];
    _filteredProductArray = [[NSMutableArray alloc] init];
    [_filteredProductPages release];
    _filteredProductPages = [[NSMutableDictionary alloc] init];
}

-(void) clearTypies
{
    [_typeDict release];
    _typeDict = [[NSMutableDictionary alloc] init];
    [_typeArray release];
    _typeArray = [[NSMutableArray alloc] init];
}

#pragma mark-
#pragma mark loadTypes
-(void) loadTypes{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotTypes: byRequest:)];
	[req call:TYPES_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void)gotTypes:(NSData *)data byRequest:(HttpRequest *)req
{
	//NSLog(@"types: %s", data.bytes);
    TypeXMLHandler* handler = [[TypeXMLHandler alloc] initWithTypeDict:_typeDict andArray:_typeArray];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedType)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedType
{
    if (_viewIndex == 1)
        [_delegate didFinishParsingType:_typeDict andArray:_typeArray];
}

#pragma mark -
#pragma mark loadCategories
-(void) loadCategories{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotCategories: byRequest:)];
	[req call:CATEGORIES_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void)gotCategories: (NSData*)data byRequest:(HttpRequest*)req
{
	//NSLog(@"categories: %s", data.bytes);
    CategoryXMLHandler* handler = [[CategoryXMLHandler alloc] initWithCategoryDict:_categoryDict andCategoryArray:nil];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedCategory)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}

-(void) didParsedCategory
{
}

-(void) loadCategoriesForType:(Type*)c_type
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotCategoriesForType: byRequest:)];
	[req call:CATEGORIES_URL params:[NSDictionary dictionaryWithObject:[c_type tid] forKey:@"type"]];
	[req release];
}

-(void)gotCategoriesForType: (NSData*)data byRequest:(HttpRequest*)req
{
	//NSLog(@"categories: %s", data.bytes);
    CategoryXMLHandler* handler = [[CategoryXMLHandler alloc] initWithCategoryDict:_categoryForTypeDict andCategoryArray:_categoryForTypeArray];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedCategoryForType)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}

-(void) didParsedCategoryForType
{
    if (_viewIndex == 6) {
        [_delegate didFinishParsingCategory:_categoryDict andArray:_categoryForTypeArray];
    }
}

#pragma mark-
#pragma mark loadStore
-(void) loadStores{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotStores: byRequest:)];
	[req call:STORE_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void)gotStores:(NSData *)data byRequest:(HttpRequest *)req
{
	//NSLog(@"stores: %s", data.bytes);
    StoreXMLHandler* handler = [[StoreXMLHandler alloc] initWithStoreDict:_storeDict];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedStore)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedStore
{
}

#pragma mark-
#pragma mark loadBrands
-(void) loadBrands{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotBrands: byRequest:)];
	[req call:BRAND_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void)gotBrands:(NSData *)data byRequest:(HttpRequest *)req
{
	//NSLog(@"brands: %s", data.bytes);
    BrandXMLHandler* handler = [[BrandXMLHandler alloc] initWithBrandDict:_brandDict];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedBrand)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedBrand
{
}

#pragma mark-
#pragma mark loadProducts
-(void) loadProducts{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotProducts: byRequest:)];
	[req call:PRODUCT_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void) loadProductsForType:(Type*)c_type forCatetory:(Category*)c_category{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotProducts: byRequest:)];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[c_type tid] forKey:@"type"];
    [dictionary setObject:[c_category cid] forKey:@"category"];
	[req call:PRODUCT_URL params:dictionary];
    [dictionary release];
	[req release];
}

-(void) loadProductsForType:(Type*)c_type forCatetory:(Category*)c_category from:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotProducts: byRequest:)];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    if (c_type != nil)
        [dictionary setObject:[c_type tid] forKey:@"type"];
    if (c_category != nil)
        [dictionary setObject:[c_category cid] forKey:@"category"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", start] forKey:@"start"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", end] forKey:@"end"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", page] forKey:@"page"];
	[req call:PRODUCT_URL params:dictionary];
    [dictionary release];
	[req release];
}

-(void)gotProducts:(NSData *)data byRequest:(HttpRequest *)req
{
	//NSLog(@"products: %s", data.bytes);
    ProductXMLHandler* handler = [[ProductXMLHandler alloc] initWithProductDict:_productPages productArray:_productArray andApplication:(ApplicationService*)self];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedProduct)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}

-(void) didParsedProduct
{
    if (_viewIndex == 7) {
        [_delegate2 didFinishParsingProduct:_productArray withPageDict:_productPages withTotalProducts:_totalProduct fromPosition:_startPosition toPosition:_endPosition inPage:_pagePosition];
    }
    if (_viewIndex == 9) {
        [_delegate4 didFinishParsingProduct:_productArray withPageDict:_productPages withTotalProducts:_totalProduct fromPosition:_startPosition toPosition:_endPosition inPage:_pagePosition];
    }
}

-(void) loadProductsForProductIds:(NSString *)ids from:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotFavouriteProducts: byRequest:)];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:ids forKey:@"ids"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", start] forKey:@"start"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", end] forKey:@"end"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", page] forKey:@"page"];
    [req call:PRODUCT_URL params:dictionary];
    [dictionary release];
	[req release];
}

-(void)gotFavouriteProducts:(NSData *)data byRequest:(HttpRequest *)req
{
	//NSLog(@"products: %s", data.bytes);
    ProductXMLHandler* handler = [[ProductXMLHandler alloc] initWithProductDict:_favoriteProductPages productArray:_favoriteProductArray andApplication:(ApplicationService*)self];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedFavouriteProduct)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}

-(void) didParsedFavouriteProduct
{
    if (_viewIndex == 3) {
        [_delegate didFinishParsingFavouriteProduct:_favoriteProductArray withPageDict:_favoriteProductPages withTotalProducts:_totalProduct fromPosition:_startPosition toPosition:_endPosition inPage:_pagePosition];
    }
}

-(void) loadFeatureProductsList
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotFeatureProductsList: byRequest:)];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@"1" forKey:@"premium"];
    [dictionary setObject:@"1" forKey:@"random"];
	[req call:PRODUCT_URL params:dictionary];
    [dictionary release];
	[req release];
}

-(void)gotFeatureProductsList:(NSData *)data byRequest:(HttpRequest *)req
{
	//NSLog(@"products: %s", data.bytes);
    ProductXMLHandler* handler = [[ProductXMLHandler alloc] initWithProductDict:_productPages productArray:_featureProductList andApplication:(ApplicationService*)self];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedFeatureProductsList)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}

-(void) didParsedFeatureProductsList
{
}

-(void) loadProductsOfFeatureShopFrom:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotFeatureProducts: byRequest:)];
    NSMutableString* strIds = [[NSMutableString alloc] initWithString:@""];
    NSInteger count = [_featureProductList count];
    NSInteger trueEnd = end > count ? count-1 : end;
    for (NSInteger i = start; i <= trueEnd; i++) {
        Product *product = [_featureProductList objectAtIndex:i];
        if (i == trueEnd)
            [strIds appendString:[NSString stringWithFormat:@"%@", [product pid]]];
        else
            [strIds appendString:[NSString stringWithFormat:@"%@,", [product pid]]];
    }
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:strIds forKey:@"ids"];
    if (page == -1) {
        [dictionary setObject:[NSString stringWithFormat:@"%i", start] forKey:@"start"];
        [dictionary setObject:[NSString stringWithFormat:@"%i", end] forKey:@"end"];
    }
    else{
        [dictionary setObject:@"0" forKey:@"start"];
        [dictionary setObject:@"7" forKey:@"end"];
        [dictionary setObject:[NSString stringWithFormat:@"%i", page] forKey:@"page"];
    }
    [req call:PRODUCT_URL params:dictionary];
	[req release];
    [dictionary release];
    [strIds release];
}

-(void) gotFeatureProducts: (NSData*)data byRequest:(HttpRequest*)req
{
    //NSLog(@"products: %s", data.bytes);
    ProductXMLHandler* handler = [[ProductXMLHandler alloc] initWithProductDict:_featureProductPages productArray:_featureProductArray andApplication:(ApplicationService*)self];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedFeatureProduct)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}

-(void) didParsedFeatureProduct
{
    if (_viewIndex == 2) {
        [_delegate didFinishParsingFeatureProduct:_featureProductArray withPageDict:_featureProductPages withTotalProducts:_totalProduct fromPosition:_startPosition toPosition:_endPosition inPage:_pagePosition];
    }
}

-(void) loadProductsOnSalesFrom:(NSInteger)start to:(NSInteger)end inPage:(NSInteger)page
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self
													   andAction:@selector(gotSalesProducts: byRequest:)];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@"1" forKey:@"sale"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", start] forKey:@"start"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", end] forKey:@"end"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", page] forKey:@"page"];
    [req call:PRODUCT_URL params:dictionary];
    [dictionary release];
	[req release];
}

-(void) gotSalesProducts:(NSData *)data byRequest:(HttpRequest *)req
{
    //NSLog(@"products: %s", data.bytes);
    ProductXMLHandler* handler = [[ProductXMLHandler alloc] initWithProductDict:_salesProductPages productArray:_salesProductArray andApplication:(ApplicationService*)self];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedSalesProducts)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}

-(void) didParsedSalesProducts
{
    if (_viewIndex == 4) {
        _totalSalesProduct = _totalProduct;
        [_delegate didFinishParsingSalesProduct:_salesProductArray withPageDict:_salesProductPages withTotalProducts:_totalProduct fromPosition:_startPosition toPosition:_endPosition inPage:_pagePosition];
    } 
}

-(void) loadFilteredProductFrom:(NSInteger)start
                             to:(NSInteger)end
                         inPage:(NSInteger)page
                    hasKeywords:(NSString*)keywords
                       hasTypes:(NSString *)typies
                      hasBrands:(NSString *)brands
                       ofStores:(NSString *)stores
                   inCategories:(NSString *)categories
                    hasTopPrice:(NSString *)topPrice
                 hasBottomPrice:(NSString *)bottomPrice
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self
													   andAction:@selector(gotFilteredProduct: byRequest:)];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:keywords forKey:@"keywords"];
    if (![typies isEqualToString:@""])
        [dictionary setObject:typies forKey:@"type"];
    if (![brands isEqualToString:@""])
        [dictionary setObject:brands forKey:@"brand"];
    if (![stores isEqualToString:@""])   
        [dictionary setObject:stores forKey:@"store"];
    if (![categories isEqualToString:@""])
        [dictionary setObject:categories forKey:@"category"];
    if (![topPrice isEqualToString:@""])
        [dictionary setObject:topPrice forKey:@"topPrice"];
    if (![bottomPrice isEqualToString:@""])
        [dictionary setObject:bottomPrice forKey:@"botPrice"];
    
    [dictionary setObject:[NSString stringWithFormat:@"%i", start] forKey:@"start"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", end] forKey:@"end"];
    [dictionary setObject:[NSString stringWithFormat:@"%i", page] forKey:@"page"];
    [req call:PRODUCT_URL params:dictionary];
    [dictionary release];
	[req release];
}

-(void) gotFilteredProduct:(NSData *)data byRequest:(HttpRequest *)req
{
    //NSLog(@"products: %s", data.bytes);
    ProductXMLHandler* handler = [[ProductXMLHandler alloc] initWithProductDict:_filteredProductPages productArray:_filteredProductArray andApplication:(ApplicationService*)self];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedFilteredProduct)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}

-(void) didParsedFilteredProduct
{
    if (_viewIndex == 8) {
        [_delegate3 didFinishParsingFilterProduct:_filteredProductArray withPageDict:_filteredProductPages withTotalProducts:_totalProduct fromPosition:_startPosition toPosition:_endPosition inPage:_pagePosition];
    }
}

@end
