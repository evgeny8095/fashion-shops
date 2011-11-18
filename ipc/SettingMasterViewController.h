//
//  SettingMasterViewController.h
//  ipc
//
//  Created on 11/4/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubstitutableDetailViewController
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
@end

@interface SettingMasterViewController : UITableViewController <UISplitViewControllerDelegate> {
	UISplitViewController *splitViewController;
    
    UIPopoverController *popoverController;    
    UIBarButtonItem *rootPopoverButtonItem;
}

@property (nonatomic, assign) IBOutlet UISplitViewController *splitViewController;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIBarButtonItem *rootPopoverButtonItem;

@end
