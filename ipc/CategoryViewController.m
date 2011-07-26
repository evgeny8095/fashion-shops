//
//  CategoryViewController.m
//  ipc
//
//  Created by SaRy on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"
#import "CatalogueViewController.h"

@implementation CategoryViewController

@synthesize navController, cateLabel;

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
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)flipForDuration:(NSTimeInterval)time withAnimation:(UIViewAnimationTransition)transition{
    [UIView beginAnimations:Nil context:NULL];
	[UIView setAnimationDuration:time];
	[UIView setAnimationTransition:transition forView:self.view cache:YES];
}

- (IBAction)gotoCategory1{
    navController = [[UINavigationController alloc] init];
    
    [navController.view setFrame:CGRectMake(0, 0, 1024, 748)];
    
    CatalogueViewController *catalogueViewController = [[CatalogueViewController alloc] init];
    
    catalogueViewController.navigationItem.title = cateLabel.text;
    
    catalogueViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Category" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    [navController pushViewController:catalogueViewController animated:YES];
    
    [self.view addSubview:navController.view];
    
    [catalogueViewController release];
}

-(IBAction)goBack{
    [navController.view removeFromSuperview];
    [navController release];
}

@end
