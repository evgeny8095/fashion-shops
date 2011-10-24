//
//  HomeViewController2.h
//  ipc
//
//  Created by Mahmood1 on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"
#import "ApplicationService.h"


@interface HomeViewController2 : UIViewController <UINavigationControllerDelegate, UISearchBarDelegate, ApplicationServiceDelegate>{
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    NSDictionary* _typeDict;
    NSArray* _typeArray;
    NSMutableArray* buttons;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *myPopOver;

- (void)flipForDuration:(NSTimeInterval)time withAnimation:(UIViewAnimationTransition)transition;

@end
