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
#import "ipcGlobal.h"

@interface ProductSliderViewController : UIViewController <UIScrollViewDelegate, BigProductSliderViewControllerDelegate, UINavigationControllerDelegate, ApplicationServiceDelegate>{
    NSString *title;
    IBOutlet UIScrollView *productScrollView;
    NSInteger totalItem;
    NSInteger totalPages;
    NSMutableArray *buttons;
    NSMutableArray *labels;
    NSMutableArray *secondLabels;
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
    NSDictionary* _productDict;
    NSMutableArray* _productArray;
    Type* c_type;
    Category* c_category;
    NSMutableDictionary* loadedPage;
    NSString* loadFrom;
    NSString* ids;
    UILabel *infomationLabel;
}

@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) NSMutableArray *labels;
@property (nonatomic, retain) NSMutableArray *secondLabels;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *myPopOver;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) IBOutlet UIScrollView *productScrollView;
@property (nonatomic, retain) Type* c_type;
@property (nonatomic, retain) Category* c_category;

- (id)initWithProductArray:(NSMutableArray*)fproductArray;
- (id)initForFavoriteProducts:(NSString*)c_ids;
- (id)initForFeatureProducts;
- (id)initForSalesProducts;
- (IBAction)gotoProductDetails:(id)sender;
- (void)filterProductList:(id)sender;
- (void) didFinishParsing:(NSMutableArray*)c_productArray withTotalProduct:(NSInteger)total fromPostion:(NSInteger)start toPosition:(NSInteger)end;
- (void)loadPageWithProductsStartAt:(NSInteger)start EndAt:(NSInteger)end;

@end
