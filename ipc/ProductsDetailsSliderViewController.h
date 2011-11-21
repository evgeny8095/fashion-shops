//
//  ProductsDetailsSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SSLineView.h"
#import "SSGradientView.h"
#import "InfoCollectorViewController.h"
#import "ipcGlobal.h"

@protocol ProductsDetailsSliderViewControllerDelegate <NSObject>

-(void) finishSomething:(UIViewController*)sender withURL:(NSString *)url;
-(void) changeMode:(UIViewController*)sender withMode:(BOOL)modeToChange;

@end

@interface ProductsDetailsSliderViewController : UIViewController<InfoCollectorViewControllerDelegate,UIAlertViewDelegate>{
    NSString *imageStr;
    UIImage *image;
    UIButton *button;
    NSString *name;
    NSString *price;
    NSString *desc;
    UITextView *descText;
    UIButton *buy;
    UIButton *like;
    UILabel *labelBrand;
    UILabel *labelStore;
    UILabel *labelName;
    UILabel *labelPrice;
    UILabel *labelDesc;
    UILabel *labelScreenShot;
    UIView *backCover;
    NSString *url;
    NSInteger cPosition;
    NSInteger total;
    id<ProductsDetailsSliderViewControllerDelegate> delegate;
    BOOL mode;
    NSURLConnection* connection;
    NSMutableData* data;
    UIActivityIndicatorView *loadingView;
    Product* _product;
    NSInteger _type;
    NSInteger _category;
    SSGradientView *more;
    SSLineView *lineView;
    SSGradientView *gradientView;
    UIPopoverController *popoverController;
    InfoCollectorViewController *infoCollectorViewController;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *imageStr;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) id<ProductsDetailsSliderViewControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger category;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) InfoCollectorViewController *infoCollectorViewController;

- (id)initwithProduct:(Product*)c_product inPosition:(NSInteger)position ofTotal:(NSInteger)c_total withMode:(BOOL)cmode;
- (id)initWithImage:(NSString *)strImg hasName:(NSString *)strName hasPrice:(NSString *)strPrice hasDesc:(NSString *)strDesc inPosition:(NSInteger)position withMode:(BOOL)cmode;
- (void)revealDetails:(id)sender;
- (void)changeViewMode:(BOOL)cmode;
- (void)buy:(id)sender;
- (IBAction)gotoShop:(id)sender;
- (void)labelHiddenChage:(BOOL)cmode;

@end