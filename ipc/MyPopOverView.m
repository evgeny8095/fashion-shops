    //
//  MyPopOverView.m
//  iPadTutorial
//
//  Created by Jannis Nikoy on 4/3/10.
//  Copyright 2010 Jannis Nikoy. All rights reserved.
//

#import "MyPopOverView.h"


@implementation MyPopOverView

- (id)initWithFilterType:(NSMutableArray*)types Brand:(NSMutableArray*)brands Store:(NSMutableArray*)stores Categories:(NSMutableArray*)categories
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        filterTypes = types;
        filterBrands = brands;
        filterStores = stores;
        filterCategories = categories;
    }
    return self;
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    FilterOptionsViewController *filterOptions = [[FilterOptionsViewController alloc] initWithFilterType:filterTypes Brand:filterBrands Store:filterStores Categories:filterCategories];
    navController = [[UINavigationController alloc] initWithRootViewController:filterOptions];
    [[navController navigationBar] setBarStyle:UIBarStyleBlack];
    navController.navigationBar.topItem.title = @"Tùy Chọn";
    navController.view.frame = self.view.frame;
    [self.view addSubview:navController.view];
    [filterOptions release];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [navController release];
    [super dealloc];
}

@end
