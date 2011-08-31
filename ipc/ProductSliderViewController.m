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
#import "MyPopOverView.h"

@interface ProductSliderViewController (PrivateMethods)
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
@end

@implementation ProductSliderViewController
@synthesize buttons, sex, sub, myPopOver, popoverController, title;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)dealloc{
    [popoverController dismissPopoverAnimated:NO];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)filterProductList:(id)sender{
    if(![popoverController isPopoverVisible]){
		myPopOver = [[MyPopOverView alloc] initWithNibName:@"MyPopOverView" bundle:nil];
		popoverController = [[UIPopoverController alloc] initWithContentViewController:myPopOver];
        
        
		[popoverController setPopoverContentSize:CGSizeMake(250.0f, 200.0f)];
		[popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		
		// Or use the following line to display it from a given rectangle
        //		[popoverController presentPopoverFromRect:CGRectMake(10, 10, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}else{
		[popoverController dismissPopoverAnimated:YES];
	}

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    productArray = [[NSArray alloc] initWithObjects:@"Simple Product 1",@"Simple Product 2", @"Simple Product 3", @"Simple Product 4", @"Simple Product 5", @"Simple Product 6", @"Simple Product 7", @"Simple Product 8", @"Simple Product 9", @"Simple Product 10", nil];
    imageArray = [[NSArray alloc] initWithObjects:@"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", nil];
    imageURL = [[NSArray alloc] initWithObjects:@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/",@"http://www.ongsoft.com/ipc/", nil];
    baseURL = @"http://www.ongsoft.com/ipc/";
    
    //refine button
    UIBarButtonItem *filterButton = [[ UIBarButtonItem alloc] initWithTitle:@"Show Option" style:UIBarButtonItemStylePlain target:self action:@selector(filterProductList:)];
    self.navigationItem.rightBarButtonItem = filterButton;
    [filterButton release];
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.numberOfLines = 2;
//    titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
//    titleLabel.textAlignment = UITextAlignmentCenter;
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.text = self.title;
//    self.navigationItem.titleView = titleLabel;
    self.navigationItem.title = title;
    
    
    totalItem = [productArray count];
    if(sub == 0){
        totalItem = [productArray count]*15;
    }
    
    productSmallSlider = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    NSInteger sx = 0;
    NSInteger sy = 0;
    NSInteger smallSliderWidth;
    NSInteger smallImageWidth = 327;
    NSInteger smallImageHeight = 255;
    
    NSMutableArray *tempButtons = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < totalItem; i++)
    {
        //small slider
        UIButton *smallButton = [[UIButton alloc] initWithFrame:CGRectMake(sx, sy, smallImageHeight, smallImageWidth)];
        [smallButton setTag:i];
        [smallButton setBackgroundColor:[UIColor whiteColor]];
        [smallButton addTarget:self action:@selector(gotoProductDetails:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat padding = 10.0;
        [smallButton setImageEdgeInsets:UIEdgeInsetsMake(padding, padding, padding, padding)];
        
        sy = sy + 1 + smallImageWidth;
        if (sy > 600){
            sy = 0;
            sx = sx + smallImageHeight + 1;
        }
//        if (i % 8 == 7) {
//            //sx = sx + 2;
//            sx=sx;
//        }
		[tempButtons addObject:smallButton];
        [smallButton release];
    }
    
    self.buttons = tempButtons;
    [tempButtons release];
    for(UIButton *button in buttons){
        [productSmallSlider addSubview:button];
    }

    smallSliderWidth = (totalItem/8+1)*1024;
    productSmallSlider.pagingEnabled = YES;
    productSmallSlider.contentSize = CGSizeMake(smallSliderWidth, 655);
    productSmallSlider.backgroundColor = [UIColor grayColor];
    productSmallSlider.showsHorizontalScrollIndicator = YES;
    productSmallSlider.showsVerticalScrollIndicator = NO;
    productSmallSlider.delegate=self;
    
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

- (IBAction)gotoProductDetails:(id)sender{
    //NSString *title = ((UIButton *) sender).titleLabel.text;
    NSInteger page = ((UIButton *) sender).tag;
    
    
    BigProductSliderViewController *bigProductSliderViewController = [[BigProductSliderViewController alloc] initWithPage:page];
    bigProductSliderViewController.delegate = self;
    bigProductSliderViewController.navigationItem.title = [productArray objectAtIndex:page];
    bigProductSliderViewController.sex = sex;
    bigProductSliderViewController.sub = sub;
    bigProductSliderViewController.item = page;
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
    if(sub == 0){
        for (NSInteger i = offset; i < items; i++) {
            UIButton *button = [buttons objectAtIndex:i];
            if ([[button imageView] image] == NULL) {
                AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
                
                NSString *sexFolder = sex == 1 ? @"m" : @"f";
                NSInteger cSub = i/11+1;
                NSInteger cItem = i%10;
                if(i > 10 && cItem == 0)
                    cItem = 1;
                NSString *subFolder = [[NSString alloc] initWithFormat:@"%i/%i.png", cSub, cItem];
                NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@/%@", baseURL, sexFolder, subFolder];
                [sexFolder release];
                [subFolder release];
                
                NSURL* url = [NSURL URLWithString:urlPath];
                [urlPath release];
                
                [asyncImage loadImageFromURL:url forButton:button];
            }        
        }
    }else{
        for (NSInteger i = offset; i < items; i++) {
            UIButton *button = [buttons objectAtIndex:i];
            if ([[button imageView] image] == NULL) {
                AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
                
                NSString *sexFolder = sex == 1 ? @"m" : @"f";
                NSString *subFolder = [[NSString alloc] initWithFormat:@"%i/%i.png", sub, i+1];
                NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@/%@", baseURL, sexFolder, subFolder];
                [sexFolder release];
                [subFolder release];
                
                NSURL* url = [NSURL URLWithString:urlPath];
                [urlPath release];
                
                [asyncImage loadImageFromURL:url forButton:button];
            }        
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
