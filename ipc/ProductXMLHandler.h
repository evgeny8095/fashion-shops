//
//  ProductXMLHandler.h
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "ipcGlobal.h"


@interface ProductXMLHandler : BaseXMLHandler {
    Product* _currentObject;
    NSInteger totalProduct;
    NSInteger startPosition;
    NSInteger endPosition;
    NSMutableDictionary* _productDict;
    NSMutableArray* _productArray;
    NSMutableDictionary* _typeDict;
    NSMutableDictionary* _categoryDict;
    NSDictionary* c_typeDict;
    NSDictionary* c_categoryDict;
    NSDictionary* c_storeDict;
    NSDictionary* c_brandDict;
    ApplicationService* c_appSrv;
}

-(id) initWithProductDict:(NSMutableDictionary*)productDict productArray:(NSMutableArray*)productArray andApplication:(ApplicationService*)AppSer;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end