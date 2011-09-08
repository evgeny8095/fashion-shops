//
//  ipcGlobal.h
//  ipc
//
//  Created by SaRy on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ApplicationService.h"
#import "Type.h"
#import "Category.h"
#import "Brand.h"
#import "Store.h"
#import "Product.h"
#import "ipcAppDelegate.h"

#define BASE_URL @"http://www.themobilelife.com/tmp/fruits/1/"
#define CATEGORIES_URL @"http://www.ongsoft.com/ios/categories.php"
#define TYPES_URL @"http://www.ongsoft.com/ios/types.php"
#define STORE_URL @"http://www.ongsoft.com/ios/stores.php"
#define BRAND_URL @"http://www.ongsoft.com/ios/brands.php"
#define PRODUCT_URL @"http://www.ongsoft.com/ios/products.php"

#define FRUITS_URL @"http://www.themobilelife.com/tmp/fruits/1/fruits.xml"
#define SET_FRUIT_URL @"http://www.themobilelife.com/tmp/fruits/1/setFruit.php"
#define ADD_ENTRY_URL @"http://www.themobilelife.com/tmp/fruits/1/addEntry.php"
#define REMOVE_ENTRY_URL @"http://www.themobilelife.com/tmp/fruits/1/removeEntry.php"
#define ENTRIES_URL @"http://www.themobilelife.com/tmp/fruits/1/entries.xml"

#define HTTP_REQUEST_STARTING_NOTIFICATION @"HttpRequestStartingNotification"
#define HTTP_REQUEST_FINISHING_NOTIFICATION @"HttpRequestFinishingNotification"
#define RELOAD_DATA_NOTIFICATION @"ReloadDataNotification"

#define APP_SERVICE(appSrv) ApplicationService* appSrv = [(ipcAppDelegate*)[[UIApplication sharedApplication] delegate] appService];
#define APP_DELEGATE(app) ipcAppDelegate* app = (ipcAppDelegate*)[[UIApplication sharedApplication] delegate]