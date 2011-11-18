//
//  ProductXMLHandler.h
//  ipc
//
//  Created on 9/8/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "ipcGlobal.h"


@interface ProductXMLHandler : BaseXMLHandler {
    Product* _currentObject;
    NSInteger totalProduct;
    NSInteger startPosition;
    NSInteger endPosition;
    NSInteger pagePosition;
    NSMutableDictionary* _productPages;
    NSMutableArray* _productArray;
    NSMutableArray* _currentProducts;
    NSMutableDictionary* _typeDict;
    NSMutableDictionary* _categoryDict;
    NSDictionary* c_typeDict;
    NSDictionary* c_categoryDict;
    NSDictionary* c_storeDict;
    NSDictionary* c_brandDict;
    ApplicationService* c_appSrv;
    NSInteger index;
}

-(id) initWithProductDict:(NSMutableDictionary*)productPages productArray:(NSMutableArray*)productArray andApplication:(ApplicationService*)AppSer;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
