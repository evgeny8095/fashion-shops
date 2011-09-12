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
    NSString *title;
    UIScrollView *productSmallSlider;
    NSInteger totalItem;
    NSMutableArray *buttons;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
    NSArray *productArray;
    NSArray *imageArray;
    NSArray *imageURL;
    NSString *baseURL;
    NSInteger _type;
    NSInteger _category;
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
}

@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *myPopOver;
@property (nonatomic, copy) NSString *title;

- (IBAction)gotoProductDetails:(id)sender;
- (void)filterProductList:(id)sender;

@end
