//
//  HomeViewController2.m
//  ipc
//
//  Created by Mahmood1 on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController2.h"
#import "SubcategoryViewController.h"
#import "CategoryXMLHandler.h"
#import "asyncimageview.h"

#define buttonHeight 170
#define buttonWidth 130
#define buttonSpacing 40
#define scrollContentHeight 170

@implementation HomeViewController2

@synthesize navController, navBar, myPopOver, popoverController, imageView, scrollView;

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
    APP_SERVICE(appSrv);
    _typeDict = [appSrv typeDict];
    _typeArray = [appSrv typeArray];
    // Do any additional setup after loading the view from its nib.
    
    //[self.view setBackgroundColor:[UIColor grayColor]];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //search
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [searchBar setDelegate:self];
    navBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    [searchBar release];
    
    //type buttons
    NSInteger px = 0;
    NSInteger py = 0;
    //NSInteger scrollWidth = 0;
    NSInteger count = [_typeArray count];
    
    buttons = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [buttons addObject:button];
        [button release];
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        Type* type = [_typeArray objectAtIndex:i];
        
        AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
        
        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@%@", BASE_URL, TYPIES_FOLDER, type.image];
        NSURL* url = [NSURL URLWithString:urlPath];
        NSLog(@"type url: %@", urlPath);
        [urlPath release];
        
        [asyncImage loadImageFromURL:url forButton:[buttons objectAtIndex:i]];
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        Type* type = [_typeArray objectAtIndex:i];
        UIButton* button = [buttons objectAtIndex:i];
        [button setFrame:CGRectMake(px, py, buttonWidth, buttonHeight)];
        [button addTarget:self action:@selector(gotoCategory:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:[type.tid intValue]];
        [button setTitle:type.name forState:normal];
        [button setBackgroundColor:[UIColor clearColor]];
        [scrollView addSubview:button];
        
        px = px + buttonSpacing + buttonWidth;
    }
    
    [scrollView setContentSize:CGSizeMake(px, scrollView.frame.size.height)];
    [scrollView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
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
    NSInteger typeId =  ((UIButton *) sender).tag;
    NSString *key = [NSString stringWithFormat:@"%i", typeId];
    Type *c_type = [_typeDict objectForKey:key];
    
    navController = [[UINavigationController alloc] init];
    navController.delegate=self;
    
    [navController.view setFrame:CGRectMake(0, 0, 1024, 748)];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    SubcategoryViewController *subCategoryViewController = [[SubcategoryViewController alloc] init];
    APP_SERVICE(appSrv);
    [appSrv clearCategory];
    [appSrv setDelegate:subCategoryViewController];
    [appSrv loadCategoriesForType:c_type];
    
    subCategoryViewController.navigationItem.title = title;
    subCategoryViewController.type = typeId;
    //subCategoryViewController.categoryDict = myCategoryDict;
    
    subCategoryViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"HOME" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    [navController pushViewController:subCategoryViewController animated:YES];
    [navController setDelegate:subCategoryViewController];
    
    [self.view addSubview:navController.view];
    
    [self flipForDuration:0.75 withAnimation:UIViewAnimationTransitionFlipFromLeft];
    
    //    [UIView animateWithDuration:0.75 
    //                     animations:^{
    //                         
    //                     }
    //                     completion:^(BOOL finished) {
    //                         [self.view addSubview:navController.view];
    //                     }];
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
    //[popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // Or use the following line to display it from a given rectangle
    [popoverController presentPopoverFromRect:CGRectMake(824, 0, 200, 38) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [popoverController dismissPopoverAnimated:YES];
}

@end
