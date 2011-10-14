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

#define padding 10.0
#define bottomPadding 50.0
#define sidePadding 20.0


@interface ProductSliderViewController (PrivateMethods)
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
@end

@implementation ProductSliderViewController
@synthesize buttons, labels, secondLabels, type = _type, category = _category, myPopOver, popoverController, title, productScrollView;
@synthesize c_type, c_category;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        loadFrom = [[NSString alloc] initWithString:@""];
    }
    return self;
}

- (void)dealloc{
    [popoverController dismissPopoverAnimated:NO];
    //APP_SERVICE(appSrv4);
    //[appSrv4 clearProducts];
    [super dealloc];
}

-(id) initForFavoriteProducts:(NSString *)c_ids
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        ids = c_ids;
        loadFrom = [[NSString alloc] initWithString:@"favourite2"];
    }
    return self;
}

-(id) initForFeatureProducts
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        loadFrom = [[NSString alloc] initWithString:@"feature"];
    }
    return self;
}

-(id) initForSalesProducts
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        // Custom initialization
        loadFrom = [[NSString alloc] initWithString:@"sales"];
    }
    return self;
}

-(id) initWithProductArray:(NSMutableArray *)fproductArray
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        _productArray = fproductArray;
        loadFrom = [[NSString alloc] initWithString:@"favourite"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)filterProductList:(id)sender{
    if(![popoverController isPopoverVisible]){
		myPopOver = [[MyPopOverView alloc] initWithNibName:@"MyPopOverView" bundle:nil];
		popoverController = [[UIPopoverController alloc] initWithContentViewController:myPopOver];
        
        
		[popoverController setPopoverContentSize:CGSizeMake(300.0f, 300.0f)];
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
    //self.navigationItem.title = title;
    
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
    
    
    BigProductSliderViewController *bigProductSliderViewController = [[BigProductSliderViewController alloc] initWithPage:page andProducts:_productArray withTotal:totalItem];
    bigProductSliderViewController.delegate = self;
    bigProductSliderViewController.navigationItem.title = [[_productArray objectAtIndex:page] name];
    bigProductSliderViewController.type = _type;
    bigProductSliderViewController.category = _category;
    bigProductSliderViewController.item = page;
    //[bigProductSliderViewController.navigationItem.backBarButtonItem setTitle:@"ALL"];
    
    [self.navigationController pushViewController:bigProductSliderViewController animated:YES];
    
    [bigProductSliderViewController release];
}

#pragma mark Big....Delegate Method
-(void)finishSomething:(UIViewController *)sender withItemNumber:(NSInteger)number{
    NSInteger page = number/8;
    [productScrollView scrollRectToVisible:CGRectMake(1024*page, 0, 1024, 655) animated:NO];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= totalItem/8+1)
        return;
    NSInteger truePage = page + 1;
    
    NSInteger loadingPage = truePage+1;
    NSNumber *loaded = [loadedPage objectForKey:[NSString stringWithFormat:@"%i", page+1]];
    NSInteger loadedIndicator = [loaded intValue];
    
    if (loadedIndicator == 0 && loadingPage <= totalPages) {
        NSLog(@"loading page: %i", loadingPage);
        NSInteger start = (loadingPage)*8-8;
        NSInteger end = (loadingPage)*8-1;
        if (start < totalItem){
            APP_SERVICE(appSrv);
            if ([loadFrom isEqualToString:@"favourite2"])
                [appSrv loadProductsForProductIds:ids from:start to:end];
            if ([loadFrom isEqualToString:@"feature"])
                [appSrv loadProductsOfFeatureShopFrom:start to:end];
            if ([loadFrom isEqualToString:@"sales"])
                [appSrv loadProductsOnSalesFrom:start to:end];
            if ([loadFrom isEqualToString:@""])
                [appSrv loadProductsForType:c_type forCatetory:c_category from:start to:end];
            [loadedPage setObject:[NSNumber numberWithInteger:1] forKey:[NSString stringWithFormat:@"%i", page+1]];
        }        
    }
}

#pragma mark navigationcontroller delegate methods


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
    CGFloat pageWidth = productScrollView.frame.size.width;
    int page = floor((productScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
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

#pragma mark -
#pragma mark ApplicationServiceDelegate
-(void) didFinishParsing:(NSMutableArray*)c_productArray withTotalProduct:(NSInteger)total fromPostion:(NSInteger)start toPosition:(NSInteger)end
{
    if (start == 0) {
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(162, 0, 700, 44)];
        UILabel *titleString = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 700, 20)];
        [titleString setTextAlignment:UITextAlignmentCenter];
        [titleString setBackgroundColor:[UIColor clearColor]];
        [titleString setTextColor:[UIColor whiteColor]];
        [titleString setText:title];
        [titleView addSubview:titleString];
        UILabel *infoString = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 700, 14)];
        [infoString setTextAlignment:UITextAlignmentCenter];
        [infoString setTextColor:[UIColor whiteColor]];
        [infoString setBackgroundColor:[UIColor clearColor]];
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//        NSString *formattedString = [formatter stringFromNumber:[NSNumber numberWithInteger:total]];
        [infoString setText:[NSString stringWithFormat:@"%i sản phẩm", total]];
        [infoString setFont:[UIFont fontWithName:@"helvetica" size:12]];
        [titleView addSubview:infoString];
        self.navigationItem.titleView = titleView;
        [titleString release];
        [infoString release];
//        [formatter release];
//        [formattedString release];
        [titleView release];
        
        loadedPage = [[NSMutableDictionary alloc] init];
        totalPages = total/8+1;
        for (NSInteger i = 0; i<totalPages; i++) {
            [loadedPage setObject:[NSNumber numberWithInteger:0] forKey:[NSString stringWithFormat:@"%i", i]];
        }
        
        _productArray = c_productArray;
        NSLog(@"Number of loaded product %i", [_productArray count]);
        
        
        totalItem = total;
        
        //NSInteger c_numberProduct = [_productArray count];
        
        NSInteger sx = 0;
        NSInteger sy = 0;
        NSInteger smallSliderWidth;
        NSInteger smallImageWidth = 327;
        NSInteger smallImageHeight = 255;
        
        NSMutableArray *tempButtons = [[NSMutableArray alloc] init];
        NSMutableArray *tempLabels = [[NSMutableArray alloc] init];
        NSMutableArray *tempSecondLabels = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < totalItem; i++)
        {
            UIButton *smallButton = [[UIButton alloc] initWithFrame:CGRectMake(sx, sy, smallImageHeight, smallImageWidth)];
            [smallButton setBackgroundColor:[UIColor whiteColor]];
            [smallButton addTarget:self action:@selector(gotoProductDetails:) forControlEvents:UIControlEventTouchUpInside];
            [smallButton setTag:i];
            [smallButton setImageEdgeInsets:UIEdgeInsetsMake(padding, sidePadding, bottomPadding, sidePadding)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(sx, sy+287, 255, 20)];
            [label setTextAlignment:UITextAlignmentCenter];
            //[label setTextColor:[UIColor grayColor]];
            //[label setBackgroundColor:[UIColor redColor]];
            [label setText:@"Missing Information"];
            UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(sx, sy+307, 255, 20)];
            [secondLabel setTextAlignment:UITextAlignmentCenter];
            //[secondLabel setBackgroundColor:[UIColor blueColor]];
            [secondLabel setTextColor:[UIColor grayColor]];
            [secondLabel setText:@"Missing Information"];
            sy = sy + 1 + smallImageWidth;
            if (sy > 600){
                sy = 0;
                sx = sx + smallImageHeight + 1;
            }
            [tempButtons addObject:smallButton];
            [tempLabels addObject:label];
            [tempSecondLabels addObject:secondLabel];
            [smallButton release];
            [label release];
            [secondLabel release];
        }
        
        self.buttons = tempButtons;
        self.labels = tempLabels;
        self.secondLabels = tempSecondLabels;
        [tempButtons release];
        [tempLabels release];
        [tempSecondLabels release];
        for(UIButton *button in buttons){
            [productScrollView addSubview:button];
        }
        for(UILabel *label in labels){
            [productScrollView addSubview:label];
        }
        for(UILabel *label in secondLabels){
            [productScrollView addSubview:label];
        }
        
        smallSliderWidth = (totalItem/9+1)*1024;
        NSLog(@"scroll width: %i", smallSliderWidth);
        productScrollView.pagingEnabled = YES;
        productScrollView.contentSize = CGSizeMake(smallSliderWidth, 655);
        productScrollView.backgroundColor = [UIColor grayColor];
        productScrollView.showsHorizontalScrollIndicator = YES;
        productScrollView.showsVerticalScrollIndicator = NO;
        productScrollView.delegate=self;
        
        [self.view addSubview:productScrollView];
        [loadedPage setObject:[NSNumber numberWithInteger:1] forKey:@"0"];
        [loadedPage setObject:[NSNumber numberWithInteger:1] forKey:@"1"];
        [self loadScrollViewWithPage:0];
        [self loadScrollViewWithPage:1];
        
        [self loadPageWithProductsStartAt:start EndAt:end];
    }else{
        [self loadPageWithProductsStartAt:start EndAt:end];
    }
}

-(void) didFinishParsingProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end
{
    [self didFinishParsing:c_productArray withTotalProduct:total fromPostion:start toPosition:end];
}

-(void) didFinishParsingFavouriteProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end
{
    [self didFinishParsing:c_productArray withTotalProduct:total fromPostion:start toPosition:end];
}

-(void) didFinishParsingFeatureProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end
{
    [self didFinishParsing:c_productArray withTotalProduct:total fromPostion:start toPosition:end];
}

-(void) didFinishParsingSalesProduct:(NSMutableArray *)c_productArray withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end
{
    [self didFinishParsing:c_productArray withTotalProduct:total fromPostion:start toPosition:end];
}

-(void) loadPageWithProductsStartAt:(NSInteger)start EndAt:(NSInteger)end
{
    for (NSInteger i = start; i <= (end > totalItem-1 ? totalItem-1 : end) ; i++) {
        Product *product = [_productArray objectAtIndex:i];
        UIButton *button = [buttons objectAtIndex:i];
        UILabel *label = [labels objectAtIndex:i];
        UILabel *secondLabel = [secondLabels objectAtIndex:i];
        //[button setTag:[[product pid] intValue]];
        if ([[button imageView] image] == NULL) {
            AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
            
            NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@t-%@", BASE_URL, PRODUCT_FOLDER, [product image]];
            
            NSLog(@"product image: %@", urlPath);
            
            NSURL* url = [NSURL URLWithString:urlPath];
            [urlPath release];
            
            [asyncImage loadImageFromURL:url forButton:button];
        }
        NSString *labelString = [[NSString alloc] initWithFormat:@"%@" ,[product name]];
        [label setText:labelString];
        [labelString release];
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//        NSString *formattedString = [formatter stringFromNumber:[NSNumber numberWithInteger:[product price]]];
        NSString *secondLabelString = [[NSString alloc] initWithFormat:@"%i - %@", [product price], [[product store] name]];
        [secondLabel setText:secondLabelString];
//        [formatter release];
//        [formattedString release];
        [secondLabelString release];
        
    }
}

@end
