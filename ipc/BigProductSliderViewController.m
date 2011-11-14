//
//  BigProductSliderViewController.m
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BigProductSliderViewController.h"
#import "ProductsDetailsSliderViewController.h"
#import "WebViewController.h"

@interface BigProductSliderViewController (PrivateMethods)
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
@end

@implementation BigProductSliderViewController
@synthesize scrollView, pageControl, viewControllers, delegate, type = _type, category = _category, item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPage:(int)page andProducts:(NSMutableArray *)products withProductPages:(NSDictionary*)pages andIndexInPage:(NSInteger)index withTotal:(NSInteger)total
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        cpage = page;
        viewMode = YES;
        _productArray = products;
        _productPages = pages;
        _index = index;
        numberOfPages = total;
        loadedPage = [[NSMutableDictionary alloc] init];
        for (NSInteger i = 0; i<numberOfPages; i++) {
            [loadedPage setObject:[NSNumber numberWithInteger:0] forKey:[NSString stringWithFormat:@"%i", i]];
        }
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc{
    //[_productArray release];
    [super dealloc];
}

- (void)favAction:(id)sender
{
    //Product *product = [_productArray objectAtIndex:cpage];
    Product *product = [[_productPages objectForKey:[NSString stringWithFormat:@"%i", cpage/8+1]] objectAtIndex:cpage%8];
    FAV_SERVICE(favSrv);
    [favSrv addFavouriteProduct:[[product pid] intValue]];
    [self checkFavProduct:product];
}

- (void)unFavAction:(id)sender
{
    //Product *product = [_productArray objectAtIndex:cpage];
    Product *product = [[_productPages objectForKey:[NSString stringWithFormat:@"%i", cpage/8+1]] objectAtIndex:cpage%8];
    FAV_SERVICE(favSrv);
    [favSrv removeFavouriteProduct:[[product pid] intValue]];
    [self checkFavProduct:product];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    baseURL = @"http://www.ongsoft.com/ipc/";
    
    UIImage *favImage = [UIImage imageNamed:@"heart2.png"];
    UIImage *unFavImage = [UIImage imageNamed:@"heart1.png"];
    UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [favButton setFrame:CGRectMake(0, 0, 27, 25)];
    [favButton setImage:favImage forState:UIControlStateNormal];
    [favButton addTarget:self action:@selector(unFavAction:) forControlEvents:UIControlEventTouchUpInside];
    favBarButton = [[UIBarButtonItem alloc] initWithCustomView:favButton];
    UIButton *unFavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [unFavButton setFrame:CGRectMake(0, 0, 27, 25)];
    [unFavButton setImage:unFavImage forState:UIControlStateNormal];
    [unFavButton addTarget:self action:@selector(favAction:) forControlEvents:UIControlEventTouchUpInside];
    unFavBarButton = [[UIBarButtonItem alloc] initWithCustomView:unFavButton];
    
//    UIView *container = [[UIView alloc] init];
//    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    customButton.frame = CGRectMake(0, 0, 130, 44);
//    [customButton setImage:likeImage forState:UIControlStateNormal];
//    [container addSubview:customButton];
//    
//    UIBarButtonItem *customBarButton = [[UIBarButtonItem alloc] initWithCustomView:container];
//    self.navigationItem.rightBarButtonItem = customBarButton;
    
    //numberOfPages = [_productArray count];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < numberOfPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(1024 * numberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.backgroundColor=[UIColor grayColor];
    scrollView.delegate = self;
    
    pageControl.currentPage = 0;
    if (cpage > 0) {
        [self loadScrollViewWithPage:cpage-1];
        [self loadScrollViewWithPage:cpage];
        [self loadScrollViewWithPage:cpage+1];
        [scrollView scrollRectToVisible:CGRectMake(1024*cpage, 0, 1024, 655) animated:NO];
    }else{
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
    }
    
    [self.view addSubview:scrollView];
    
    infoBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 35)];
    [infoBar setBackgroundColor:[UIColor grayColor]];
    [infoBar setAlpha:0.4];
    UILabel *priceAndStore = [[UILabel alloc] initWithFrame:CGRectMake(112, 0, 800, 35)];
    [priceAndStore setTag:1];
//    NSString *priceAndStoreString = [[NSString alloc] initWithFormat:@"%@ - %@", formattedPriceString, [[_product store] name]];
//    [priceAndStore setText:priceAndStoreString];
    [priceAndStore setTextAlignment:UITextAlignmentCenter];
    [priceAndStore setBackgroundColor:[UIColor clearColor]];
    [priceAndStore setTextColor:[UIColor blackColor]];
    [infoBar addSubview:priceAndStore];
    [priceAndStore release];
//    [priceAndStoreString release];
    
    UILabel *numberOf = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 35)];
    [numberOf setTag:2];
//    NSString *numberOfString = [[NSString alloc] initWithFormat:@"%i of %i", cPosition+1, total];
//    [numberOf setText:numberOfString];
    [numberOf setTextAlignment:UITextAlignmentLeft];
    [numberOf setBackgroundColor:[UIColor clearColor]];
    [numberOf setTextColor:[UIColor blackColor]];
    [infoBar addSubview:numberOf];
    [numberOf release];
    //[self changeInfoBarForProduct:[_productArray objectAtIndex:cpage] inPage:cpage inTotal:numberOfPages];
    [self changeInfoBarForProduct:[[_productPages objectForKey:[NSString stringWithFormat:@"%i", cpage/8+1]] objectAtIndex:cpage%8] inPage:cpage inTotal:numberOfPages];
    
    [self.view addSubview:infoBar];
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

-(void)revealDetails:(id)sender{
    UIButton *button = (UIButton *) sender;
    NSInteger nx = (NSInteger) button.frame.origin.x % 1024;
    NSInteger px = button.frame.origin.x-nx;
    NSInteger margin = (512-button.frame.size.width)/2;
    [button setFrame:CGRectMake(px+margin, 0, button.frame.size.width, button.frame.size.height)];    
}

- (void)gotoDetails:(id)sender{
    
}

- (void)changePage:(id)sender{
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= numberOfPages)
        return;
    
    NSNumber *loaded = [loadedPage objectForKey:[NSString stringWithFormat:@"%i", page]];
    NSInteger loadedIndicator = [loaded intValue];
    
    
    // replace the placeholder if necessary
    ProductsDetailsSliderViewController *controller = [viewControllers objectAtIndex:page];
    if (loadedIndicator == 0) {
        if ((NSNull *)controller == [NSNull null])
        {
            //controller = [[ProductsDetailsSliderViewController alloc] initwithProduct:[_productArray objectAtIndex:page] inPosition:page ofTotal:numberOfPages withMode:viewMode];
            controller = [[ProductsDetailsSliderViewController alloc] initwithProduct:[[_productPages objectForKey:[NSString stringWithFormat:@"%i", page/8+1]] objectAtIndex:page%8] inPosition:page ofTotal:numberOfPages withMode:viewMode];
            controller.type = _type;
            controller.category = _category;
            
            controller.delegate = self;
            [viewControllers replaceObjectAtIndex:page withObject:controller];
            //[controller release];
        }else{
            [controller changeViewMode:viewMode];
        }
        
        // add the controller's view to the scroll view
        if (controller.view.superview == nil)
        {
            CGRect frame = scrollView.frame;
            frame.origin.x = frame.size.width * page;
            frame.origin.y = 0;
            controller.view.frame = frame;
            [scrollView addSubview:controller.view];
        }
        [loadedPage setObject:[NSNumber numberWithInteger:1] forKey:[NSString stringWithFormat:@"%i", page]];
    }
    else if ((NSNull *)controller != [NSNull null]){
        [controller changeViewMode:viewMode];
    }
    if (cpage == page) {
        //[self checkFavProduct:[_productArray objectAtIndex:cpage]];
        [self checkFavProduct:[[_productPages objectForKey:[NSString stringWithFormat:@"%i", cpage/8+1]] objectAtIndex:cpage%8]];
    }
    
    //[self changeInfoBarForProduct:[_productArray objectAtIndex:page] inPage:page inTotal:numberOfPages];
    [self changeInfoBarForProduct:[[_productPages objectForKey:[NSString stringWithFormat:@"%i", cpage/8+1]] objectAtIndex:cpage%8] inPage:page inTotal:numberOfPages];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    [delegate finishSomething:self withItemNumber:page];
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    if(page < numberOfPages && page >= 0)
    {
        [self loadScrollViewWithPage:page];
        [self loadScrollViewWithPage:page - 1];
        [self loadScrollViewWithPage:page + 1];
        //self.navigationItem.title = [[_productArray objectAtIndex:page] name];
        self.navigationItem.title = [[[_productPages objectForKey:[NSString stringWithFormat:@"%i", page/8+1]] objectAtIndex:page%8] name];
        
        //[self changeInfoBarForProduct:[_productArray objectAtIndex:page] inPage:page inTotal:numberOfPages];
        [self changeInfoBarForProduct:[[_productPages objectForKey:[NSString stringWithFormat:@"%i", page/8+1]] objectAtIndex:page%8] inPage:page inTotal:numberOfPages];
        
        cpage = page;
    }
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

#pragma mark Product..Delegate
-(void) finishSomething:(UIViewController *)sender withURL:(NSString *)url
{
    WebViewController *webViewController = [[WebViewController alloc] initWithStringURL:url];
    [webViewController.navigationController setTitle:@"Web"];
    [self.navigationController pushViewController:webViewController animated:YES];
    [webViewController release];
}

-(void) changeMode:(UIViewController *)sender withMode:(BOOL)modeToChange{
    viewMode = modeToChange;
    [infoBar setHidden:!modeToChange];
}

-(void) checkFavProduct:(Product*)product
{
    FAV_SERVICE(favSrv);
    if ([[favSrv favouriteProducts] containsObject:[product pid]]) {
        self.navigationItem.rightBarButtonItem = favBarButton;
    }else{
        self.navigationItem.rightBarButtonItem = unFavBarButton;
    }
}

-(void) changeInfoBarForProduct:(Product *)product inPage:(NSInteger)page inTotal:(NSInteger)total
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###,###"];
    [formatter setPositiveSuffix:@"₫"];
    
    NSInteger currentPrice = 0;
    if ([product discount]>0) {
        currentPrice = [product price]*[product discount]/100;
    }
    
    NSString *formattedPriceString = [formatter stringFromNumber:[NSNumber numberWithInteger:[product price]]];
    NSString *priceAndStoreString;
    if (currentPrice > 0) {
        NSString *formattedCurrentPriceString = [formatter stringFromNumber:[NSNumber numberWithInteger:currentPrice]];
        priceAndStoreString = [[NSString alloc] initWithFormat:@"(%@) - %@ - %@", formattedPriceString, formattedCurrentPriceString, [[product store] name]];
    }
    else
        priceAndStoreString = [[NSString alloc] initWithFormat:@"%@ - %@", formattedPriceString, [[product store] name]];
    [((UILabel*)[infoBar viewWithTag:1]) setText:priceAndStoreString];
    [priceAndStoreString release];
    
    NSString *numberOfString = [[NSString alloc] initWithFormat:@"%i of %i", page+1, numberOfPages];
    [((UILabel*)[infoBar viewWithTag:2]) setText:numberOfString];
    [numberOfString release];
    [formatter release];
}

@end