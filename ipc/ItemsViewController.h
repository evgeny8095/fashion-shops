//
//  ItemsViewController.h
//  ipc
//
//  Created by SaRy on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewController : UIViewController{
    IBOutlet UILabel *itemLabel;
    NSDictionary *itemDict;
}

@property (nonatomic, retain) IBOutlet UILabel *itemLabel;

-(IBAction)gotoItem:(id)sender;

@end
