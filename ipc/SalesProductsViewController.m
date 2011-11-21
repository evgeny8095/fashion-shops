//
//  SalesProductsViewController.m
//  ipc
//
//  Created on 9/30/11.
//  Copyright 2011 OngSoft. All rights reserved.
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
        
    noProductLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 100)];
    [noProductLabel setNumberOfLines:2];
    [noProductLabel setTextAlignment:UITextAlignmentCenter];
    [noProductLabel setText:@"Quý khách chưa có sản phẩm yêu thích."];
    [noProductLabel setFont:[UIFont systemFontOfSize:40]];
    [noProductLabel setCenter:CGPointMake(512, 355)];
    [noProductLabel setHidden:YES];
    [self.view addSubview:noProductLabel];
    [noProductLabel release];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    navController = [[UINavigationController alloc] init];
    
    [navController.view setFrame:self.view.frame];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    APP_SERVICE(appSrvvv);
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] initForSalesProducts];
    [appSrvvv loadProductsOnSalesFrom:0 to:7 inPage:1];
    [appSrvvv setDelegate:productSliderViewController];
    productSliderViewController.title = @"GIẢM GIÁ";
    
    [self.view addSubview:navController.view];
    
    [self.navController pushViewController:productSliderViewController animated:YES];
    
    [productSliderViewController release];
    
    //[[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:@"5"];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [navController.view removeFromSuperview];
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
