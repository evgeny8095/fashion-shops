//
//  MyPopOverView.h
//  iPadTutorial
//
//  Created by Jannis Nikoy on 4/3/10.
//  Copyright 2010 Jannis Nikoy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyPopOverView : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UITableView *myTable;
    NSArray *options;
}

@property (nonatomic, retain) IBOutlet UITableView *myTable;

@end
