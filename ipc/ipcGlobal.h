//
//  ipcGlobal.h
//  ipc
//
//  Created by SaRy on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ApplicationService.h"
#import "Category.h"

#define BASE_URL @"http://www.themobilelife.com/tmp/fruits/1/"
#define CATEGORIES_URL @"http://www.ongsoft.com/ipc/xml/categories.xml"





#define FRUITS_URL @"http://www.themobilelife.com/tmp/fruits/1/fruits.xml"
#define SET_FRUIT_URL @"http://www.themobilelife.com/tmp/fruits/1/setFruit.php"
#define ADD_ENTRY_URL @"http://www.themobilelife.com/tmp/fruits/1/addEntry.php"
#define REMOVE_ENTRY_URL @"http://www.themobilelife.com/tmp/fruits/1/removeEntry.php"
#define ENTRIES_URL @"http://www.themobilelife.com/tmp/fruits/1/entries.xml"

#define HTTP_REQUEST_STARTING_NOTIFICATION @"HttpRequestStartingNotification"
#define HTTP_REQUEST_FINISHING_NOTIFICATION @"HttpRequestFinishingNotification"
#define RELOAD_DATA_NOTIFICATION @"ReloadDataNotification"

#define APP_SERVICE(appSrv) ApplicationService* appSrv = [(MyFruitsDiaryAppDelegate*)[[UIApplication sharedApplication] delegate] appService];
#define APP_DELEGATE(app) MyFruitsDiaryAppDelegate* app = (MyFruitsDiaryAppDelegate*)[[UIApplication sharedApplication] delegate];