//
//  HomeViewController.h
//  ipc
//
//  Created by SaRy on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (nonatomic, retain) IBOutlet UINavigationController *navController;

- (void)flipForDuration:(NSTimeInterval)time withAnimation:(UIViewAnimationTransition)transition;

@end
