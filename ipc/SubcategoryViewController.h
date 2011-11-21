//
//  SubcategoryViewController.h
//  ipc
//
//  Created by SaRy on 8/2/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"
#import "ipcGlobal.h"
#import "asyncimageview.h"

@interface SubcategoryViewController : UIViewController <UIScrollViewDelegate, UISearchBarDelegate, ApplicationServiceDelegate, UINavigationControllerDelegate, AsyncImageViewDelegate>{
    NSInteger _type;
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    IBOutlet UIButton *topButton;
    IBOutlet UIScrollView *subCategoryScrollView;
    NSDictionary* _categoryDict;
    NSArray* _categoryArray;
    NSNumber* totalCategory;
    UIActivityIndicatorView* loading;
    NSDictionary* _typeDict;
    NSMutableArray *buttons;
    NSMutableArray *imageLoaders;
}

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *myPopOver;

@property (nonatomic, retain) IBOutlet UIButton *topButton;
@property (nonatomic, retain) IBOutlet UIScrollView *subCategoryScrollView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loading;
@property (nonatomic, retain) IBOutlet UIImageView *next;
@property (nonatomic, retain) IBOutlet UIImageView *previous;

-(IBAction)gotoSubCatalogue:(id)sender;

@end
