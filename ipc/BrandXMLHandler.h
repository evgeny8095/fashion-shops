//
//  BrandXMLHandler.h
//  ipc
//
//  Created on 9/8/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "ipcGlobal.h"

@interface BrandXMLHandler : BaseXMLHandler {
    Brand* _currentObject;
    NSNumber* _count;
    NSMutableDictionary* _brandDict;
}

-(id) initWithBrandDict:(NSMutableDictionary*)brandDict;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
