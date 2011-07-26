//
//  CategoryViewController.h
//  ipc
//
//  Created by SaRy on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController{
    IBOutlet UINavigationController *navController;
    IBOutlet UILabel *cateLabel;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UILabel *cateLabel;

-(IBAction)gotoCategory1;
-(IBAction)goBack;
@end
