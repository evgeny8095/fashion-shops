//
//  ProductsDetailsSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductsDetailsSliderViewControllerDelegate <NSObject>

-(void) finishSomething:(UIViewController*)sender withURL:(NSString *)url;
-(void) changeMode:(UIViewController*)sender withMode:(BOOL)modeToChange;

@end

@interface ProductsDetailsSliderViewController : UIViewController{
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
    UILabel *labelSize;
    UILabel *labelDesc;
    UILabel *labelScreenShot;
    UIView *backCover;
    NSString *url;
    NSInteger cPosition;
    id<ProductsDetailsSliderViewControllerDelegate> delegate;
    BOOL mode;
    NSURLConnection* connection;
    NSMutableData* data;
    UIActivityIndicatorView *loadingView;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *imageStr;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) id<ProductsDetailsSliderViewControllerDelegate> delegate;

- (id)initWithImage:(NSString *)strImg hasName:(NSString *)strName hasPrice:(NSString *)strPrice hasDesc:(NSString *)strDesc inPosition:(NSInteger)position withMode:(BOOL)cmode;
- (void)revealDetails:(id)sender;
- (void)changeViewMode:(BOOL)cmode;
- (void)buy:(id)sender;
- (IBAction)gotoShop:(id)sender;
- (void)labelHiddenChage:(BOOL)cmode;

@end
