//
//  FavouriteViewController.h
//  ipc
//
//  Created on 9/21/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"
#import "ipcGlobal.h"


@interface FavouriteViewController : UIViewController {
    //NSManagedObjectContext *managedObjectContext;
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    NSMutableArray *productArray;
    NSString* favouriteProductsString;
    UILabel* noProductLabel;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;

@end
