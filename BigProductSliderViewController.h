//
//  BigProductSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigProductSliderViewController : UIViewController <UIScrollViewDelegate>{
    UIScrollView *productBigSlider;
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    NSArray *productArray;
    NSArray *imageArray;
    BOOL pageControlUsed;
    NSInteger numberOfPages;
    NSInteger cpage;
}

@property (nonatomic, retain) IBOutlet UIScrollView *productBigSlider;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

@property (nonatomic, retain) NSMutableArray *viewControllers;

- (void)revealDetails:(id)sender;
- (void)gotoDetails:(id)sender;
- (IBAction)changePage:(id)sender;
- (id)initWithPage:(int)page;
@end