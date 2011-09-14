//
//  HomeViewController.h
//  ipc
//
//  Created by SaRy on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopOverView.h"


@interface HomeViewController : UIViewController <UINavigationControllerDelegate, UISearchBarDelegate>{
    UIPopoverController *popoverController;
    MyPopOverView *myPopOver;
    NSDictionary* _typeDict;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) MyPopOverView *myPopOver;

- (void)flipForDuration:(NSTimeInterval)time withAnimation:(UIViewAnimationTransition)transition;

@end
