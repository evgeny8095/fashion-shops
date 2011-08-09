//
//  HomeViewController.m
//  ipc
//
//  Created by SaRy on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "CatalogueViewController.h"
#import "SubcategoryViewController.h"

@implementation HomeViewController

@synthesize navController;

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
    // The left big button
    UIImage *bigHomeImage = [UIImage imageNamed:@"big_home.jpg"];
    UIButton *bigButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, 512, 655)];
    [bigButton setImage:bigHomeImage forState:normal];
    [bigHomeImage release];
    UILabel *bigLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 659, 512, 40)];
    [bigLable setText:@"BO SUU TAP"];
    [bigLable setTextAlignment:UITextAlignmentCenter];
    [bigLable setFont:[UIFont systemFontOfSize:30.0]];
    [bigLable setTextColor:[UIColor whiteColor]];
    [bigLable setBackgroundColor:[UIColor blackColor]];
    [bigLable setAlpha:0.5];
    
    // The 4 right button
    UIImage *smallHomeImage1 = [UIImage imageNamed:@"small_home1.jpg"];
    UIImage *smallHomeImage2 = [UIImage imageNamed:@"small_home2.jpg"];
    UIImage *smallHomeImage3 = [UIImage imageNamed:@"small_home3.jpg"];
    UIImage *smallHomeImage4 = [UIImage imageNamed:@"small_home4.jpg"];
    
    UIButton *smallButton1 = [[UIButton alloc] initWithFrame:CGRectMake(512, 44, 256, 327.5)];
    [smallButton1 setImage:smallHomeImage1 forState:normal];
    [smallButton1 setTitle:@"SP MOI" forState:normal];
    [smallButton1 addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
    [smallHomeImage1 release];
    UILabel *smallLable1 = [[UILabel alloc] initWithFrame:CGRectMake(512, 331.5, 256, 40)];
    [smallLable1 setText:@"SP Moi"];
    [smallLable1 setTextAlignment:UITextAlignmentCenter];
    [smallLable1 setFont:[UIFont systemFontOfSize:30.0]];
    [smallLable1 setTextColor:[UIColor whiteColor]];
    [smallLable1 setBackgroundColor:[UIColor blackColor]];
    [smallLable1 setAlpha:0.5];
    
    UIButton *smallButton2 = [[UIButton alloc] initWithFrame:CGRectMake(768, 44, 256, 327.5)];
    [smallButton2 setImage:smallHomeImage2 forState:normal];
    [smallButton2 setTitle:@"SALE" forState:normal];
    [smallHomeImage2 release];
    [smallButton2 addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *smallLable2 = [[UILabel alloc] initWithFrame:CGRectMake(768, 331.5, 256, 40)];
    [smallLable2 setText:@"SALE"];
    [smallLable2 setTextAlignment:UITextAlignmentCenter];
    [smallLable2 setFont:[UIFont systemFontOfSize:30.0]];
    [smallLable2 setTextColor:[UIColor whiteColor]];
    [smallLable2 setBackgroundColor:[UIColor blackColor]];
    [smallLable2 setAlpha:0.5];
    
    UIButton *smallButton3 = [[UIButton alloc] initWithFrame:CGRectMake(512, 371.5, 256, 327.5)];
    [smallButton3 setImage:smallHomeImage3 forState:normal];
    [smallButton3 setTitle:@"TT NU" forState:normal];
    [smallHomeImage3 release];
    [smallButton3 addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *smallLable3 = [[UILabel alloc] initWithFrame:CGRectMake(512, 659, 256, 40)];
    [smallLable3 setText:@"TT Nu"];
    [smallLable3 setTextAlignment:UITextAlignmentCenter];
    [smallLable3 setFont:[UIFont systemFontOfSize:30.0]];
    [smallLable3 setTextColor:[UIColor whiteColor]];
    [smallLable3 setBackgroundColor:[UIColor blackColor]];
    [smallLable3 setAlpha:0.5];
    
    UIButton *smallButton4 = [[UIButton alloc] initWithFrame:CGRectMake(768, 371.4, 256, 327.5)];
    [smallButton4 setImage:smallHomeImage4 forState:normal];
    [smallButton4 setTitle:@"TT NAM" forState:normal];
    [smallHomeImage4 release];
    [smallButton4 addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *smallLable4 = [[UILabel alloc] initWithFrame:CGRectMake(768, 659, 256, 40)];
    [smallLable4 setText:@"TT Nam"];
    [smallLable4 setTextAlignment:UITextAlignmentCenter];
    [smallLable4 setFont:[UIFont systemFontOfSize:30.0]];
    [smallLable4 setTextColor:[UIColor whiteColor]];
    [smallLable4 setBackgroundColor:[UIColor blackColor]];
    [smallLable4 setAlpha:0.5];
    
    [self.view addSubview:bigButton];
    [bigButton release];
    [self.view addSubview:bigLable];
    [bigLable release];
    [self.view addSubview:smallButton1];
    [smallButton1 release];
    [self.view addSubview:smallLable1];
    [smallLable1 release];
    [self.view addSubview:smallButton2];
    [smallButton2 release];
    [self.view addSubview:smallLable2];
    [smallLable2 release];
    [self.view addSubview:smallButton3];
    [smallButton3 release];
    [self.view addSubview:smallLable3];
    [smallLable3 release];
    [self.view addSubview:smallButton4];
    [smallButton4 release];
    [self.view addSubview:smallLable4];
    [smallLable4 release];
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

- (IBAction)gotoCategory:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    
    navController = [[UINavigationController alloc] init];
    
    [navController.view setFrame:CGRectMake(0, 0, 1024, 748)];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    //CatalogueViewController *catalogueViewController = [[CatalogueViewController alloc] init];
    SubcategoryViewController *subCategoryViewController = [[SubcategoryViewController alloc] init];
    
    //catalogueViewController.navigationItem.title = title;
    subCategoryViewController.navigationItem.title = title;
    
    //catalogueViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"HOME" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    subCategoryViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"HOME" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    //[navController pushViewController:catalogueViewController animated:YES];
    [navController pushViewController:subCategoryViewController animated:YES];
    
    [self.view addSubview:navController.view];
    
    //[catalogueViewController release];
    [subCategoryViewController release];
}

-(IBAction)goBack{
    [navController.view removeFromSuperview];
    [navController release];
}

@end