//
//  FilterDetailsViewController.h
//  ipc
//
//  Created by Mahmood1 on 10/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ipcGlobal.h"


@interface FilterDetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSArray *optionArray;
    NSDictionary *optionDictionary;
    NSMutableArray *convertedArray;
    NSMutableArray *chossenArray;
}

- (id)initWithArray:(NSArray*)array forArray:(NSMutableArray*)ref_array;
- (id)initWithDictionary:(NSDictionary*)dictionary forArray:(NSMutableArray*)ref_array;

@end
