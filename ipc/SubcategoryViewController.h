//
//  SubcategoryViewController.h
//  ipc
//
//  Created by SaRy on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubcategoryViewController : UIViewController{
    NSInteger sex;
}

@property (nonatomic, assign) NSInteger sex;

-(IBAction)gotoSubCatalogue:(id)sender;

@end
