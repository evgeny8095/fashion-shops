//
//  FavouriteViewController.m
//  ipc
//
//  Created by Mahmood1 on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavouriteViewController.h"


@implementation FavouriteViewController
@synthesize navController;
@synthesize navBar;
@synthesize testArray;

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
    
    DATA_SERVICE(dataSrv);
    managedObjectContext = [dataSrv managedObjectContext];
    
	NSEntityDescription *test = [NSEntityDescription entityForName:@"Testing" inManagedObjectContext:managedObjectContext];
	
	// Setup the fetch request
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:test];
	
	// Define how we will sort the records
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tid" ascending:NO];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	
	// Fetch the records and handle an error
	NSError *error;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	if (!mutableFetchResults) {
		// Handle the error.
		// This is a serious error and should advise the user to restart the application
	}
	
	// Save our fetched data to an array
	[self setTestArray: mutableFetchResults];
	
	[mutableFetchResults release];
	[request release];
    
    NSInteger count = [testArray count];
    NSLog(@"testArray count: %i", count);
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
