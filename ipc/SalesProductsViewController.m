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
    // Do any additional setup after loading the view from its nib.
    APP_SERVICE(appSrv);
    //NSDictionary *types = [appSrv typeDict];
    //NSDictionary *categories = [appSrv categoryDict];
    //Type* c_type = [types objectForKey:[NSString stringWithFormat:@"%i", _type]];
    //Category* c_category = [categories objectForKey:[NSString stringWithFormat:@"%i", category]];
    
    //[appSrv loadProductsOnSalesFrom:0 to:0];
    
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] initForSalesProducts];
    [appSrv setDelegate:productSliderViewController];
    //productSliderViewController.c_type = c_type;
    //productSliderViewController.c_category = c_category;
    //productSliderViewController.type = _type;
    //productSliderViewController.category = category;
    //productSliderViewController.navigationItem.title = [title uppercaseString];
    productSliderViewController.title = @"SALES";
    
    //[self.navigationController pushViewController:productSliderViewController animated:YES];
    
    [productSliderViewController release];
    
    UILabel *underContruction = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 100)];
    [underContruction setText:@"Feature Under Contruction!"];
    [underContruction setFont:[UIFont systemFontOfSize:40]];
    [underContruction setCenter:CGPointMake(512, 355)];
    [self.view addSubview:underContruction];
    [underContruction release];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
