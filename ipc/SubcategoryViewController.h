//
//  SubcategoryViewController.h
//  ipc
//
//  Created by SaRy on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"
#import "ipcGlobal.h"

@interface SubcategoryViewController : UIViewController <UISearchBarDelegate>{
    NSInteger sex;
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    IBOutlet UIButton *topButton;
    IBOutlet UIScrollView *subCategoryScrollView;
    NSDictionary *categoryDict;
    NSNumber* totalCategory;
}

@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *myPopOver;

@property (nonatomic, retain) IBOutlet UIButton *topButton;
@property (nonatomic, retain) IBOutlet UIScrollView *subCategoryScrollView;

-(IBAction)gotoSubCatalogue:(id)sender;

@end
