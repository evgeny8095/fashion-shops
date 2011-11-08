//
//  HomeNavigationController.h
//  ipc
//
//  Created by Mahmood1 on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeNavigationController : UIViewController {
    UINavigationController *navigationController;
    UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
