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
    UINavigationController *navController;
    NSMutableArray *filterTypes;
    NSMutableArray *filterBrands;
    NSMutableArray *filterStores;
    NSMutableArray *filterCategories;
}

- (id)initWithFilterType:(NSMutableArray*)types Brand:(NSMutableArray*)brands Store:(NSMutableArray*)stores Categories:(NSMutableArray*)categories;

@end
