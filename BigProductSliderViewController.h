//
//  BigProductSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsDetailsSliderViewController.h"

@protocol BigProductSliderViewControllerDelegate <NSObject>

- (void) finishSomething:(UIViewController *)sender withItemNumber:(NSInteger)number;

@end

@interface BigProductSliderViewController : UIViewController <UIScrollViewDelegate, ProductsDetailsSliderViewControllerDelegate>{
    UIScrollView *productBigSlider;
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    NSArray *productArray;
    NSArray *imageArray;
    NSArray *imageURL;
    BOOL pageControlUsed;
    NSInteger numberOfPages;
    NSInteger cpage;
    BOOL viewMode;
    id<BigProductSliderViewControllerDelegate> delegate;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *productBigSlider;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) id<BigProductSliderViewControllerDelegate> delegate;

- (void)revealDetails:(id)sender;
- (void)gotoDetails:(id)sender;
- (IBAction)changePage:(id)sender;
- (id)initWithPage:(int)page;
@end