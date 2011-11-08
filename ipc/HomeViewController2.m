//
//  HomeViewController2.m
//  ipc
//
//  Created by Mahmood1 on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController2.h"
#import "SubcategoryViewController.h"
#import "ProductSliderViewController.h"
#import "FilterViewController.h"
#import "CategoryXMLHandler.h"
#import "asyncimageview.h"

#define buttonHeight 170
#define buttonWidth 130
#define buttonSpacing 40
#define scrollContentHeight 170

@implementation HomeViewController2

@synthesize filterPopOver, popoverController, imageView, scrollView;

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
    filterTypes = [[NSMutableArray alloc] init];
    filterBrands = [[NSMutableArray alloc] init];
    filterStores = [[NSMutableArray alloc] init];
    filterCategories =[[NSMutableArray alloc] init];
    [super viewDidLoad];
    APP_SERVICE(appSrv);
    [appSrv clearTypies];
    [appSrv loadTypes];
    [appSrv setDelegate:self];
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
    
    [self.navigationController setDelegate:self];
    NSLog(@"%i", c_type.style);
    if (c_type.style == 0) {
        SubcategoryViewController *subCategoryViewController = [[SubcategoryViewController alloc] init];
        APP_SERVICE(appSrv);
        [appSrv clearCategory];
        [appSrv setDelegate:subCategoryViewController];
        [appSrv loadCategoriesForType:c_type];
        
        subCategoryViewController.navigationItem.title = title;
        subCategoryViewController.type = typeId;
        
        [self.navigationController pushViewController:subCategoryViewController animated:YES];
        [self.navigationController setDelegate:subCategoryViewController];
        
        [subCategoryViewController release];
    }
    if (c_type.style == 1) {
        APP_SERVICE(appSrv);
        [appSrv loadProductsForType:c_type forCatetory:nil from:0 to:15];
        
        ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] init];
        [appSrv setDelegate:productSliderViewController];
        productSliderViewController.c_type = c_type;
        productSliderViewController.c_category = nil;
        //productSliderViewController.navigationItem.title = [title uppercaseString];
        productSliderViewController.title = [title uppercaseString];
        
        [self.navigationController pushViewController:productSliderViewController animated:YES];
        
        [productSliderViewController release];
    }
}

-(IBAction)goBack{

}

- (void)flipForDuration:(NSTimeInterval)time withAnimation:(UIViewAnimationTransition)transition{
    [UIView beginAnimations:Nil context:nil];
	[UIView setAnimationDuration:time];
	[UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

-(void) didFinishSearchWithString:(NSString *)searchString
{
    NSMutableString* typeString = [[NSMutableString alloc] initWithString:@""];
    NSInteger count = [filterTypes count];
    for (NSInteger i = 0; i < count; i++) {
        if (i == count-1)
            [typeString appendString:[NSString stringWithFormat:@"%@", [[filterTypes objectAtIndex:i] tid]]];
        else
            [typeString appendString:[NSString stringWithFormat:@"%@,", [[filterTypes objectAtIndex:i] tid]]];
    }
    NSMutableString* brandString = [[NSMutableString alloc] initWithString:@""];
    count = [filterBrands count];
    for (NSInteger i = 0; i < count; i++) {
        if (i == count-1)
            [brandString appendString:[NSString stringWithFormat:@"%@", [[filterBrands objectAtIndex:i] bid]]];
        else
            [brandString appendString:[NSString stringWithFormat:@"%@,", [[filterBrands objectAtIndex:i] bid]]];
    }
    NSMutableString* storeString = [[NSMutableString alloc] initWithString:@""];
    count = [filterStores count];
    for (NSInteger i = 0; i < count; i++) {
        if (i == count-1)
            [storeString appendString:[NSString stringWithFormat:@"%@", [[filterStores objectAtIndex:i] sid]]];
        else
            [storeString appendString:[NSString stringWithFormat:@"%@,", [[filterStores objectAtIndex:i] sid]]];
    }
    NSMutableString* categoryString = [[NSMutableString alloc] initWithString:@""];
    count = [filterCategories count];
    for (NSInteger i = 0; i < count; i++) {
        if (i == count-1)
            [categoryString appendString:[NSString stringWithFormat:@"%@", [[filterCategories objectAtIndex:i] cid]]];
        else
            [categoryString appendString:[NSString stringWithFormat:@"%@,", [[filterCategories objectAtIndex:i] cid]]];
    }

    [searchBar resignFirstResponder];
    
    
    NSString *title = @"Kết Quả";
    
    //navController = [[UINavigationController alloc] init];
    //navController.delegate=self;
    [self.navigationController setDelegate:self];
    
    //[navController.view setFrame:CGRectMake(0, 0, 1024, 748)];
    
    //[navController.navigationBar setBarStyle:UIBarStyleBlack];
    
    APP_SERVICE(appSrvvv);
    [appSrvvv clearFilteredProducts];
    [appSrvvv loadFilteredProductFrom:0 to:15 hasKeywords:searchString hasTypes:typeString hasBrands:brandString ofStores:storeString inCategories:categoryString hasTopPrice:@"" hasBottomPrice:@""];
    
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] initForFilteredProductsWithKeywords:searchString TypeString:typeString BrandString:brandString StoreString:storeString CategoryString:categoryString hasTopPrice:@"" andBotPrice:@""];
    [appSrvvv setDelegate:productSliderViewController];
    //[productSliderViewController.navigationController.navigationBar ];
    //productSliderViewController.c_type = c_type;
    //productSliderViewController.c_category = c_category;
    //productSliderViewController.type = _type;
    //productSliderViewController.category = category;
    //productSliderViewController.navigationItem.title = title;
    productSliderViewController.title = title;
    
    //[self.view addSubview:navController.view];
    
    //[self.navController pushViewController:productSliderViewController animated:NO];
    [self.navigationController pushViewController:productSliderViewController animated:YES];
    
    //[productSliderViewController.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)]];
    
    //[navController setDelegate:productSliderViewController];
    [self.navigationController setDelegate:productSliderViewController];
    
    //[self.view addSubview:navController.view];
    
    //[self flipForDuration:0.75 withAnimation:UIViewAnimationTransitionFlipFromLeft];
    
    //    [UIView animateWithDuration:0.75 
    //                     animations:^{
    //                         
    //                     }
    //                     completion:^(BOOL finished) {
    //                         [self.view addSubview:navController.view];
    //                     }];
    [productSliderViewController release];
    
}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"didshow");
//}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"didshow");
//}
#pragma mark-
#pragma mark Application Service for loading typies
-(void)didFinishParsingType:(NSMutableDictionary *)typeDict andArray:(NSMutableArray *)typeArray
{
    _typeDict = typeDict;
    _typeArray = typeArray;
    
    //[self.view setBackgroundColor:[UIColor grayColor]];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //search
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    [searchBar setDelegate:self];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:searchBar]];
    
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
        
        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@%@%@", BASE_URL, RESOURCE_PATH, TYPIES_FOLDER, type.image];
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

#pragma mark searchbar delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)aSearchBar{
    NSLog(@"rect: x:%f y:%f w:%f h:%f", aSearchBar.frame.origin.x, aSearchBar.frame.origin.y, aSearchBar.frame.size.width, aSearchBar.frame.size.height);
    if (filterPopOver == nil) {
        filterPopOver = [[MyPopOverView alloc] initWithFilterType:filterTypes Brand:filterBrands Store:filterStores Categories:filterCategories];
        popoverController = [[UIPopoverController alloc] initWithContentViewController:filterPopOver];
        popoverController.passthroughViews = [NSArray arrayWithObject:aSearchBar];
        popoverController.delegate = self;
        [popoverController setPopoverContentSize:filterPopOver.view.frame.size];
        [popoverController presentPopoverFromRect:CGRectMake(817, 55, 200, 0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else
       [popoverController presentPopoverFromRect:CGRectMake(817, 55, 200, 0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
    [self didFinishSearchWithString:[aSearchBar text]];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar{
    [popoverController dismissPopoverAnimated:YES];
    //NSString *keywords = aSearchBar.text;
    //NSLog(@"%@", keywords);
    
    [aSearchBar resignFirstResponder];
}

#pragma mark - PopoverViewController Delegate Methods
-(void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [searchBar resignFirstResponder];
}

@end
