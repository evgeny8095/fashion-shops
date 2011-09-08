//
//  TypeXMLHandler.h
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "ipcGlobal.h"


@interface TypeXMLHandler : BaseXMLHandler {
    Type* _currentObject;
    NSNumber* _count;
    NSMutableDictionary* _typeDict;
}

-(id) initWithTypeDict:(NSMutableDictionary*)typeDict;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
