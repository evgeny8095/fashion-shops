//
//  FilterViewController.m
//  ipc
//
//  Created on 10/24/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "FilterViewController.h"


@implementation FilterViewController
@synthesize navBar, navController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithTypies:(NSString *)f_typies
           andBrands:(NSString *)f_brands
           andStores:(NSString *)f_stores
       andCategories:(NSString *)f_categories
         hasTopPrice:(NSString *)f_topPrice
      hasBottomPrice:(NSString *)f_bottomPrice
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        typies = [f_typies retain];
        brands = [f_brands retain];
        stores = [f_stores retain];
        categories = [f_categories retain];
        topPrice = [f_topPrice retain];
        bottomPrice = [f_bottomPrice retain];
    }
    return self;
}

- (void)dealloc
{
    [popoverController release];
    [myPopOver release];
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
