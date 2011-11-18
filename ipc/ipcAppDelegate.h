//
//  ipcAppDelegate.h
//  ipc
//
//  Created by SaRy on 7/25/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationService.h"
#import "FavouriteService.h"
#import "PurchaseService.h"
#import "RequestService.h"

@interface ipcAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    ApplicationService* _appService;
    FavouriteService* _favService;
    PurchaseService* _purService;
    RequestService* _reqService;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

-(ApplicationService*) appService;
-(FavouriteService*) favService;
-(PurchaseService*) purService;
-(RequestService*) reqService;


@end
