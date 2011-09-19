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

@interface SubcategoryViewController : UIViewController <UISearchBarDelegate, ApplicationServiceDelegate>{
    NSInteger _type;
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    IBOutlet UIButton *topButton;
    IBOutlet UIScrollView *subCategoryScrollView;
    NSDictionary* _categoryDict;
    NSNumber* totalCategory;
    UIActivityIndicatorView* loading;
    NSDictionary* _typeDict;
}

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *myPopOver;

@property (nonatomic, retain) IBOutlet UIButton *topButton;
@property (nonatomic, retain) IBOutlet UIScrollView *subCategoryScrollView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loading;

-(IBAction)gotoSubCatalogue:(id)sender;

@end
