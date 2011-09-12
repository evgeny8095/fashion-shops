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

@synthesize navController, navBar, myPopOver, popoverController;

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
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    NSString *baseURL = @"http://www.ongsoft.com/ipc/";
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //search
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [searchBar setDelegate:self];
    navBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    [searchBar release];
    
    // The left big button
    NSString *bigURL = [NSString stringWithFormat:@"%@%@", baseURL, @"home/collections.jpg"];
    NSURL *bigHomeURL = [NSURL URLWithString:bigURL];
    //[bigURL release];
    UIImage *bigHomeImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:bigHomeURL]];
    //[bigHomeURL release];
    if (bigHomeImage == nil) {
        [bigHomeImage release];
        bigHomeImage = [UIImage imageNamed:@"big_home.jpg"];
    }
    
    UIButton *bigButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, 512, 655)];
    [bigButton setImage:bigHomeImage forState:normal];
    [bigHomeImage release];
    UILabel *bigLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 659, 512, 40)];
    [bigLable setText:@"COLLECTIONS"];
    [bigLable setTextAlignment:UITextAlignmentCenter];
    [bigLable setFont:[UIFont systemFontOfSize:30.0]];
    [bigLable setTextColor:[UIColor whiteColor]];
    [bigLable setBackgroundColor:[UIColor blackColor]];
    [bigLable setAlpha:0.5];
    
    // The 4 right button
    NSString *smallURL1 = [NSString stringWithFormat:@"%@/%@", baseURL, @"home/new.jpg"];
    NSURL *smallHomeURL1 = [NSURL URLWithString:smallURL1];
    //[smallURL1 release];
    UIImage *smallHomeImage1 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:smallHomeURL1]];
    //[smallHomeURL1 release];
    if (smallHomeImage1 == nil) {
        [smallHomeImage1 release];
        smallHomeImage1 = [UIImage imageNamed:@"small_home1.jpg"];
    }
    
    NSString *smallURL2 = [NSString stringWithFormat:@"%@/%@", baseURL, @"home/sale.jpg"];
    NSURL *smallHomeURL2 = [NSURL URLWithString:smallURL2];
    //[smallURL2 release];
    UIImage *smallHomeImage2 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:smallHomeURL2]];
    //[smallHomeURL2 release];
    if (smallHomeImage2 == nil) {
        [smallHomeImage2 release];
        smallHomeImage2 = [UIImage imageNamed:@"small_home2.jpg"];
    }
    
    NSString *smallURL3 = [NSString stringWithFormat:@"%@/%@", baseURL, @"home/female.jpg"];
    NSURL *smallHomeURL3 = [NSURL URLWithString:smallURL3];
    //[smallURL3 release];
    UIImage *smallHomeImage3 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:smallHomeURL3]];
    //[smallHomeURL3 release];
    if (smallHomeImage3 == nil) {
        [smallHomeImage3 release];
        smallHomeImage3 = [UIImage imageNamed:@"small_home3.jpg"];
    }
    
    NSString *smallURL4 = [NSString stringWithFormat:@"%@/%@", baseURL, @"home/male.jpg"];
    NSURL *smallHomeURL4 = [NSURL URLWithString:smallURL4];
    //[smallURL4 release];
    UIImage *smallHomeImage4 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:smallHomeURL4]];
    //[smallHomeURL4 release];
    if (smallHomeImage4 == nil) {
        [smallHomeImage4 release];
        smallHomeImage4 = [UIImage imageNamed:@"small_home4.jpg"];
    }
    
    
    UIButton *smallButton1 = [[UIButton alloc] initWithFrame:CGRectMake(512, 44, 256, 327.5)];
    [smallButton1 setImage:smallHomeImage1 forState:normal];
    [smallButton1 setTitle:@"NEW ARRIVAL" forState:normal];
    [smallButton1 addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
    [smallButton1 setTag:1];
    [smallHomeImage1 release];
    UILabel *smallLable1 = [[UILabel alloc] initWithFrame:CGRectMake(512, 331.5, 256, 40)];
    [smallLable1 setText:@"NEW ARRIVAL"];
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
    [smallButton2 setTag:2];
    UILabel *smallLable2 = [[UILabel alloc] initWithFrame:CGRectMake(768, 331.5, 256, 40)];
    [smallLable2 setText:@"SALE"];
    [smallLable2 setTextAlignment:UITextAlignmentCenter];
    [smallLable2 setFont:[UIFont systemFontOfSize:30.0]];
    [smallLable2 setTextColor:[UIColor whiteColor]];
    [smallLable2 setBackgroundColor:[UIColor blackColor]];
    [smallLable2 setAlpha:0.5];
    
    UIButton *smallButton3 = [[UIButton alloc] initWithFrame:CGRectMake(512, 371.5, 256, 327.5)];
    [smallButton3 setImage:smallHomeImage3 forState:normal];
    [smallButton3 setTitle:@"FEMALE" forState:normal];
    [smallButton3 setTag:2];
    [smallHomeImage3 release];
    [smallButton3 addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *smallLable3 = [[UILabel alloc] initWithFrame:CGRectMake(512, 659, 256, 40)];
    [smallLable3 setText:@"FEMALE"];
    [smallLable3 setTextAlignment:UITextAlignmentCenter];
    [smallLable3 setFont:[UIFont systemFontOfSize:30.0]];
    [smallLable3 setTextColor:[UIColor whiteColor]];
    [smallLable3 setBackgroundColor:[UIColor blackColor]];
    [smallLable3 setAlpha:0.5];
    
    UIButton *smallButton4 = [[UIButton alloc] initWithFrame:CGRectMake(768, 371.4, 256, 327.5)];
    [smallButton4 setImage:smallHomeImage4 forState:normal];
    [smallButton4 setTitle:@"MALE" forState:normal];
    [smallButton4 setTag:1];
    [smallHomeImage4 release];
    [smallButton4 addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *smallLable4 = [[UILabel alloc] initWithFrame:CGRectMake(768, 659, 256, 40)];
    [smallLable4 setText:@"MALE"];
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
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)gotoCategory:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    NSInteger type =  ((UIButton *) sender).tag;
    
    navController = [[UINavigationController alloc] init];
    navController.delegate=self;
    
    [navController.view setFrame:CGRectMake(0, 0, 1024, 748)];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    SubcategoryViewController *subCategoryViewController = [[SubcategoryViewController alloc] init];
    
    subCategoryViewController.navigationItem.title = title;
    subCategoryViewController.type = type;
    
    subCategoryViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"HOME" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    [navController pushViewController:subCategoryViewController animated:YES];
    
    [self.view addSubview:navController.view];
    
    [self flipForDuration:0.75 withAnimation:UIViewAnimationTransitionFlipFromLeft];
    
//    [UIView animateWithDuration:0.75 
//                     animations:^{
//                         
//                     }
//                     completion:^(BOOL finished) {
//                         [self.view addSubview:navController.view];
//                     }];
    //[self.view addSubview:navController.view];
    [subCategoryViewController release];
}

-(IBAction)goBack{
    [navController.view removeFromSuperview];
    [self flipForDuration:0.75 withAnimation:UIViewAnimationTransitionFlipFromRight];
    [navController release];
}

- (void)flipForDuration:(NSTimeInterval)time withAnimation:(UIViewAnimationTransition)transition{
    [UIView beginAnimations:Nil context:nil];
	[UIView setAnimationDuration:time];
	[UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}


//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"didshow");
//}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"didshow");
//}

#pragma mark searchbar delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    myPopOver = [[MyPopOverView alloc] initWithNibName:@"MyPopOverView" bundle:nil];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:myPopOver];
    
    
    [popoverController setPopoverContentSize:CGSizeMake(300.0f, 300.0f)];
    //		[popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // Or use the following line to display it from a given rectangle
    [popoverController presentPopoverFromRect:CGRectMake(824, 0, 200, 38) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [popoverController dismissPopoverAnimated:YES];
}

@end
