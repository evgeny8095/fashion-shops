//
//  ipcAppDelegate.h
//  ipc
//
//  Created by SaRy on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationService.h"
#import "DataService.h"

@interface ipcAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    ApplicationService* _appService;
    DataService* _dataService;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet UINavigationController *navController;

-(ApplicationService*) appService;
-(DataService*) dataService;

@end
