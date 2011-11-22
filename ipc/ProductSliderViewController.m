//
//  ProductSliderViewController.m
//  ipc
//
//  Created by SaRy on 8/3/11.
//  Copyright 2011 OngSoft. All rights reserved.
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
@synthesize type = _type, category = _category, myPopOver, popoverController, title, productScrollView;
@synthesize c_type, c_category;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        loadFrom = [[NSString alloc] initWithString:@""];
        viewIndex = 7;
    }
    return self;
}

- (void)dealloc{
    for (AsyncImageView *loader in imageLoaders)
        [loader setDelegate:nil];
    [imageLoaders release];
    [popoverController dismissPopoverAnimated:NO];
    APP_SERVICE(appSrv);
    [appSrv setViewIndex:-1];
    
    [title release];
    [productScrollView release];
    [buttons release];
    [labels release];
    labels = nil;
    [secondLabels release];
    secondLabels = nil;
    [pageControl release];
    [popoverController release];
    [myPopOver release];
    [loadedPage release];
    [loadFrom release];
    [infomationLabel release];
    [searchString release];
    [typeString release];
    [brandString release];
    [storeString release];
    [categoryString release];
    [topPrice release];
    [botPrice release];
    
    [super dealloc];
}

-(id) initForFavoriteProducts:(NSString *)c_ids
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        ids = c_ids;
        loadFrom = [[NSString alloc] initWithString:@"favourite2"];
        viewIndex = 3;
    }
    return self;
}

-(id) initForFeatureProducts
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        loadFrom = [[NSString alloc] initWithString:@"feature"];
        viewIndex = 2;
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
        viewIndex = 4;
    }
    return self;
}

-(id) initForFilteredProductsWithKeywords:(NSString*)c_keywords TypeString:(NSString *)types BrandString:(NSString *)brands StoreString:(NSString *)stores CategoryString:(NSString *)categories hasTopPrice:(NSString *)c_topPrice andBotPrice:(NSString *)c_botPrice
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        loadFrom = [[NSString alloc] initWithString:@"filter"];
        searchString = [c_keywords retain];
        typeString = [types retain];
        brandString = [brands retain];
        storeString = [stores retain];
        categoryString = [categories retain];
        topPrice = [c_topPrice retain];
        botPrice = [c_topPrice retain];
        viewIndex = 8;
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
        viewIndex = 3;
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
    NSInteger page = ((UIButton *) sender).tag;
    NSInteger index = page%8;
    
    Product *product = [_productPages objectForKey:[NSString stringWithFormat:@"%i", page/8+1]];
    if (product != nil) {
        BigProductSliderViewController *bigProductSliderViewController = [[BigProductSliderViewController alloc] initWithPage:page andProducts:_productArray withProductPages:_productPages andIndexInPage:index withTotal:totalItem];
        bigProductSliderViewController.delegate = self;
        bigProductSliderViewController.navigationItem.title = [[[_productPages objectForKey:[NSString stringWithFormat:@"%i", page/8+1]] objectAtIndex:page%8] name];
        bigProductSliderViewController.type = _type;
        bigProductSliderViewController.category = _category;
        bigProductSliderViewController.item = page;
        
        [self.navigationController pushViewController:bigProductSliderViewController animated:YES];
        
        [bigProductSliderViewController release];
    }
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
    
    NSInteger nextPage = truePage + 1;
    NSNumber *loaded = [loadedPage objectForKey:[NSString stringWithFormat:@"%i", page+1]];
    NSInteger loadedIndicator = [loaded intValue];
    
    if (loadedIndicator == 0 && nextPage <= totalPages) {
        //NSLog(@"loading page: %i", nextPage);
        NSInteger start = (nextPage)*8-8;
        NSInteger end = (nextPage)*8-1;
        if (start < totalItem){
            APP_SERVICE(appSrv);
            if ([loadFrom isEqualToString:@"favourite2"])
                [appSrv loadProductsForProductIds:ids from:start to:end inPage:nextPage];
            if ([loadFrom isEqualToString:@"feature"])
                [appSrv loadProductsOfFeatureShopFrom:start to:end inPage:nextPage];
            if ([loadFrom isEqualToString:@"sales"])
                [appSrv loadProductsOnSalesFrom:start to:end inPage:nextPage];
            if ([loadFrom isEqualToString:@"filter"])
                [appSrv loadFilteredProductFrom:start to:end inPage:nextPage hasKeywords:searchString hasTypes:typeString hasBrands:brandString ofStores:storeString inCategories:categoryString hasTopPrice:topPrice hasBottomPrice:botPrice];
            if ([loadFrom isEqualToString:@""])
                [appSrv loadProductsForType:c_type forCatetory:c_category from:start to:end inPage:nextPage];
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
-(void) didFinishParsing:(NSMutableArray*)c_productArray withPageDict:c_productPages withTotalProduct:(NSInteger)total fromPostion:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page
{
    if (start == 0 && page == -1) {
        NSInteger productTotal = total;
        loadedPage = [[NSMutableDictionary alloc] init];
        if ([loadFrom isEqualToString:@"feature"]) {
            APP_SERVICE(appSrv);
            productTotal = [[appSrv featureProductList] count];
        }
        totalPages = productTotal/8+1;        
        
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
        [infoString setText:[NSString stringWithFormat:@"%i sản phẩm", productTotal]];
        [infoString setFont:[UIFont fontWithName:@"helvetica" size:12]];
        [titleView addSubview:infoString];
        self.navigationItem.titleView = titleView;
        [titleString release];
        [infoString release];
        [titleView release];
        
        for (NSInteger i = 0; i<totalPages; i++) {
            [loadedPage setObject:[NSNumber numberWithInteger:0] forKey:[NSString stringWithFormat:@"%i", i]];
        }
        
        _productArray = c_productArray;
        _productPages = c_productPages;
        //NSLog(@"Number of loaded product %i", [_productArray count]);
        
        totalItem = productTotal;
        
        //NSLog(@"Total Products: %i", totalItem);
        
        //NSInteger c_numberProduct = [_productArray count];
        
        NSInteger sx = 0;
        NSInteger sy = 0;
        NSInteger smallSliderWidth;
        NSInteger smallImageWidth = 327;
        NSInteger smallImageHeight = 255;
        
        imageLoaders = [[NSMutableArray alloc] init];
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
            [smallButton setBackgroundImage:DEFAULT_LOADING_IMAGE_PRODUCT forState:UIControlStateNormal];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(sx, sy+287, 255, 20)];
            [label setTextAlignment:UITextAlignmentCenter];
            [label setText:@"Đang tải ..."];
            UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(sx, sy+307, 255, 20)];
            [secondLabel setTextAlignment:UITextAlignmentCenter];
            [secondLabel setTextColor:[UIColor grayColor]];
            [secondLabel setText:@""];
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
            AsyncImageView *asyncImage = [[AsyncImageView alloc] init];
            [imageLoaders addObject:asyncImage];
            [asyncImage release];
        }
        
        buttons = tempButtons;
        labels = tempLabels;
        secondLabels = tempSecondLabels;
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
        smallSliderWidth = (totalItem%8==0?totalItem/8:totalItem/8+1)*1024;
        //NSLog(@"scroll width: %i", smallSliderWidth);
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
    }else if (page == 1) {
        NSInteger productTotal = total;
        loadedPage = [[NSMutableDictionary alloc] init];
        if ([loadFrom isEqualToString:@"feature"]) {
            APP_SERVICE(appSrv);
            productTotal = [[appSrv featureProductList] count];
        }
        totalPages = productTotal/8+1;
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
        [infoString setText:[NSString stringWithFormat:@"%i sản phẩm", productTotal]];
        [infoString setFont:[UIFont fontWithName:@"helvetica" size:12]];
        [titleView addSubview:infoString];
        self.navigationItem.titleView = titleView;
        [titleString release];
        [infoString release];
        [titleView release];
        for (NSInteger i = 0; i<totalPages; i++) {
            [loadedPage setObject:[NSNumber numberWithInteger:0] forKey:[NSString stringWithFormat:@"%i", i]];
        }
        _productArray = c_productArray;
        _productPages = c_productPages;
        //NSLog(@"Number of loaded product %i", [_productArray count]);
        totalItem = productTotal;
        //NSLog(@"Total Products: %i", totalItem);
        NSInteger sx = 0;
        NSInteger sy = 0;
        NSInteger smallSliderWidth;
        NSInteger smallImageWidth = 327;
        NSInteger smallImageHeight = 255;
        
        buttons = [[NSMutableArray alloc] init];
        labels = [[NSMutableArray alloc] init];
        secondLabels = [[NSMutableArray alloc] init];
        imageLoaders = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < totalItem; i++)
        {
            UIButton *smallButton = [[UIButton alloc] initWithFrame:CGRectMake(sx, sy, smallImageHeight, smallImageWidth)];
            [smallButton setBackgroundColor:[UIColor whiteColor]];
            [smallButton addTarget:self action:@selector(gotoProductDetails:) forControlEvents:UIControlEventTouchUpInside];
            [smallButton setTag:i];
            [smallButton setImageEdgeInsets:UIEdgeInsetsMake(padding, sidePadding, bottomPadding, sidePadding)];
            [smallButton setBackgroundImage:DEFAULT_LOADING_IMAGE_PRODUCT forState:UIControlStateNormal];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(sx, sy+287, 255, 20)];
            [label setTextAlignment:UITextAlignmentCenter];
            [label setText:@"Đang tải ..."];
            UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(sx, sy+307, 255, 20)];
            [secondLabel setTextAlignment:UITextAlignmentCenter];
            [secondLabel setTextColor:[UIColor grayColor]];
            [secondLabel setText:@""];
            sy = sy + 1 + smallImageWidth;
            if (sy > 600){
                sy = 0;
                sx = sx + smallImageHeight + 1;
            }
            [buttons addObject:smallButton];
            [labels addObject:label];
            [secondLabels addObject:secondLabel];
            [smallButton release];
            [label release];
            [secondLabel release];
            AsyncImageView *asyncImage = [[AsyncImageView alloc] init];
            [imageLoaders addObject:asyncImage];
            [asyncImage release];
        }
        for(UIButton *button in buttons){
            [productScrollView addSubview:button];
        }
        for(UILabel *label in labels){
            [productScrollView addSubview:label];
        }
        for(UILabel *label in secondLabels){
            [productScrollView addSubview:label];
        }
        smallSliderWidth = (totalItem%8==0?totalItem/8:totalItem/8+1)*1024;
        //NSLog(@"scroll width: %i", smallSliderWidth);
        productScrollView.pagingEnabled = YES;
        productScrollView.contentSize = CGSizeMake(smallSliderWidth, 655);
        productScrollView.backgroundColor = [UIColor grayColor];
        productScrollView.showsHorizontalScrollIndicator = YES;
        productScrollView.showsVerticalScrollIndicator = NO;
        productScrollView.delegate=self;
        [self.view addSubview:productScrollView];
        [loadedPage setObject:[NSNumber numberWithInteger:1] forKey:@"0"];
        [self loadPageWithProductsForPage:page];
        [self loadScrollViewWithPage:0];
    }else{
        if (page != -1) {
            [self loadPageWithProductsForPage:page];
        }
        else{
            [self loadPageWithProductsStartAt:start EndAt:end];
        }
        
    }
}

-(void) didFinishParsingProduct:(NSMutableArray *)c_productArray withPageDict:(NSMutableDictionary *)c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page
{
    [self didFinishParsing:c_productArray withPageDict:c_productPages withTotalProduct:total fromPostion:start toPosition:end inPage:page];
}

-(void) didFinishParsingFavouriteProduct:(NSMutableArray *)c_productArray withPageDict:c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page
{
    [self didFinishParsing:c_productArray withPageDict:c_productPages withTotalProduct:total fromPostion:start toPosition:end inPage:page];
}

-(void) didFinishParsingFeatureProduct:(NSMutableArray *)c_productArray withPageDict:c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page
{
    [self didFinishParsing:c_productArray withPageDict:c_productPages withTotalProduct:total fromPostion:start toPosition:end inPage:page];
}

-(void) didFinishParsingSalesProduct:(NSMutableArray *)c_productArray withPageDict:c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page
{
    [self didFinishParsing:c_productArray withPageDict:c_productPages withTotalProduct:total fromPostion:start toPosition:end inPage:page];
}

-(void) didFinishParsingFilterProduct:(NSMutableArray *)c_productArray withPageDict:(NSMutableDictionary*)c_productPages withTotalProducts:(NSInteger)total fromPosition:(NSInteger)start toPosition:(NSInteger)end inPage:(NSInteger)page
{
    [self didFinishParsing:c_productArray withPageDict:c_productPages withTotalProduct:total fromPostion:start toPosition:end inPage:page];
}

-(void) loadPageWithProductsStartAt:(NSInteger)start EndAt:(NSInteger)end
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###,###"];
    [formatter setPositiveSuffix:@"₫"];
    for (NSInteger i = start; i <= (end > totalItem-1 ? totalItem-1 : end) ; i++) {
        Product *product = [_productArray objectAtIndex:i];
        UIButton *button = [buttons objectAtIndex:i];
        UILabel *label = [labels objectAtIndex:i];
        UILabel *secondLabel = [secondLabels objectAtIndex:i];
        if ([[button imageView] image] == NULL) {
            //AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
            AsyncImageView *asyncImage = [imageLoaders objectAtIndex:i];
            [asyncImage setDelegate:self];
            NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@%@t-%@", BASE_URL, RESOURCE_PATH, PRODUCT_FOLDER, [product image]];
            NSURL* url = [NSURL URLWithString:urlPath];
            [urlPath release];
            [asyncImage loadImageFromURL:url forButtonIndex:i];
        }
        NSString *labelString = [[NSString alloc] initWithFormat:@"%@" ,[product name]];
        [label setText:labelString];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [labelString release];
        
        NSInteger currentPrice = 0;
        if ([product discount]>0) {
            currentPrice = [product price] - ([product price]*[product discount]/100);
        }
        
        NSString *formattedPriceString = [formatter stringFromNumber:[NSNumber numberWithInteger:[product price]]];
        NSString *secondLabelString;
        if (currentPrice > 0) {
            NSString *formattedCurrentPriceString = [formatter stringFromNumber:[NSNumber numberWithInteger:currentPrice]];
            secondLabelString = [[NSString alloc] initWithFormat:@"(%@) - %@", formattedPriceString, formattedCurrentPriceString];
        }
        else
            secondLabelString = [[NSString alloc] initWithFormat:@"%@ - %@", formattedPriceString, [[product store] name]];
        [secondLabel setText:secondLabelString];
        [secondLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [secondLabelString release];
    }
    [formatter release];
}

- (void)loadPageWithProductsForPage:(NSInteger)page
{
    NSInteger start = page*8-8;
    NSInteger end = page*8-1;
    NSArray *currentProducts = [_productPages objectForKey:[NSString stringWithFormat:@"%i", page]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###,###"];
    [formatter setPositiveSuffix:@"₫"];
    for (NSInteger i = start; i <= (end > totalItem-1 ? totalItem-1 : end) ; i++) {
        Product *product = [currentProducts objectAtIndex:i-start];
        UIButton *button = [buttons objectAtIndex:i];
        UILabel *label = [labels objectAtIndex:i];
        UILabel *secondLabel = [secondLabels objectAtIndex:i];
        //[button setTag:[[product pid] intValue]];
        if ([[button imageView] image] == NULL) {
            //AsyncImageView *asyncImage = [[[AsyncImageView alloc] init] autorelease];
            AsyncImageView *asyncImage = [imageLoaders objectAtIndex:i];
            [asyncImage setDelegate:self];
            NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@%@t-%@", BASE_URL, RESOURCE_PATH, PRODUCT_FOLDER, [product image]];
            
            //NSLog(@"product image: %@", urlPath);
            
            NSURL* url = [NSURL URLWithString:urlPath];
            [urlPath release];
            
            //[asyncImage loadImageFromURL:url forButton:button];
            [asyncImage loadImageFromURL:url forButtonIndex:i];
        }
        NSString *labelString = [[NSString alloc] initWithFormat:@"%@" ,[product name]];
        [label setText:labelString];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [labelString release];
        
        NSInteger currentPrice = 0;
        if ([product discount]>0) {
            currentPrice = [product price]*[product discount]/100;
        }
        
        NSString *formattedPriceString = [formatter stringFromNumber:[NSNumber numberWithInteger:[product price]]];
        NSString *secondLabelString;
        if (currentPrice > 0) {
            NSString *formattedCurrentPriceString = [formatter stringFromNumber:[NSNumber numberWithInteger:currentPrice]];
            secondLabelString = [[NSString alloc] initWithFormat:@"(%@) - %@", formattedPriceString, formattedCurrentPriceString];
        }
        else
            secondLabelString = [[NSString alloc] initWithFormat:@"%@ - %@", formattedPriceString, [[product store] name]];
        [secondLabel setText:secondLabelString];
        [secondLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [secondLabelString release];
    }
    [formatter release];
}

#pragma mark - AsyncImageView delegate method
-(void) didFinishLoadingImage:(UIImage *)image forButtonIndex:(NSInteger)index
{
    [[buttons objectAtIndex:index] setImage:image forState:UIControlStateNormal];
}

@end
