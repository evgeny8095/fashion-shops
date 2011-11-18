//
//  FeatureSettingViewController.h
//  ipc
//
//  Created on 11/4/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingMasterViewController.h"

@interface FeatureSettingViewController : UIViewController <SubstitutableDetailViewController> {
    UIToolbar *toolbar;
    UILabel *titleLabel;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UILabel *numberFav;
@property (nonatomic, retain) IBOutlet UILabel *numberPur;
@property (nonatomic, retain) IBOutlet UIButton *buttonFav;
@property (nonatomic, retain) IBOutlet UIButton *buttonPur;

-(IBAction) clearAllFavoriteProducts;
-(IBAction) clearAllPurchasedProducts;

@end
