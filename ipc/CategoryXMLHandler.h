//
//  CategoryXMLHandler.h
//  ipc
//
//  Created on 9/6/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "ipcGlobal.h"


@interface CategoryXMLHandler : BaseXMLHandler {
    Category* _currentObject;
    NSNumber* _count;
    NSMutableDictionary* _categoryDict;
    NSMutableArray* _categoryArray;
}

-(id) initWithCategoryDict:(NSMutableDictionary*)categoryDict andCategoryArray:(NSMutableArray*)categoryArray;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
