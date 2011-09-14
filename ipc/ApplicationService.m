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

@implementation ApplicationService
@synthesize delegate = _delegate;

-(id) init
{
	if (self = [super init]) {
        _categoryDict = [[NSMutableDictionary alloc] init];
        _typeDict = [[NSMutableDictionary alloc] init];
        _storeDict = [[NSMutableDictionary alloc] init];
        _brandDict = [[NSMutableDictionary alloc] init];
        _productDict = [[NSMutableDictionary alloc] init];
        _status = NO;
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

-(NSMutableDictionary*) typeDict
{
    return _typeDict;
}

-(NSMutableDictionary*) storeDict
{
    return _storeDict;
}

-(NSMutableDictionary*) brandDict
{
    return _brandDict;
}

-(NSMutableDictionary*) productDict
{
    return _productDict;
}

-(BOOL) finishParsing
{
    return _status;
}

#pragma mark -
#pragma mark loadCategories
-(void) loadCategories{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotCategories: byRequest:)];
	[req call:CATEGORIES_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void) loadCategoriesForType:(Type*)c_type
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotCategories: byRequest:)];
	[req call:CATEGORIES_URL params:[NSDictionary dictionaryWithObject:[c_type tid] forKey:@"type"]];
	[req release];
}

-(void)gotCategories: (NSData*)data byRequest:(HttpRequest*)req
{
	NSLog(@"categories: %s", data.bytes);
    CategoryXMLHandler* handler = [[CategoryXMLHandler alloc] initWithCategoryDict:_categoryDict];
    [handler setEndDocumentTarget:self andAction:@selector(didParsedCategory)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedCategory
{
    [_delegate didFinishParsingCategory:_categoryDict];
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
	NSLog(@"types: %s", data.bytes);
    TypeXMLHandler* handler = [[TypeXMLHandler alloc] initWithTypeDict:_typeDict];
    //[handler setEndDocumentTarget:self andAction:@selector(didParsedType)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedType
{
    //end point
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
	NSLog(@"stores: %s", data.bytes);
    StoreXMLHandler* handler = [[StoreXMLHandler alloc] initWithStoreDict:_storeDict];
    //[handler setEndDocumentTarget:self andAction:@selector(didParsedStore)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedStore
{
    //end point
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
	NSLog(@"brands: %s", data.bytes);
    BrandXMLHandler* handler = [[BrandXMLHandler alloc] initWithBrandDict:_brandDict];
    //[handler setEndDocumentTarget:self andAction:@selector(didParsedBrand)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedBrand
{
    //end point
}

#pragma mark-
#pragma mark loadProducts
-(void) loadProducts{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self 
													   andAction:@selector(gotProducts: byRequest:)];
	[req call:PRODUCT_URL params:[NSDictionary dictionary]];
	[req release];
}

-(void)gotProducts:(NSData *)data byRequest:(HttpRequest *)req
{
	NSLog(@"products: %s", data.bytes);
    ProductXMLHandler* handler = [[ProductXMLHandler alloc] initWithProductDict:_productDict andApplication:(ApplicationService*)self];
    //[handler setEndDocumentTarget:self andAction:@selector(didParsedProduct)];
	NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
	parser.delegate = handler;
	[parser parse];
	[handler release];
}
-(void) didParsedProduct
{
    //end point
}

@end
