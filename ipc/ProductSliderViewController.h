//
//  ProductSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigProductSliderViewController.h"

@interface ProductSliderViewController : UIViewController <UIScrollViewDelegate, BigProductSliderViewControllerDelegate>{
    UIScrollView *productSmallSlider;
    UIScrollView *productBigSlider;
    // UIScrollView *productDetailSlider;
    NSInteger totalItem;
    NSMutableArray *buttons;
    UIPageControl *pageControl;
    BOOL pageControlUsed;
    NSArray *imageArray;
}
-(IBAction)swapViewSmallToBig:(id)sender;
-(IBAction)swapViewBigToSmall:(id)sender;
- (IBAction)gotoProductDetails:(id)sender;
@property (nonatomic, retain) NSMutableArray *buttons;

@end
