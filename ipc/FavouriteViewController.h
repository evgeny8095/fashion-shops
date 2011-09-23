//
//  FavouriteViewController.h
//  ipc
//
//  Created by Mahmood1 on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"
#import "ipcGlobal.h"


@interface FavouriteViewController : UIViewController {
    NSManagedObjectContext *managedObjectContext;
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    NSMutableArray *testArray;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) NSMutableArray *testArray;

@end
