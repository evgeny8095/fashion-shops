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
#import "FavouriteService.h"
#import "RequestService.h"

@interface ipcAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    ApplicationService* _appService;
    DataService* _dataService;
    FavouriteService* _favService;
    RequestService* _reqService;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) IBOutlet UINavigationController *navController;

-(ApplicationService*) appService;
-(DataService*) dataService;
-(FavouriteService*) favService;
-(RequestService*) reqService;

@end
