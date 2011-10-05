//
//  FavouriteViewController.m
//  ipc
//
//  Created by Mahmood1 on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavouriteViewController.h"
#import "ProductSliderViewController.h"


@implementation FavouriteViewController
@synthesize navController;
@synthesize navBar;
@synthesize fproductArray;

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
    // Define our table/entity to use
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
//    DATA_SERVICE(dataSrv);
//    managedObjectContext = [dataSrv managedObjectContext];
//    
//	NSEntityDescription *fproduct = [NSEntityDescription entityForName:@"FProduct" inManagedObjectContext:managedObjectContext];
//	
//	// Setup the fetch request
//	NSFetchRequest *request = [[NSFetchRequest alloc] init];
//	[request setEntity:fproduct];
//	
//	// Define how we will sort the records
//	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pid" ascending:NO];
//	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//	
//	[request setSortDescriptors:sortDescriptors];
//	[sortDescriptor release];
//	
//	// Fetch the records and handle an error
//	NSError *error;
//	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//	
//	if (!mutableFetchResults) {
//		// Handle the error.
//		// This is a serious error and should advise the user to restart the application
//	}
//	
//	// Save our fetched data to an array
//	[self setFproductArray: mutableFetchResults];
//	
//    for (FProduct* fproduct in fproductArray)
//    {
//        Product* product = [fproduct toProduct];
//        if (productArray == nil) {
//            productArray = [[NSMutableArray alloc] init];
//        }
//        [productArray addObject:product];
//        [product release];
//    }
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    navController = [[UINavigationController alloc] init];
    
    [navController.view setFrame:self.view.frame];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
	//[mutableFetchResults release];
	//[request release];
    
    //NSInteger count = [fproductArray count];
    //NSLog(@"testArray count: %i", count);
    
    //ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] initWithProductArray:productArray];
    //productSliderViewController.c_type = c_type;
    //productSliderViewController.c_category = c_category;
    //productSliderViewController.type = _type;
    //productSliderViewController.category = category;
    //productSliderViewController.navigationItem.title = title;
    //productSliderViewController.title = title;
    
    FAV_SERVICE(favSrv);
    favouriteProductsString = [favSrv favouriteProductStringFormat];
    
    if (favouriteProductsString != nil && ![favouriteProductsString isEqualToString:@""]) {
        APP_SERVICE(appSrvvv);
        //NSDictionary *types = [appSrvvv typeDict];
        //NSDictionary *categories = [appSrvvv categoryDict];
        [appSrvvv loadProductsForProductIds:favouriteProductsString from:0 to:15];
        
        ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] initForFavoriteProducts:favouriteProductsString];
        [appSrvvv setDelegate:productSliderViewController];
        //productSliderViewController.c_type = c_type;
        //productSliderViewController.c_category = c_category;
        //productSliderViewController.type = _type;
        //productSliderViewController.category = category;
        //productSliderViewController.navigationItem.title = title;
        productSliderViewController.title = @"FAVOURITE";
        
        [self.view addSubview:navController.view];
        
        [self.navController pushViewController:productSliderViewController animated:NO];
        
        [productSliderViewController release];
    }    

}

-(void) viewDidDisappear:(BOOL)animated
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
