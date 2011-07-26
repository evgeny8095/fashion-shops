//
//  ItemsViewController.m
//  ipc
//
//  Created by SaRy on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemDetailsViewController.h"

@implementation ItemsViewController

@synthesize itemLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(IBAction)goToItem1{
    ItemDetailsViewController *detailViewController = [[ItemDetailsViewController alloc] init];
    
    detailViewController.navigationItem.title = itemLabel.text;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
    
}

@end
