//
//  FeatureProductsViewController.m
//  ipc
//
//  Created by Mahmood1 on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeatureProductsViewController.h"


@implementation FeatureProductsViewController
@synthesize navController;
@synthesize navBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    navController = [[UINavigationController alloc] init];
    
    [navController.view setFrame:self.view.frame];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    APP_SERVICE(appSrvvv);
    //NSDictionary *types = [appSrvvv typeDict];
    //NSDictionary *categories = [appSrvvv categoryDict];
    [appSrvvv loadProductsOfFeatureShopFrom:0 to:15];
    
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] initForFeatureProducts];
    [appSrvvv setDelegate:productSliderViewController];
    //productSliderViewController.c_type = c_type;
    //productSliderViewController.c_category = c_category;
    //productSliderViewController.type = _type;
    //productSliderViewController.category = category;
    //productSliderViewController.navigationItem.title = title;
    //productSliderViewController.title = title;
    
    [self.view addSubview:navController.view];
    
    [self.navController pushViewController:productSliderViewController animated:NO];
    
    [productSliderViewController release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
