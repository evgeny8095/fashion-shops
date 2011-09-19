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

#define buttonHeight 35
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

- (id)initwithProduct:(Product *)c_product inPosition:(NSInteger)position withMode:(BOOL)cmode
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
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //hardcode url
    NSString *sexFolder = _type == 1 ? @"m" : @"f";
    NSString *subFolder = [[NSString alloc] initWithFormat:@"%i/%@.jpg", _category, [_product image]];
    NSString *urlPath = [[NSString alloc] initWithFormat:@"%@%@/%@", BASE_URL, sexFolder, subFolder];
    [sexFolder release];
    [subFolder release];
    
    NSURL *curl = [NSURL URLWithString:urlPath];
    [urlPath release];
    NSURLRequest* request = [NSURLRequest requestWithURL:curl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    backCover = [[UIView alloc] initWithFrame:self.view.frame];
    [backCover setBackgroundColor:[UIColor blackColor]];
    [backCover setAlpha:0.5];
    [backCover setOpaque:YES];
    [backCover setHidden:YES];
    [self.view addSubview:backCover];
    
    //loading indicator
//    loading = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
//    [loading setCenter:CGPointMake(512, 327.5)];
//    [loading setAnimationImages:animationLoading];
//    [animationLoading release];
//    [loading setAnimationDuration:1];
//    [loading startAnimating];
//    [self.view addSubview:loading];
    
    //build-in loading indicator
    loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView setCenter:centerPoint];
    [loadingView startAnimating];
    [loadingView setHidesWhenStopped:YES];
    [self.view addSubview:loadingView];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(256, 0, 512, 655)];
    [button addTarget:self action:@selector(revealDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    labelBrand = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 50, 150, 40)];
    [labelBrand setText:@"Adidas"];
    [labelBrand setHidden:YES];
    [labelBrand setBackgroundColor:[UIColor clearColor]];
    [labelBrand setTextColor:[UIColor whiteColor]];
    [labelBrand setShadowColor:[UIColor blackColor]];
    [self.view addSubview:labelBrand];
    
    labelStore = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 110, 150, 40)];
    [labelStore setText:@"Sample Store"];
    [labelStore setHidden:YES];
    [labelStore setBackgroundColor:[UIColor clearColor]];
    [labelStore setTextColor:[UIColor whiteColor]];
    [labelStore setShadowColor:[UIColor blackColor]];
    [self.view addSubview:labelStore];
    
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 170, 500, 40)];
    [labelName setText:name];
    [labelName setHidden:YES];
    [labelName setBackgroundColor:[UIColor clearColor]];
    [labelName setTextColor:[UIColor whiteColor]];
    [labelName setShadowColor:[UIColor blackColor]];
    [labelName setFont:[UIFont boldSystemFontOfSize:24]];
    [self.view addSubview:labelName];
    
    labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding+buttonWidth+5, 230, 150, 40)];
    [labelPrice setHidden:YES];
    [labelPrice setText:price];
    [labelPrice setBackgroundColor:[UIColor clearColor]];
    [labelPrice setTextColor:[UIColor whiteColor]];
    [labelPrice setShadowColor:[UIColor blackColor]];
    [labelPrice setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:labelPrice];
    
    labelSize = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 290, 400, 40)];
    [labelSize setHidden:YES];
    [labelSize setText:@"Available size: XXS XS S M L XL XXL"];
    [labelSize setBackgroundColor:[UIColor clearColor]];
    [labelSize setTextColor:[UIColor whiteColor]];
    [labelSize setShadowColor:[UIColor blackColor]];
    [self.view addSubview:labelSize];
    
    descText = [[UITextView alloc] initWithFrame:CGRectMake(leftDetailsPadding, 350, 430, 100)];
    [descText setHidden:YES];
    [descText setText:@"This sample product has:\n* Brown/multicolor animal-print tech taffeta.\n* Drawstring with gold bead detail at spread collar front zip.\n* Long sleeves with elasticized cuffs may be scrunched.\n* Elasticized hem for ease of fit.\n* Polyester.\n* Imported of Italian material."];
    [descText setBackgroundColor:[UIColor clearColor]];
    [descText setTextColor:[UIColor whiteColor]];
    [descText setFont:[UIFont systemFontOfSize:18]];
    [descText setEditable:NO];
    [self.view addSubview:descText];
    
//    labelScreenShot = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 510, 400, 40)];
//    [labelScreenShot setHidden:YES];
//    [labelScreenShot setText:@"More preview:"];
//    
    
//    labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(leftDetailsPadding, 400, 400, 40)];
//    [labelDesc setText:desc];
//    [labelDesc setHidden:YES];
//    [self.view addSubview:labelDesc];
    
    like = [[UIButton alloc] initWithFrame:CGRectMake(leftDetailsPadding, 460, 50, 30)];
    [like setHidden:YES];
    [like setTitle:@"Like" forState:normal];
    [like.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
    [like.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [like setBackgroundColor:[UIColor redColor]];
    //[self.view addSubview:like];
    
    buy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buy.frame = CGRectMake(900, 600, buttonWidth, buttonHeight);
    [buy addTarget:self action:@selector(gotoShop:) forControlEvents:UIControlEventTouchUpInside];
    //[buy setBackgroundColor:[UIColor blackColor]];
    [buy setTitle:@"Buy" forState:UIControlStateNormal];
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
    [labelSize setHidden:cmode];
    [labelDesc setHidden:cmode];
    [descText setHidden:cmode];
    [like setHidden:cmode];
    [backCover setHidden:cmode];
}

- (void)buy:(id)sender{
    
}

- (IBAction)gotoShop:(id)sender{
    [delegate finishSomething:self withURL:@"http://www.ongsoft.com"];
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
    
    [imagex retain];
	[data release];
	data=nil;
}

@end
