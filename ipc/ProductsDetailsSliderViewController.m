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

@implementation ProductsDetailsSliderViewController
@synthesize image;
@synthesize imageStr;
@synthesize name;
@synthesize price;
@synthesize desc;
@synthesize delegate;

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
    UIImage *loading1 = [UIImage imageNamed:@"loading1.gif"];
    UIImage *loading2 = [UIImage imageNamed:@"loading2.gif"];
    UIImage *loading3 = [UIImage imageNamed:@"loading3.gif"];
    UIImage *loading4 = [UIImage imageNamed:@"loading4.gif"];
    UIImage *loading5 = [UIImage imageNamed:@"loading5.gif"];
    UIImage *loading6 = [UIImage imageNamed:@"loading6.gif"];
    NSArray *animationLoading = [[NSArray alloc] initWithObjects:loading1, loading2, loading3, loading4, loading5, loading6, nil];
    [loading1 release];
    [loading2 release];
    [loading3 release];
    [loading4 release];
    [loading5 release];
    [loading6 release];
    
    NSURL *curl = [NSURL URLWithString:imageStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:curl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    backCover = [[UIView alloc] initWithFrame:self.view.frame];
    [backCover setBackgroundColor:[UIColor blackColor]];
    [backCover setAlpha:0.5];
    [backCover setOpaque:YES];
    [backCover setHidden:YES];
    [self.view addSubview:backCover];
    
    loading = [[UIImageView alloc] initWithFrame:CGRectMake(479, 295, 66, 66)];
    loading.animationImages = animationLoading;
    [loading setAnimationDuration:1];
    [loading startAnimating];
    [self.view addSubview:loading];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(256, 0, 512, 655)];
    [animationLoading release];
    [button addTarget:self action:@selector(revealDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    labelBrand = [[UILabel alloc] initWithFrame:CGRectMake(522, 100, 150, 40)];
    [labelBrand setText:@"Adidas"];
    [labelBrand setHidden:YES];
    [labelBrand setBackgroundColor:[UIColor clearColor]];
    [labelBrand setTextColor:[UIColor whiteColor]];
    [labelBrand setShadowColor:[UIColor blackColor]];
    [self.view addSubview:labelBrand];
    
    labelStore = [[UILabel alloc] initWithFrame:CGRectMake(522, 160, 150, 40)];
    [labelStore setText:@"Sample Store"];
    [labelStore setHidden:YES];
    [labelStore setBackgroundColor:[UIColor clearColor]];
    [labelStore setTextColor:[UIColor whiteColor]];
    [labelStore setShadowColor:[UIColor blackColor]];
    [self.view addSubview:labelStore];
    
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(522, 220, 500, 40)];
    [labelName setText:name];
    [labelName setHidden:YES];
    [labelName setBackgroundColor:[UIColor clearColor]];
    [labelName setTextColor:[UIColor whiteColor]];
    [labelName setShadowColor:[UIColor blackColor]];
    [labelName setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:labelName];
    
    labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(622, 280, 150, 40)];
    [labelPrice setHidden:YES];
    [labelPrice setText:price];
    [labelPrice setBackgroundColor:[UIColor clearColor]];
    [labelPrice setTextColor:[UIColor whiteColor]];
    [labelPrice setShadowColor:[UIColor blackColor]];
    [labelPrice setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:labelPrice];
    
    labelSize = [[UILabel alloc] initWithFrame:CGRectMake(522, 340, 400, 40)];
    [labelSize setHidden:YES];
    [labelSize setText:@"Available size: XXS XS S M L XL XXL"];
    [labelSize setBackgroundColor:[UIColor clearColor]];
    [labelSize setTextColor:[UIColor whiteColor]];
    [labelSize setShadowColor:[UIColor blackColor]];
    [self.view addSubview:labelSize];
    
//    labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(522, 400, 400, 40)];
//    [labelDesc setText:desc];
//    [labelDesc setHidden:YES];
//    [self.view addSubview:labelDesc];
    
    like = [[UIButton alloc] initWithFrame:CGRectMake(522, 460, 50, 30)];
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
        NSInteger nx = (NSInteger) thisButton.frame.origin.x % 1024;
        NSInteger px = thisButton.frame.origin.x-nx;
        NSInteger margin = (512-button.frame.size.width)/2;
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationTransitionNone
						 animations:^{ thisButton.center = CGPointMake(256, 327.5); }
						 completion:^(BOOL finished) {
                             [thisButton setFrame:CGRectMake(px+margin, 0, thisButton.frame.size.width, thisButton.frame.size.height)];
						 }];
        //[thisButton setFrame:CGRectMake(px+margin, 0, thisButton.frame.size.width, thisButton.frame.size.height)];
        [self labelHiddenChage:!mode];
        [buy setFrame:CGRectMake(522, 280, buttonWidth, buttonHeight)];
        //[buy setBackgroundColor:[UIColor redColor]];
        //[self.view setBackgroundColor:[UIColor grayColor]];
        mode = NO;
    }else{
        NSInteger margin = 512-(button.frame.size.width/2);
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationTransitionNone
						 animations:^{ thisButton.center = CGPointMake(512, 327.5); }
						 completion:^(BOOL finished) {
                             [thisButton setFrame:CGRectMake(margin, 0, thisButton.frame.size.width, thisButton.frame.size.height)];
						 }];
        
        [self labelHiddenChage:!mode];
        [buy setFrame:CGRectMake(900, 600, buttonWidth, buttonHeight)];
        //[buy setBackgroundColor:[UIColor blackColor]];
        //[self.view setBackgroundColor:[UIColor whiteColor]];
        mode = YES;
    }
    [delegate changeMode:self withMode:mode];
}

- (void)changeViewMode:(BOOL)cmode{
    if(cmode){
        [loading setFrame:CGRectMake(479, 295, 66, 66)];
        NSInteger margin = 512-(button.frame.size.width/2);
        [button setFrame:CGRectMake(margin, 0, button.frame.size.width, button.frame.size.height)];
        [self labelHiddenChage:cmode];
        [buy setFrame:CGRectMake(900, 600, buttonWidth, buttonHeight)];
        //[buy setBackgroundColor:[UIColor blackColor]];
        //[self.view setBackgroundColor:[UIColor whiteColor]];
    }else{
        [loading setFrame:CGRectMake(223, 295, 66, 66)];
        NSInteger nx = (NSInteger) button.frame.origin.x % 1024;
        NSInteger px = button.frame.origin.x-nx;
        NSInteger margin = (512-button.frame.size.width)/2;
        [button setFrame:CGRectMake(px+margin, 0, button.frame.size.width, button.frame.size.height)];
        [self labelHiddenChage:cmode];
        [buy setFrame:CGRectMake(522, 280, buttonWidth, buttonHeight)];
        //[buy setBackgroundColor:[UIColor redColor]];
        //[self.view setBackgroundColor:[UIColor grayColor]];
    }
}

- (void)labelHiddenChage:(BOOL)cmode{
    [labelBrand setHidden:cmode];
    [labelStore setHidden:cmode];
    [labelName setHidden:cmode];
    [labelPrice setHidden:cmode];
    [labelSize setHidden:cmode];
    [labelDesc setHidden:cmode];
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
    [loading setHidden:YES];
    if (mode) {
        [button setImage:imagex forState:normal];
        NSInteger margin = 512-(button.frame.size.width/2);
        [button setFrame:CGRectMake(margin, 0, button.frame.size.width, button.frame.size.height)];
    }else{
        [button setImage:imagex forState:normal];
        NSInteger nx = (NSInteger) button.frame.origin.x % 1024;
        NSInteger px = button.frame.origin.x-nx;
        NSInteger margin = (512-button.frame.size.width)/2;
        [button setFrame:CGRectMake(px+margin, 0, button.frame.size.width, button.frame.size.height)];
    }
    
    [imagex retain];
	[data release]; //don't need this any more, its in the UIImageView now
	data=nil;
}

@end
