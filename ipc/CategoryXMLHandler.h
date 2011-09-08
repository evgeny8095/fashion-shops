//
//  CategoryXMLHandler.h
//  ipc
//
//  Created by Mahmood1 on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseXMLHandler.h"
#import "ipcGlobal.h"


@interface CategoryXMLHandler : BaseXMLHandler {
    Category* _currentObject;
    NSNumber* _count;
    NSString* _name;
    NSString* _description;
    NSString* _image;
    NSMutableDictionary* _categoryDict;
}

-(id) initWithCategoryDict:(NSMutableDictionary*)categoryDict;
-(void) afterElementStarting:(NSString *)elementName withAttributes:(NSDictionary *)attributeDict;
-(void) afterElementEnding:(NSString *)elementName;
-(NSString*) getWrappedRootNode;

@end
