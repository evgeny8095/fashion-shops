//
//  FeatureProductsViewController.h
//  ipc
//
//  Created on 9/29/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSliderViewController.h"
#import "MyPopOverView.h"
#import "ipcGlobal.h"


@interface FeatureProductsViewController : UIViewController {
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    NSMutableArray *productArray;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;

@end
