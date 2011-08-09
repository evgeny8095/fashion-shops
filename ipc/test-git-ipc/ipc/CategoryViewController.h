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
    NSDictionary *categoryDict;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;

-(IBAction)gotoCategory:(id)sender;
-(IBAction)goBack;
@end
