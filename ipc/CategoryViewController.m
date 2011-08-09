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

@synthesize navController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    [categoryDict release];
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
    NSArray *categoryLabel = [[NSArray alloc] initWithObjects:@"Thoi trang nu", @"Nu Trang", @"Cong So", @"Do tam", @"Phu trang", @"Trang phuc bau", @"Eye Wear", @"Foot Wear", nil];
    NSArray *categoryImage = [[NSArray alloc] initWithObjects:@"image1.png", @"image2.png", @"image3.png", @"image4.png", @"image5.png", @"image6.png", @"image7.png", @"image8.png", nil];
    categoryDict = [[NSDictionary alloc] initWithObjects:categoryImage forKeys:categoryLabel];
    
    [categoryLabel release];
    [categoryImage release];
    NSInteger x = 225;
    NSInteger y = 200;
    for (id key in categoryDict){
        UIButton *catButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 128, 128)];
        UILabel *catLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y+133, 128, 15)];
        [catLabel setText:key];
        UIImage *catButtonImage = [UIImage imageNamed:[categoryDict objectForKey:key]];
        [catButton addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
        [catButton setImage:catButtonImage forState:normal];
        [catButton setTitle:key forState:normal];
        [catButton setTitleColor:[UIColor blackColor] forState:normal];
        [catButtonImage release];
        [self.view addSubview:catButton];
        [self.view addSubview:catLabel];
        [catButton release];
        [catLabel release];
        x = x + 20 + 128;
        if (x > 700){
            x = 225;
            y = y + 40 + 128; 
        }            
    }
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

- (IBAction)gotoCategory:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    
    navController = [[UINavigationController alloc] init];
    
    [navController.view setFrame:CGRectMake(0, 0, 1024, 748)];
    
    CatalogueViewController *catalogueViewController = [[CatalogueViewController alloc] init];
    
    catalogueViewController.navigationItem.title = title;
    
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
