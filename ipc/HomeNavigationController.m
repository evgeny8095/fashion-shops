//
//  HomeNavigationController.m
//  ipc
//
//  Created by Mahmood1 on 10/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeNavigationController.h"


@implementation HomeNavigationController
@synthesize navController;

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
    [navController.navigationBar setBarStyle:UIBarStyleBlack];

    NSInteger x = navController.view.frame.origin.x;
    NSInteger y = navController.view.frame.origin.y;
    NSInteger w = navController.view.frame.size.width;
    NSInteger h = navController.view.frame.size.height;
    NSLog(@"x:%i,y:%i,w:%i,h:%i", x, y, w, h);
    
    [self.view addSubview:navController.view];
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
