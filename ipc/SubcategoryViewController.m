//
//  SubcategoryViewController.m
//  ipc
//
//  Created by SaRy on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubcategoryViewController.h"
#import "ProductSliderViewController.h"
#import "WebViewController.h"
#import "Category.h"

//#define buttonHeight 195
//#define buttonWidth 233.5
#define buttonHeight 167.5
#define buttonWidth 206
#define buttonSpacing 40
//#define topPadding 100
//#define sidePadding 5
#define topPadding 100
#define sidePadding 5
#define labelHeight 40
#define scrollContentHeight 400


@implementation SubcategoryViewController
@synthesize type = _type, myPopOver, popoverController, topButton, subCategoryScrollView, loading;
@synthesize next, previous;

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
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [next setHidden:YES];
    [previous setHidden:YES];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    //search ba
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
//    [searchBar setDelegate:self];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
//    [searchBar release];
    
    //top banner
    AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
    NSString *bannerURL = [NSString stringWithFormat:@"%@%@%@", BASE_URL, RESOURCE_PATH, @"images/banners/sub_banner5.png"];
    NSURL *bannerImageURL = [NSURL URLWithString:bannerURL];
//    UIImage *bannerImage = [[UIImage alloc] initWithData:[[NSData dataWithContentsOfURL:bannerImageURL] autorelease]];
//    if (bannerImage == nil) {
//        [bannerImage release];
//        bannerImage = [UIImage imageNamed:@"banner.jpg"];
//    }
//    [topButton setImage:bannerImage forState:UIControlStateNormal];
//    [bannerImage release];
    [asyncImage loadImageFromURL:bannerImageURL forButton:topButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

-(IBAction)gotoSubCatalogue:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    NSInteger category = ((UIButton *) sender).tag;
    
    APP_SERVICE(appSrvvv);
    NSDictionary *types = [appSrvvv typeDict];
    NSDictionary *categories = [appSrvvv categoryDict];
    Type* c_type = [types objectForKey:[NSString stringWithFormat:@"%i", _type]];
    Category* c_category = [categories objectForKey:[NSString stringWithFormat:@"%i", category]];
    [appSrvvv loadProductsForType:c_type forCatetory:c_category from:0 to:15];
    
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] init];
    [appSrvvv setDelegate:productSliderViewController];
    productSliderViewController.c_type = c_type;
    productSliderViewController.c_category = c_category;
    productSliderViewController.type = _type;
    productSliderViewController.category = category;
    //productSliderViewController.navigationItem.title = [title uppercaseString];
    productSliderViewController.title = [title uppercaseString];
    
    [self.navigationController pushViewController:productSliderViewController animated:YES];
    
    [productSliderViewController release];
}

#pragma mark searchbar delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    myPopOver = [[MyPopOverView alloc] initWithNibName:@"MyPopOverView" bundle:nil];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:myPopOver];
    
    
    [popoverController setPopoverContentSize:CGSizeMake(300.0f, 300.0f)];
    //		[popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // Or use the following line to display it from a given rectangle
    [popoverController presentPopoverFromRect:CGRectMake(824, 0, 200, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [popoverController dismissPopoverAnimated:YES];
}

#pragma mark -
#pragma mark appservice delegate
-(void) didFinishParsingCategory:(NSMutableDictionary*)c_categoryDict andArray:(NSMutableArray *)c_categoryArray
{
    [loading stopAnimating];
    _categoryDict = c_categoryDict;
    _categoryArray = c_categoryArray;
    if ([_categoryArray count]>=8) {
        [next setHidden:NO];
    }
    BOOL overLoad;
    NSInteger px = 0;
    NSInteger py = 0;
    NSInteger scrollWidth = 0;
    
    NSInteger count = [_categoryArray count];

    buttons = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [buttons addObject:button];
        [button release];
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        Category* category = [_categoryArray objectAtIndex:i];
        
        AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
        
        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@%@%@", BASE_URL, RESOURCE_PATH, CATEGORIES_FOLDER, category.image];
        NSURL* url = [NSURL URLWithString:urlPath];
        [urlPath release];
        
        [asyncImage loadImageFromURL:url forButton:[buttons objectAtIndex:i]];
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        //Category* current = [_categoryDict objectForKey:key];
        Category* category = [_categoryArray objectAtIndex:i];
        UIButton* button = [buttons objectAtIndex:i];
       // UIImage *image = [UIImage imageNamed:current.image];
        //UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(px, py, buttonWidth, buttonHeight)];
        [button setFrame:CGRectMake(px, py, buttonWidth, buttonHeight)];
        [button addTarget:self action:@selector(gotoSubCatalogue:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:DEFAULT_LOADING_IMAGE_CATEGORY forState:UIControlStateNormal];
        
        //[button setImageEdgeInsets:UIEdgeInsetsMake(topPadding, sidePadding, sidePadding, sidePadding)];
        
        //[button setImage:image forState:normal];
        //[button setImage:[images objectAtIndex:i] forState:UIControlStateNormal];
        [button setTag:[category.cid intValue]];
        [button setTitle:category.name forState:normal];
        [button setBackgroundColor:[UIColor blackColor]];
        //[image release];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(px, py, buttonWidth, labelHeight)];
        [label setText:[category.name uppercaseString]];
        //[label setAlpha:0.7];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
        [subCategoryScrollView addSubview:button];
        //[subCategoryScrollView addSubview:label];
        //[button release];
        [label release];
        
        py = py + buttonSpacing + buttonHeight;
        overLoad = YES;
        
        if (py > scrollContentHeight){
            py = 0;
            px = px + buttonSpacing + buttonWidth;
            overLoad = NO;
        }
        
        if (i==count-1 && overLoad)
            scrollWidth = px + buttonWidth;
        else
            scrollWidth = px - buttonSpacing;
    }
    
    [subCategoryScrollView setContentSize:CGSizeMake(scrollWidth, subCategoryScrollView.frame.size.height)];
    [subCategoryScrollView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    [subCategoryScrollView setDelegate:self];
}

#pragma mark --
#pragma mark Scroll View Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = subCategoryScrollView.frame.size.width;
    int page = floor((subCategoryScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page == 0) {
        [next setHidden:NO];
        [previous setHidden:YES];
    }
   // NSInteger total = [_categoryArray count]%8 == 0?[_categoryArray count]/8:[_categoryArray count]/8+1;
    if (page == [_categoryArray count]/8) {
        [next setHidden:YES];
        [previous setHidden:NO];
    }
    if (page > 0 && page < [_categoryArray count]/8) {
        [next setHidden:NO];
        [previous setHidden:NO];
    }
}


#pragma mark --
#pragma mark UINavigationController delegate method
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        APP_SERVICE(appSrv);
        [appSrv clearProducts];
    }
}

@end
