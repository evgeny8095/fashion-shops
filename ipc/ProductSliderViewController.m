//
//  ProductSliderViewController.m
//  ipc
//
//  Created by SaRy on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProductSliderViewController.h"
#import "BigProductSliderViewController.h"
#import "asyncimageview.h"

@interface ProductSliderViewController (PrivateMethods)
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
@end

@implementation ProductSliderViewController
@synthesize buttons;

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
    NSArray *productArray = [[NSArray alloc] initWithObjects:@"San Pham 1",@"San Pham 2", @"San Pham 3", @"San Pham 4", @"San Pham 5", @"San Pham 6", @"San Pham 7", @"San Pham 8", @"San Pham 9", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 10", @"San Pham 11", @"San Pham 12", @"San Pham 13", @"San Pham 14", @"San Pham 15", @"San Pham 16", @"San Pham 17", @"San Pham 18", @"San Pham 19", @"San Pham 20", @"San Pham 21", @"San Pham 22", @"San Pham 23", @"San Pham 24", @"San Pham 25", @"San Pham 26", @"San Pham 27", @"San Pham 28", @"San Pham 29", @"San Pham 30", @"San Pham 31", @"San Pham 32", @"San Pham 33", @"San Pham 34", @"San Pham 35", @"San Pham 36", @"San Pham 37", @"San Pham 38", @"San Pham 39", @"San Pham 40", @"San Pham 41", @"San Pham 42", @"San Pham 43", @"San Pham 44", nil];
    imageArray = [[NSArray alloc] initWithObjects:@"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", nil];
    imageURL = [[NSArray alloc] initWithObjects:@"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", @"http://f.cl.ly/items/1n141M1l32300A1c1z1G/san_pham1a.png", nil];
    
    totalItem = [productArray count];
    //[self.navigationController setDelegate:self];
    
    productSmallSlider = [[UIScrollView alloc] initWithFrame:self.view.frame];
    productBigSlider = [[UIScrollView alloc] initWithFrame:self.view.frame];
    //productDetailSlider = [[UIScrollView alloc] init];
    
    NSInteger sx = 25, bx = 0;
    NSInteger sy = 25; //by = 0;
    NSInteger smallSliderWidth, bigSliderWidth;
    
    NSMutableArray *tempButtons = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < totalItem; i++)
    {
        //small slider
        UIButton *smallButton = [[UIButton alloc] initWithFrame:CGRectMake(sx, sy, 225, 290)];
        //[smallButton setImage:image forState:normal];
        [smallButton setTitle:self.navigationItem.title forState:normal];
        [smallButton setTag:i];
        [smallButton addTarget:self action:@selector(gotoProductDetails:) forControlEvents:UIControlEventTouchUpInside];
        //[productSmallSlider addSubview:smallButton];
        
        sy = sy + 25 + 290;
        if (sy > 600){
            sy = 25;
            sx = sx + 225 + 25;
        }
        if (i % 8 == 7) {
            sx = sx + 25;
        }
		[tempButtons addObject:smallButton];
        [smallButton release];
    }
    
    self.buttons = tempButtons;
    [tempButtons release];
    for(UIButton *button in buttons){
        [productSmallSlider addSubview:button];
    }

    smallSliderWidth = (totalItem/8+1)*1024;
    bigSliderWidth = bx;
    productSmallSlider.pagingEnabled = YES;
    productSmallSlider.contentSize = CGSizeMake(smallSliderWidth, 655);
    productSmallSlider.backgroundColor = [UIColor grayColor];
    productSmallSlider.showsHorizontalScrollIndicator = YES;
    productSmallSlider.showsVerticalScrollIndicator = NO;
    productSmallSlider.delegate=self;
    
    productBigSlider.pagingEnabled = YES;
    productBigSlider.contentSize = CGSizeMake(bigSliderWidth, 655);
    
    [self.view addSubview:productSmallSlider];
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
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

- (IBAction)swapViewSmallToBig:(id)sender{
    [productSmallSlider removeFromSuperview];
    [self.view addSubview:productBigSlider];
}

- (IBAction)swapViewBigToSmall:(id)sender{
    [productBigSlider removeFromSuperview];
    [self.view addSubview:productSmallSlider];
}

- (IBAction)gotoProductDetails:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    NSInteger page = ((UIButton *) sender).tag;
    
    BigProductSliderViewController *bigProductSliderViewController = [[BigProductSliderViewController alloc] initWithPage:page];
    bigProductSliderViewController.delegate = self;
    bigProductSliderViewController.navigationItem.title = title;
    [bigProductSliderViewController.navigationItem.backBarButtonItem setTitle:@"ALL"];
    
    [self.navigationController pushViewController:bigProductSliderViewController animated:YES];
    
    [bigProductSliderViewController release];
}

#pragma mark Big....Delegate Method
-(void)finishSomething:(UIViewController *)sender withItemNumber:(NSInteger)number{
    NSInteger page = number/8;
    [productSmallSlider scrollRectToVisible:CGRectMake(1024*page, 0, 1024, 655) animated:NO];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= totalItem/8+1)
        return;
    NSInteger truePage = page + 1;
    NSInteger items = truePage*8;
    items = items > totalItem ? totalItem : items;
    NSInteger offset = page*8;
    for (NSInteger i = offset; i < items; i++) {
        UIButton *button = [buttons objectAtIndex:i];
        if ([[button imageView] image] == NULL) {
            //UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
            NSURL* url = [NSURL URLWithString:[imageURL objectAtIndex:i]];
            [asyncImage loadImageFromURL:url forButton:button];
        }        
    }
}


#pragma mark scroll controller delegate
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
    CGFloat pageWidth = productSmallSlider.frame.size.width;
    int page = floor((productSmallSlider.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    if(page!=(totalItem/8))
    {
        [self loadScrollViewWithPage:page - 1];
        [self loadScrollViewWithPage:page];
        [self loadScrollViewWithPage:page + 1];
    }
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

@end
