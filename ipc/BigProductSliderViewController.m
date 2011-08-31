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
@synthesize productBigSlider, scrollView, pageControl, viewControllers, delegate, sex, sub, item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPage:(int)page
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        cpage = page;
        viewMode = YES;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)likeAction:(id)sender{
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.navigationController setDelegate:self];
    productArray = [[NSArray alloc] initWithObjects:@"Simple Product 1",@"Simple Product 2", @"Simple Product 3", @"Simple Product 4", @"Simple Product 5", @"Simple Product 6", @"Simple Product 7", @"Simple Product 8", @"Simple Product 9", @"Simple Product 10", nil];
    imageArray = [[NSArray alloc] initWithObjects:@"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", nil];
    imageURL = [[NSArray alloc] initWithObjects:@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/", nil];
    baseURL = @"http://www.ongsoft.com/ipc/";
    
    UIImage *likeImage = [UIImage imageNamed:@"29-heart.png"];
    UIBarButtonItem *likeButton = [[UIBarButtonItem alloc] initWithImage:likeImage style:UIBarButtonItemStyleBordered target:self action:@selector(likeAction:)];
    [likeImage release];
    self.navigationItem.rightBarButtonItem = likeButton;
    [likeButton release];
    
    numberOfPages = [productArray count];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < numberOfPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    //productBigSlider = [[UIScrollView alloc] initWithFrame:self.view.frame];
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
    
    // replace the placeholder if necessary
    ProductsDetailsSliderViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        NSString *sexFolder = sex == 1 ? @"m" : @"f";
        NSString *subFolder = [[NSString alloc] initWithFormat:@"%i/%i.png", sub, page+1];
        NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@/%@", baseURL, sexFolder, subFolder];
        [sexFolder release];
        [subFolder release];
        
        controller = [[ProductsDetailsSliderViewController alloc] initWithImage:urlPath hasName:[productArray objectAtIndex:page] hasPrice:@"$1000" hasDesc:@"Simple Product mau" inPosition:page withMode:viewMode];
        [urlPath release];
        
        controller.delegate = self;
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
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
    if(page < numberOfPages && page > 0)
    {
        [self loadScrollViewWithPage:page];
        [self loadScrollViewWithPage:page - 1];
        [self loadScrollViewWithPage:page + 1];
        self.navigationItem.title = [productArray objectAtIndex:page];
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
}

@end