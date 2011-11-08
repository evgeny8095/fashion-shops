//
//  ipcAppDelegate.m
//  ipc
//
//  Created by SaRy on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ipcAppDelegate.h"

@implementation ipcAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

#pragma mark - 
#pragma mark Services Accessor
- (ApplicationService*) appService
{
    return _appService;
}
- (DataService*) dataService
{
    return _dataService;
}
- (FavouriteService*) favService
{
    return _favService;
}
- (PurchaseService*) purService
{
    return _purService;
}
- (RequestService*) reqService
{
    return _reqService;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[application setStatusBarHidden:YES];
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    _appService = [[ApplicationService alloc] init];
    //[_appService loadTypes];
    [_appService loadBrands];
    [_appService loadStores];
    [_appService loadCategories];
    [_appService loadFeatureProductsList];
    //[_appService loadProductsOnSalesFrom:0 to:1];
    //[_appService setDelegate:self];
    _dataService = [[DataService alloc] init];
    _favService = [[FavouriteService alloc] init];
    [_favService loadFavouriteProducts];
    _purService = [[PurchaseService alloc] init];
    [_purService loadPurchasedProducts];
    
    _reqService = [[RequestService alloc] init];
    [_reqService loadUserInformation];
    
    [self.window setBackgroundColor:[UIColor grayColor]];
    self.window.rootViewController = self.tabBarController;
    
    //[[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:@"5"];
    //[[[[[self tabBarController] tabBar] items] objectAtIndex:4]];
    
    [self.window makeKeyAndVisible];
    //[application setStatusBarHidden:NO];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [_dataService applicationTerminate];
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_appService release];
    [_dataService release];
    [_favService release];
    [super dealloc];
}

//- (void)didFinishParsingSalesProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end
//{
//    [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%i", total]];
//}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
