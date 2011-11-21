//
//  FavouriteViewController.m
//  ipc
//
//  Created on 9/21/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "FavouriteViewController.h"
#import "ProductSliderViewController.h"


@implementation FavouriteViewController
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
    [popoverController release];
    [myPopOver release];
    [productArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    navController = [[UINavigationController alloc] init];
    
    [navController.view setFrame:self.view.frame];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    FAV_SERVICE(favSrv);
    favouriteProductsString = [favSrv favouriteProductStringFormat];
    
    if (favouriteProductsString != nil && ![favouriteProductsString isEqualToString:@""]) {
        APP_SERVICE(appSrv);
        ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] initForFavoriteProducts:favouriteProductsString];
        [appSrv loadProductsForProductIds:favouriteProductsString from:0 to:7 inPage:1];
        [appSrv setDelegate:productSliderViewController];
        productSliderViewController.title = @"YÊU THÍCH";
        [self.view addSubview:navController.view];
        [self.navController pushViewController:productSliderViewController animated:NO];
        [self.navController.view setHidden:NO];
        [productSliderViewController release];
    }
    else{
        [noProductLabel setHidden:NO];
    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [navController popToRootViewControllerAnimated:NO];
    [navController.view removeFromSuperview];
    [navController release];
    navController = nil;
    APP_SERVICE(appSrv);
    [appSrv clearFavouriteProduct];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
