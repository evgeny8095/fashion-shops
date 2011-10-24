//
//  FilterViewController.h
//  ipc
//
//  Created by Mahmood1 on 10/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"


@interface FilterViewController : UIViewController {
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    NSMutableArray *productArray;
    NSString *typies;
    NSString *brands;
    NSString *stores;
    NSString *categories;
    NSString *topPrice;
    NSString *bottomPrice;
    
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;

-(id) initWithTypies:(NSString*)f_typies
           andBrands:(NSString*)f_brands
           andStores:(NSString*)f_stores
       andCategories:(NSString*)f_categories
         hasTopPrice:(NSString*)f_topPrice
      hasBottomPrice:(NSString*)f_bottomPrice;
@end
