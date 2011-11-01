//
//  ipcGlobal.h
//  ipc
//
//  Created by SaRy on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ApplicationService.h"
#import "DataService.h"
#import "FavouriteService.h"
#import "Type.h"
#import "Category.h"
#import "Brand.h"
#import "Store.h"
#import "Product.h"
#import "ipcAppDelegate.h"

#define BASE_URL @"http://www.ongsoft.com/"
//#define BASE_URL @"http://192.168.1.48/"
#define RESOURCE_PATH @"ipc/sites/default/files/"
//#define RESOURCE_PATH @"drupal7/sites/default/files/"
#define CATEGORIES_FOLDER @"images/category/"
#define PRODUCT_FOLDER @"images/product/"
#define CATEGORIES_URL [NSString stringWithFormat:@"%@ios/categories.php", BASE_URL]
#define TYPES_URL [NSString stringWithFormat:@"%@ios/typies.php", BASE_URL]
#define TYPIES_FOLDER @"images/type/"
#define STORE_URL [NSString stringWithFormat:@"%@ios/stores.php", BASE_URL]
#define BRAND_URL [NSString stringWithFormat:@"%@ios/brands.php", BASE_URL]
#define PRODUCT_URL [NSString stringWithFormat:@"%@ios/products.php", BASE_URL]
#define REQUEST_PRODUCT_URL @"requestproducts.php"
//#define FEATURE_PRODUCT_URL @"http://www.ongsoft.com/ios/products.php"

//#define HTTP_REQUEST_STARTING_NOTIFICATION @"HttpRequestStartingNotification"
//#define HTTP_REQUEST_FINISHING_NOTIFICATION @"HttpRequestFinishingNotification"
//#define RELOAD_DATA_NOTIFICATION @"ReloadDataNotification"

#define APP_SERVICE(appSrv) ApplicationService* appSrv = [(ipcAppDelegate*)[[UIApplication sharedApplication] delegate] appService]
#define DATA_SERVICE(dataSrv) DataService* dataSrv = [(ipcAppDelegate*)[[UIApplication sharedApplication] delegate] dataService]
#define FAV_SERVICE(favSrv) FavouriteService* favSrv = [(ipcAppDelegate*)[[UIApplication sharedApplication] delegate] favService]
#define REQ_DELEGATE(reqSrv) RequestService* reqSrv = [(ipcAppDelegate*)[[UIApplication sharedApplication] delegate] reqService]
#define APP_DELEGATE(app) ipcAppDelegate* app = (ipcAppDelegate*)[[UIApplication sharedApplication] delegate]