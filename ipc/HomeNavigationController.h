//
//  HomeNavigationController.h
//  ipc
//
//  Created on 11/7/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeNavigationController : UIViewController {
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
