//
//  SalesProductsViewController.m
//  ipc
//
//  Created by Mahmood1 on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SalesProductsViewController.h"


@implementation SalesProductsViewController
@synthesize navController, navBar;

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
    [popoverController release];
    [myPopOver release];
    [productArray release];
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
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
    UILabel *underContruction = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 100)];
    [underContruction setText:@"Feature Under Contruction!"];
    [underContruction setFont:[UIFont systemFontOfSize:40]];
    [underContruction setCenter:CGPointMake(512, 355)];
    //[self.view addSubview:underContruction];
    [underContruction release];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    navController = [[UINavigationController alloc] init];
    
    [navController.view setFrame:self.view.frame];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    APP_SERVICE(appSrvvv);
    //NSDictionary *types = [appSrv typeDict];
    //NSDictionary *categories = [appSrv categoryDict];
    //Type* c_type = [types objectForKey:[NSString stringWithFormat:@"%i", _type]];
    //Category* c_category = [categories objectForKey:[NSString stringWithFormat:@"%i", category]];
    
    [appSrvvv loadProductsOnSalesFrom:0 to:15];
    
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] initForSalesProducts];
    [appSrvvv setDelegate:productSliderViewController];
    //productSliderViewController.c_type = c_type;
    //productSliderViewController.c_category = c_category;
    //productSliderViewController.type = _type;
    //productSliderViewController.category = category;
    //productSliderViewController.navigationItem.title = [title uppercaseString];
    productSliderViewController.title = @"SALES";
    
    [self.view addSubview:navController.view];
    
    [self.navController pushViewController:productSliderViewController animated:YES];
    
    [productSliderViewController release];
    
    //[[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:@"5"];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [navController release];
    navController = nil;
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
