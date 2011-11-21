//
//  ProductsDetailsSliderViewController.m
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "ProductsDetailsSliderViewController.h"
#import "WebViewController.h"
#import "SubcategoryViewController.h"

#define buttonHeight 40
#define buttonWidth 90
#define animationDuration 0.1
#define centerPoint CGPointMake(512,327.5)
#define leftPoint CGPointMake(256,327.5)
#define leftDetailsPadding 550

@implementation ProductsDetailsSliderViewController
@synthesize image;
@synthesize imageStr;
@synthesize name;
@synthesize price;
@synthesize desc;
@synthesize delegate;
@synthesize product = _product;
@synthesize type = _type;
@synthesize category = _category;
@synthesize popoverController;
@synthesize infoCollectorViewController;

- (id)initwithProduct:(Product *)c_product inPosition:(NSInteger)position ofTotal:(NSInteger)c_total withMode:(BOOL)cmode
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.imageStr = [c_product image];
        self.name = [c_product name];
        self.price = [NSString stringWithFormat:@"%i",[c_product price]];
        self.desc = [c_product desc];
        cPosition = position;
        total = c_total;
        mode = cmode;
        _product = c_product;
    }
    
    return self;
}

- (id)initWithImage:(NSString *)strImg hasName:(NSString *)strName hasPrice:(NSString *)strPrice hasDesc:(NSString *)strDesc inPosition:(NSInteger)position withMode:(BOOL)cmode{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.imageStr = strImg;;
        self.name = strName;
        self.price = strPrice;
        self.desc = strDesc;
        cPosition = position;
        mode = cmode;
    }

    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //custom init
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
    [_product release];
    [imageStr release];
    [image release];
    [button release];
    [name release];
    [price release];
    [desc release];
    [descText release];
    [buy release];
    [like release];
    [labelBrand release];
    [labelStore release];
    [labelName release];
    [labelPrice release];
    [labelDesc release];
    [labelScreenShot release];
    [backCover release];
    [url release];
    [connection release];
    [data release];
    [loadingView release];
    [more release];
    [lineView release];
    [gradientView release];
    [popoverController release];
    [infoCollectorViewController release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@%@/%@", BASE_URL, RESOURCE_PATH, PRODUCT_FOLDER, [_product image]];
    
    NSURL *curl = [NSURL URLWithString:urlPath];
    [urlPath release];
    NSURLRequest* request = [NSURLRequest requestWithURL:curl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //gradient backgound
    gradientView = [[SSGradientView alloc] initWithFrame:self.view.frame];
	gradientView.colors = [NSArray arrayWithObjects:
							[UIColor darkGrayColor],
							[UIColor blackColor],
							nil];
	gradientView.bottomBorderColor = [UIColor colorWithRed:0.428f green:0.479f blue:0.520f alpha:1.0f];
    [gradientView setHidden:YES];
	[self.view addSubview:gradientView];
    
    //build-in loading indicator
    loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView setCenter:centerPoint];
    [loadingView startAnimating];
    [loadingView setHidesWhenStopped:YES];
    [self.view addSubview:loadingView];
    
    //
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(256, 0, 512, 655)];
    [button addTarget:self action:@selector(revealDetails:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    labelBrand = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 30, 150, 40)];
    [labelBrand setText:[[_product brand] name]];
    [labelBrand setHidden:YES];
    [labelBrand setBackgroundColor:[UIColor clearColor]];
    [labelBrand setTextColor:[UIColor whiteColor]];
    [labelBrand setShadowColor:[UIColor blackColor]];
    [self.view addSubview:labelBrand];
    
    labelStore = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 70, 150, 40)];
    [labelStore setText:[[_product store] name]];
    [labelStore setHidden:YES];
    [labelStore setBackgroundColor:[UIColor clearColor]];
    [labelStore setTextColor:[UIColor whiteColor]];
    [labelStore setShadowColor:[UIColor blackColor]];
    [labelStore setFont:[UIFont fontWithName:@"Helvetiva" size:24]];
    [self.view addSubview:labelStore];
    
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 100, 450, 120)];
    [labelName setText:[_product name]];
    [labelName setHidden:YES];
    [labelName setNumberOfLines:2];
    [labelName setLineBreakMode:UILineBreakModeWordWrap];
    [labelName setBackgroundColor:[UIColor clearColor]];
    [labelName setTextColor:[UIColor whiteColor]];
    [labelName setShadowColor:[UIColor blackColor]];
    [labelName setFont:[UIFont boldSystemFontOfSize:30]];
    [labelName setFont:[UIFont fontWithName:@"Helvetica" size:30]];
    
    [self.view addSubview:labelName];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###,###"];
    [formatter setPositiveSuffix:@"₫"];
    
    labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding+buttonWidth+10, 230, 360, 40)];
    [labelPrice setHidden:YES];

    NSString *formattedPriceString;
    if ([_product discount] > 0) {
        NSInteger currentPrice = [_product price] - ([_product price]*[_product discount]/100);
        NSString *currentPriceFormatted = [formatter stringFromNumber:[NSNumber numberWithInteger:currentPrice]];
        NSString *priceFormatted = [formatter stringFromNumber:[NSNumber numberWithInteger:[_product price]]];
        formattedPriceString = [NSString stringWithFormat:@"%@ (%@)", currentPriceFormatted, priceFormatted];
    }else{
        formattedPriceString = [formatter stringFromNumber:[NSNumber numberWithInteger:[_product price]]];
    }
    
    [labelPrice setText:[NSString stringWithFormat:@"%@", formattedPriceString]];
    [labelPrice setBackgroundColor:[UIColor clearColor]];
    [labelPrice setTextColor:[UIColor whiteColor]];
    [labelPrice setShadowColor:[UIColor blackColor]];
    [labelPrice setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:labelPrice];
    
    [formatter release];
    
    more = [[SSGradientView alloc] initWithFrame:CGRectMake(leftDetailsPadding, 290, 400, 100)];
    more.topBorderColor = [UIColor colorWithRed:0.558f green:0.599f blue:0.643f alpha:1.0f];
	more.topInsetColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
	more.colors = [NSArray arrayWithObjects:
                           [UIColor blackColor],
                           [UIColor grayColor],
                           nil];
	more.bottomBorderColor = [UIColor colorWithRed:0.428f green:0.479f blue:0.520f alpha:1.0f];
    [more setHidden:YES];
    SSLineView *moreLine = [[SSLineView alloc] initWithFrame:CGRectMake(0, 49, 400, 2)];
    [moreLine release];
    UIImageView *location = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 16, 16)];
    UIImage *marker = [UIImage imageNamed:@"07-map-marker.png"];
    [location setImage:marker];
    [more addSubview:location];
    [location release];
    lineView = [[SSLineView alloc] initWithFrame:CGRectMake(leftDetailsPadding, 300, 400, 2)];
    [lineView setHidden:YES];
    [self.view addSubview:lineView];
    
    descText = [[UITextView alloc] initWithFrame:CGRectMake(leftDetailsPadding, 302, 430, 200)];
    [descText setHidden:YES];
    [descText setText:[_product desc]];
    [descText setBackgroundColor:[UIColor clearColor]];
    [descText setTextColor:[UIColor whiteColor]];
    [descText setFont:[UIFont systemFontOfSize:18]];
    [descText setEditable:NO];
    [descText setScrollEnabled:YES];
    [self.view addSubview:descText];
    
    buy = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame = CGRectMake(850, 600, buttonWidth, buttonHeight);
    [buy setBackgroundImage:[[UIImage imageNamed:@"btn-red.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    [buy setTitle:@"Mua" forState:UIControlStateNormal];
    [buy.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
    [buy.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [self.view addSubview:buy];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
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

- (void)revealDetails:(id)sender{
        UIButton *thisButton = (UIButton *) sender;
    if(mode){
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationTransitionNone
						 animations:^{ thisButton.center = leftPoint; loadingView.center = leftPoint; }
						 completion:^(BOOL finished) {
                             //do something when finish animation go here
						 }];
        [self labelHiddenChage:!mode];
        [buy setFrame:CGRectMake(leftDetailsPadding, 230, buttonWidth, buttonHeight)];
        mode = NO;
    }else{
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationTransitionNone
						 animations:^{ thisButton.center = centerPoint; loadingView.center = centerPoint; }
						 completion:^(BOOL finished) {
                             //do something when finish animation go here
						 }];
        
        [self labelHiddenChage:!mode];
        [buy setFrame:CGRectMake(900, 600, buttonWidth, buttonHeight)];
        mode = YES;
    }
    [delegate changeMode:self withMode:mode];
}

- (void)changeViewMode:(BOOL)cmode{
    if(cmode){
        [loadingView setCenter:centerPoint];
        [button setCenter:centerPoint];
        [self labelHiddenChage:cmode];
        [buy setFrame:CGRectMake(900, 600, buttonWidth, buttonHeight)];
    }else{
        [loadingView setCenter:leftPoint];
        [button setCenter:leftPoint];
        [self labelHiddenChage:cmode];
        [buy setFrame:CGRectMake(leftDetailsPadding, 230, buttonWidth, buttonHeight)];
    }
}

- (void)labelHiddenChage:(BOOL)cmode{
    [labelBrand setHidden:cmode];
    [labelStore setHidden:cmode];
    [labelName setHidden:cmode];
    [labelPrice setHidden:cmode];
    [labelDesc setHidden:cmode];
    [descText setHidden:cmode];
    [lineView setHidden:cmode];
    [gradientView setHidden:cmode];
    [more setHidden:cmode];
}

- (void)buy:(id)sender{
    REQ_SERVICE(reqSrv);
    [reqSrv setPid:[_product pid]];
    if ([reqSrv isInfoNull]) {
        infoCollectorViewController = [[InfoCollectorViewController alloc] initWithNibName:@"InfoCollectorViewController" bundle:nil];
        [infoCollectorViewController setPid:[_product pid]];
        [infoCollectorViewController setDelegate:self];
        popoverController = [[UIPopoverController alloc] initWithContentViewController:infoCollectorViewController];
        [popoverController setPopoverContentSize:infoCollectorViewController.view.frame.size];
        [popoverController presentPopoverFromRect:((UIButton*)sender).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else
    {
        PUR_SERVICE(purSrv);
        if ([[purSrv purchasedProducts] containsObject:[_product pid]]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông Báo" message:@"Quý khách đã từng mua sản phẩm này" delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:@"Mua lại", nil];
            [alertView show];
            [alertView release];
        }else{
            [purSrv addPurchasedProduct:[[_product pid] intValue]];
            [reqSrv sentSingleProductRequest];
        }
    }
}

- (IBAction)gotoShop:(id)sender{
    [delegate finishSomething:self withURL:[_product url]];
}

//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; } 
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	[connection release];
	connection=nil;
    
	UIImage *imagex = [UIImage imageWithData:data];
    [loadingView stopAnimating];
    if (mode)
        [button setImage:imagex forState:normal];
    else
        [button setImage:imagex forState:normal];
    [button adjustsImageWhenHighlighted];
    
	[data release];
	data=nil;
}

#pragma mark - InfoCollector Delegate Methods
-(void)didSaveAndSentSuccessfuly
{
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }
}

#pragma mark - UIAlertView Delegate Methods
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Mua lại"]) {
        REQ_SERVICE(reqSrv);
        [reqSrv setPid:[_product pid]];
        [reqSrv sentSingleProductRequest];
    }
}

@end
