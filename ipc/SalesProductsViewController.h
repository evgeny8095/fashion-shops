//
//  SalesProductsViewController.h
//  ipc
//
//  Created on 9/30/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"
#import "ProductSliderViewController.h"
#import "ipcGlobal.h"


@interface SalesProductsViewController : UIViewController {
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    NSMutableArray *productArray;
    UILabel *noProductLabel;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;

@end
