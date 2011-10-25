//
//  FilterOptionsViewController.h
//  ipc
//
//  Created by Mahmood1 on 10/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterDetailsViewController.h"


@interface FilterOptionsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITableView *optionTable;
    NSArray *options;
}



@end
