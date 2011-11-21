//
//  SubcategoryViewController.m
//  ipc
//
//  Created by SaRy on 8/2/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "SubcategoryViewController.h"
#import "ProductSliderViewController.h"
#import "WebViewController.h"
#import "Category.h"

#define buttonHeight 167.5
#define buttonWidth 206
#define buttonSpacing 40
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

- (void)dealloc
{
    for (AsyncImageView *loader in imageLoaders)
        [loader setDelegate:nil];
    [imageLoaders release];
    
    APP_SERVICE(appSrv);
    [appSrv setViewIndex:-1];
    
    [popoverController release];
    [myPopOver release];
    [topButton release];
    [subCategoryScrollView release];
    [loading release];
    [buttons release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [next setHidden:YES];
    [previous setHidden:YES];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //top banner
    AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
    [asyncImage setDelegate:self];
    NSString *bannerURL = [NSString stringWithFormat:@"%@%@%@", BASE_URL, RESOURCE_PATH, @"images/banners/sub_banner5.png"];
    NSURL *bannerImageURL = [NSURL URLWithString:bannerURL];
    //[asyncImage loadImageFromURL:bannerImageURL forButton:topButton];
    [asyncImage loadImageFromURL:bannerImageURL forButtonIndex:-1];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(IBAction)gotoSubCatalogue:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    NSInteger category = ((UIButton *) sender).tag;
    
    APP_SERVICE(appSrv);
    [appSrv setViewIndex:7];
    [appSrv setHomeViewIndex:7];
    NSDictionary *types = [appSrv typeDict];
    NSDictionary *categories = [appSrv categoryDict];
    Type* c_type = [types objectForKey:[NSString stringWithFormat:@"%i", _type]];
    Category* c_category = [categories objectForKey:[NSString stringWithFormat:@"%i", category]];
    
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] init];
    [appSrv loadProductsForType:c_type forCatetory:c_category from:0 to:7 inPage:1];
    [appSrv setDelegate2:productSliderViewController];
    productSliderViewController.c_type = c_type;
    productSliderViewController.c_category = c_category;
    productSliderViewController.type = _type;
    productSliderViewController.category = category;
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
    imageLoaders = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [buttons addObject:button];
        [button release];
        AsyncImageView *asyncImage = [[AsyncImageView alloc] init];
        [imageLoaders addObject:asyncImage];
        [asyncImage release];
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        Category* category = [_categoryArray objectAtIndex:i];
        
        //AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
        AsyncImageView *asyncImage = [imageLoaders objectAtIndex:i];
        [asyncImage setDelegate:self];
        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@%@%@", BASE_URL, RESOURCE_PATH, CATEGORIES_FOLDER, category.image];
        NSURL* url = [NSURL URLWithString:urlPath];
        [urlPath release];
        
        //[asyncImage loadImageFromURL:url forButton:[buttons objectAtIndex:i]];
        [asyncImage loadImageFromURL:url forButtonIndex:i];
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        Category* category = [_categoryArray objectAtIndex:i];
        UIButton* button = [buttons objectAtIndex:i];
        [button setFrame:CGRectMake(px, py, buttonWidth, buttonHeight)];
        [button addTarget:self action:@selector(gotoSubCatalogue:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:DEFAULT_LOADING_IMAGE_CATEGORY forState:UIControlStateNormal];
        [button setTag:[category.cid intValue]];
        [button setTitle:category.name forState:normal];
        [button setBackgroundColor:[UIColor blackColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(px, py, buttonWidth, labelHeight)];
        [label setText:[category.name uppercaseString]];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
        [subCategoryScrollView addSubview:button];
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

#pragma mark - AsyncImageView delegate method
-(void) didFinishLoadingImage:(UIImage *)image forButtonIndex:(NSInteger)index
{
    if (index == -1)
        [topButton setImage:image forState:UIControlStateNormal];
    else
        [[buttons objectAtIndex:index] setImage:image forState:UIControlStateNormal];
}

@end
