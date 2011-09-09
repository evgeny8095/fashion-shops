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
    NSNumber* _count;
    NSMutableDictionary* _productDict;
    NSMutableDictionary* _typeDict;
    NSMutableDictionary* _categoryDict;
    NSDictionary* c_typeDict;
    NSDictionary* c_categoryDict;
    NSDictionary* c_storeDict;
    NSDictionary* c_brandDict;
}

-(id) initWithProductDict:(NSMutableDictionary*)productDict andApplication:(ApplicationService*)AppSer;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
