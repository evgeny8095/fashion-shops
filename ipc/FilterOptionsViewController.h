//
//  FilterOptionsViewController.h
//  ipc
//
//  Created by Mahmood1 on 10/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterDetailsViewController.h"
#import "ipcGlobal.h"


@interface FilterOptionsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITableView *optionTable;
    NSArray *options;
    NSMutableArray *types;
    NSMutableArray *brands;
    NSMutableArray *categories;
    NSMutableArray *stores;
}

- (id)initWithFilterType:(NSMutableArray*)c_types Brand:(NSMutableArray*)c_brands Store:(NSMutableArray*)c_stores Categories:(NSMutableArray*)c_categories;

@end
