//
//  ProductSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigProductSliderViewController.h"

@interface ProductSliderViewController : UIViewController <BigProductSliderViewControllerDelegate>{
    UIScrollView *productSmallSlider;
    UIScrollView *productBigSlider;
    // UIScrollView *productDetailSlider;
    NSInteger totalItem;
}
-(IBAction)swapViewSmallToBig:(id)sender;
-(IBAction)swapViewBigToSmall:(id)sender;
- (IBAction)gotoProductDetails:(id)sender;

@end
