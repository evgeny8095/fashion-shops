//
//  ProductsDetailsSliderViewController.h
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsDetailsSliderViewController : UIViewController{
    UIImage *image;
    UIButton *button;
    NSString *name;
    NSString *price;
    NSString *desc;
    UIButton *buy;
    UIButton *like;
    UILabel *labelName;
    UILabel *labelPrice;
    UILabel *labelDesc;
    NSString *url;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *desc;

- (id)initWithImage:(UIImage *)imagex hasName:(NSString *)strName hasPrice:(NSString *)strPrice hasDesc:(NSString *)strDesc;
- (void)revealDetails:(id)sender;
- (void)buy:(id)sender;
- (IBAction)gotoShop:(id)sender;

@end
