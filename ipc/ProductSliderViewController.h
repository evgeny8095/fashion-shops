//
//  ProductSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigProductSliderViewController.h"
#import "asyncimageview.h"
#import "MyPopOverView.h"

@interface ProductSliderViewController : UIViewController <UIScrollViewDelegate, BigProductSliderViewControllerDelegate, UINavigationControllerDelegate>{
    UIScrollView *productSmallSlider;
    NSInteger totalItem;
    NSMutableArray *buttons;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
    NSArray *productArray;
    NSArray *imageArray;
    NSArray *imageURL;
    NSString *baseURL;
    NSInteger sex;
    NSInteger sub;
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
}

@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger sub;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *myPopOver;

- (IBAction)gotoProductDetails:(id)sender;
- (void)filterProductList:(id)sender;

@end
