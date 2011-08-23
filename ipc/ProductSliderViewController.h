//
//  ProductSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSliderViewController : UIViewController{
    UIScrollView *productSmallSlider;
    UIScrollView *productBigSlider;
    // UIScrollView *productDetailSlider;
}
-(IBAction)swapViewSmallToBig:(id)sender;
-(IBAction)swapViewBigToSmall:(id)sender;
- (IBAction)gotoProductDetails:(id)sender;

@end
