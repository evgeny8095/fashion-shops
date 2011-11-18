//
//  TypeXMLHandler.h
//  ipc
//
//  Created on 9/8/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "ipcGlobal.h"


@interface TypeXMLHandler : BaseXMLHandler {
    Type* _currentObject;
    NSNumber* _count;
    NSMutableDictionary* _typeDict;
    NSMutableArray* _typeArray;
}

-(id) initWithTypeDict:(NSMutableDictionary*)typeDict andArray:(NSMutableArray*)typeArray;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
