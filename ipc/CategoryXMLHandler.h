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
    NSMutableDictionary* _categoryDict;
}

-(id) initWithCategoryDict:(NSMutableDictionary*)categoryDict;

@end
