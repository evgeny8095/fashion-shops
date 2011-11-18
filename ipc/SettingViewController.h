//
//  SettingViewController.h
//  ipc
//
//  Created on 11/3/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingViewController : UIViewController {
    UISplitViewController *splitViewController;
}

@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;

@end
