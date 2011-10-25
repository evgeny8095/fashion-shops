//
//  MyPopOverView.h
//  iPadTutorial
//
//  Created by Jannis Nikoy on 4/3/10.
//  Copyright 2010 Jannis Nikoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterOptionsViewController.h"


@interface MyPopOverView : UIViewController{
    IBOutlet UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end
