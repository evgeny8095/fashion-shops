//
//  FilterDetailsViewController.h
//  ipc
//
//  Created by Mahmood1 on 10/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FilterDetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSArray *optionArray;
    NSDictionary *optionDictionary;
}

- (id)initWithArray:(NSArray*)array;
- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
