//
//  BigProductSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsDetailsSliderViewController.h"
#import "ipcGlobal.h"

@protocol BigProductSliderViewControllerDelegate <NSObject>

- (void) finishSomething:(UIViewController *)sender withItemNumber:(NSInteger)number;

@end

@interface BigProductSliderViewController : UIViewController <UIScrollViewDelegate, ProductsDetailsSliderViewControllerDelegate>{
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    NSArray *productArrayx;
    NSArray *imageArray;
    NSArray *imageURL;
    NSString *baseURL;
    BOOL pageControlUsed;
    NSInteger numberOfPages;
    NSInteger cpage;
    BOOL viewMode;
    id<BigProductSliderViewControllerDelegate> delegate;
    NSInteger _type;
    NSInteger _category;
    NSInteger item;
    NSMutableArray* _productArray;
    UIBarButtonItem *favBarButton;
    UIBarButtonItem *unFavBarButton;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) id<BigProductSliderViewControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, assign) NSInteger item;

- (void)revealDetails:(id)sender;
- (void)gotoDetails:(id)sender;
- (IBAction)changePage:(id)sender;
- (id)initWithPage:(int)page andProducts:(NSMutableArray*)products withTotal:(NSInteger)total;
- (void)favAction:(id)sender;
- (void)unFavAction:(id)sender;
- (void)checkFavProduct:(Product*)product;

@end