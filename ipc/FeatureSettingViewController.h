//
//  FeatureSettingViewController.h
//  ipc
//
//  Created by Mahmood1 on 11/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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

-(IBAction) clearAllFavoriteProducts;
-(IBAction) clearAllPurchasedProducts;

@end
