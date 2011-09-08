//
//  StoreXMLHandler.h
//  ipc
//
//  Created by Mahmood1 on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "ipcGlobal.h"


@interface StoreXMLHandler : BaseXMLHandler {    
    Store* _currentObject;
    NSNumber* _count;
    NSMutableDictionary* _storeDict;
}

-(id) initWithStoreDict:(NSMutableDictionary*)storeDict;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
