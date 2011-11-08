//
//  HomeNavigationController.m
//  ipc
//
//  Created by Mahmood1 on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeNavigationController.h"
#import "HomeViewController2.h"


@implementation HomeNavigationController
@synthesize navigationController;

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
    [self.view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:navigationController.view];
    //self.view = navigationController.view;
    
    NSLog(@"%f:%f:%f:%f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"%f:%f:%f:%f", navigationController.view.frame.origin.x, navigationController.view.frame.origin.y, navigationController.view.frame.size.width, navigationController.view.frame.size.height);
    
    
//    HomeViewController2 *rootViewController= [[HomeViewController2 alloc] initWithNibName:@"HomeViewController2" bundle:nil];
//    NSLog(@"%f:%f:%f:%f", rootViewController.view.frame.origin.x, rootViewController.view.frame.origin.y, rootViewController.view.frame.size.width, rootViewController.view.frame.size.height);
//    navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
//    [[navController navigationBar] setBarStyle:UIBarStyleBlack];
//    navController.navigationBar.topItem.title = @"Home";
//    [navController setDelegate:rootViewController];
//    
//    [self.view setFrame:CGRectMake(0, 0, 1024, 768)];
//    CGRect newFrame = CGRectMake(0, 0, 768, 44);
//    [[navController navigationBar] setFrame:newFrame];
//    CGRect myframe = [[navController navigationBar] frame];
//    [self.view addSubview:navController.view];
//    NSLog(@"%f:%f:%f:%f", myframe.origin.x, myframe.origin.y, myframe.size.width, myframe.size.height);
//    NSLog(@"%f:%f:%f:%f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
//    NSLog(@"%f:%f:%f:%f", navController.view.frame.origin.x, navController.view.frame.origin.y, navController.view.frame.size.width, navController.view.frame.size.height);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
