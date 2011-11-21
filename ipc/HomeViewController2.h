//
//  HomeViewController2.h
//  ipc
//
//  Created on 10/18/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"
#import "FilterOptionsViewController.h"
#import "ApplicationService.h"
#import "asyncimageview.h"


@interface HomeViewController2 : UIViewController <UINavigationControllerDelegate, UISearchBarDelegate, UIPopoverControllerDelegate, ApplicationServiceDelegate, AsyncImageViewDelegate>{
    UIPopoverController *popoverController;
    MyPopOverView *filterPopOver;
    NSDictionary* _typeDict;
    NSArray* _typeArray;
    NSMutableArray* buttons;
    NSMutableArray* imageLoaders;
    UISearchBar *searchBar;
    NSMutableArray *filterTypes;
    NSMutableArray *filterBrands;
    NSMutableArray *filterStores;
    NSMutableArray *filterCategories;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *filterPopOver;

- (void)flipForDuration:(NSTimeInterval)time withAnimation:(UIViewAnimationTransition)transition;
- (void)didFinishSearchWithString:(NSString*)searchString;
@end
