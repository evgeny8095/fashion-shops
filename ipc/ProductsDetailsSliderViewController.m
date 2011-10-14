//
//  ProductsDetailsSliderViewController.m
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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

- (id)initwithProduct:(Product *)c_product inPosition:(NSInteger)position ofTotal:(NSInteger)c_total withMode:(BOOL)cmode
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        //UIImage *imagex = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strImg]]];
        self.imageStr = [c_product image];
        //[imagex release];
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
        //UIImage *imagex = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strImg]]];
        self.imageStr = strImg;
        //[imagex release];
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
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@/%@", BASE_URL, PRODUCT_FOLDER, [_product image]];
    
    NSURL *curl = [NSURL URLWithString:urlPath];
    [urlPath release];
    NSURLRequest* request = [NSURLRequest requestWithURL:curl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //gradient backgound
    gradientView = [[SSGradientView alloc] initWithFrame:self.view.frame];
	//gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	//gradientView.topBorderColor = [UIColor colorWithRed:0.558f green:0.599f blue:0.643f alpha:1.0f];
	//gradientView.topInsetColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
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
    
    labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding+buttonWidth+10, 230, 150, 40)];
    [labelPrice setHidden:YES];
    [labelPrice setText:[NSString stringWithFormat:@"$ %i", [_product price]]];
    [labelPrice setBackgroundColor:[UIColor clearColor]];
    [labelPrice setTextColor:[UIColor whiteColor]];
    [labelPrice setShadowColor:[UIColor blackColor]];
    [labelPrice setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:labelPrice];
    
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
    //[more addSubview:moreLine];
    [moreLine release];
    UIImageView *location = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 16, 16)];
    UIImage *marker = [UIImage imageNamed:@"07-map-marker.png"];
    [location setImage:marker];
    //[marker release];
    [more addSubview:location];
    [location release];
    //[self.view addSubview:more];
    lineView = [[SSLineView alloc] initWithFrame:CGRectMake(leftDetailsPadding, 300, 400, 2)];
    //lineView = [[SSLineView alloc] initWithFrame:CGRectMake(leftDetailsPadding, 398, 400, 2)];
    [lineView setHidden:YES];
    [self.view addSubview:lineView];
    
    descText = [[UITextView alloc] initWithFrame:CGRectMake(leftDetailsPadding, 302, 430, 150)];
    //descText = [[UITextView alloc] initWithFrame:CGRectMake(leftDetailsPadding, 400, 430, 80)];
    [descText setHidden:YES];
    [descText setText:[_product desc]];
    [descText setBackgroundColor:[UIColor clearColor]];
    [descText setTextColor:[UIColor whiteColor]];
    [descText setFont:[UIFont systemFontOfSize:18]];
    [descText setEditable:NO];
    [descText setScrollEnabled:YES];
    [self.view addSubview:descText];
    
//    labelScreenShot = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 510, 400, 40)];
//    [labelScreenShot setHidden:YES];
//    [labelScreenShot setText:@"More preview:"];
//    
    
//    labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 400, 400, 40)];
//    [labelDesc setText:desc];
//    [labelDesc setHidden:YES];
//    [self.view addSubview:labelDesc];
    
//    like = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    like.frame = CGRectMake(855+buttonWidth, 600, buttonWidth, buttonHeight);
//    //[like setHidden:YES];
//    [like addTarget:self action:@selector(addToFavourite) forControlEvents:UIControlEventTouchUpInside];
//    [like setTitle:@"Like" forState:UIControlStateNormal];
//    [like.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
//    [like.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
//    [like setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:like];
    
    buy = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame = CGRectMake(850, 600, buttonWidth, buttonHeight);
    //UIImage *likeImage = [[UIImage imageNamed:@"btn-red.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0]
    [buy setBackgroundImage:[[UIImage imageNamed:@"btn-red.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(gotoShop:) forControlEvents:UIControlEventTouchUpInside];
    [buy setTitle:@"Buy" forState:UIControlStateNormal];
    [buy.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
    [buy.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [self.view addSubview:buy];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    infoBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 35)];
    [infoBar setBackgroundColor:[UIColor lightTextColor]];
    UILabel *priceAndStore = [[UILabel alloc] initWithFrame:CGRectMake(112, 0, 800, 35)];
    NSString *priceAndStoreString = [[NSString alloc] initWithFormat:@"%i - %@", [_product price], [[_product store] name]];
    [priceAndStore setText:priceAndStoreString];
    [priceAndStore setTextAlignment:UITextAlignmentCenter];
    [priceAndStore setBackgroundColor:[UIColor clearColor]];
    [priceAndStore setTextColor:[UIColor grayColor]];
    [infoBar addSubview:priceAndStore];
    [priceAndStore release];
    [priceAndStoreString release];
    UILabel *numberOf = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 35)];
    NSString *numberOfString = [[NSString alloc] initWithFormat:@"%i of %i", cPosition+1, total];
    [numberOf setText:numberOfString];
    [numberOf setTextAlignment:UITextAlignmentLeft];
    [numberOf setBackgroundColor:[UIColor clearColor]];
    [numberOf setTextColor:[UIColor grayColor]];
    [infoBar addSubview:numberOf];
    
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
    //[like setHidden:cmode];
    //[backCover setHidden:cmode];
    [lineView setHidden:cmode];
    [gradientView setHidden:cmode];
    [more setHidden:cmode];
    [infoBar setHidden:!cmode];
}

- (void)buy:(id)sender{
    
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

@end
