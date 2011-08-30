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
    [self.view addSubview:labelBrand];
    
    labelStore = [[UILabel alloc] initWithFrame:CGRectMake(522, 160, 150, 40)];
    [labelStore setText:@"Sample Store"];
    [labelStore setHidden:YES];
    [self.view addSubview:labelStore];
    
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(522, 210, 150, 40)];
    [labelName setText:name];
    [labelName setHidden:YES];
    [self.view addSubview:labelName];
    
    labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(522, 270, 150, 40)];
    [labelPrice setHidden:YES];
    [labelPrice setText:price];
    [self.view addSubview:labelPrice];
    
    labelSize = [[UILabel alloc] initWithFrame:CGRectMake(522, 330, 400, 40)];
    [labelSize setHidden:YES];
    [labelSize setText:@"Available size: XXS XS S M L XL XXL"];
    [self.view addSubview:labelSize];
    
    labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(522, 390, 400, 40)];
    [labelDesc setText:desc];
    [labelDesc setHidden:YES];
    [self.view addSubview:labelDesc];
    
    like = [[UIButton alloc] initWithFrame:CGRectMake(522, 450, 50, 30)];
    [like setHidden:YES];
    [like setTitle:@"Like" forState:normal];
    [like.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
    [like.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [like setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:like];
    
    buy = [[UIButton alloc] initWithFrame:CGRectMake(900, 600, 50, 30)];
    [buy addTarget:self action:@selector(gotoShop:) forControlEvents:UIControlEventTouchUpInside];
    [buy setBackgroundColor:[UIColor blackColor]];
    [buy setTitle:@"Buy" forState:normal];
    [buy.titleLabel setFont:[UIFont fontWithName: @"Helvetica" size: 24]];
    [buy.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [self.view addSubview:buy];
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
        [thisButton setFrame:CGRectMake(px+margin, 0, thisButton.frame.size.width, thisButton.frame.size.height)];
        [self labelHiddenChage:!mode];
        [buy setFrame:CGRectMake(575, 450, 50, 30)];
        [buy setBackgroundColor:[UIColor redColor]];
        mode = NO;
    }else{
        NSInteger margin = 512-(button.frame.size.width/2);
        [thisButton setFrame:CGRectMake(margin, 0, thisButton.frame.size.width, thisButton.frame.size.height)];
        [self labelHiddenChage:!mode];
        [buy setFrame:CGRectMake(900, 600, 50, 30)];
        [buy setBackgroundColor:[UIColor blackColor]];
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
        [buy setFrame:CGRectMake(900, 600, 50, 30)];
        [buy setBackgroundColor:[UIColor blackColor]];
    }else{
        [loading setFrame:CGRectMake(223, 295, 66, 66)];
        NSInteger nx = (NSInteger) button.frame.origin.x % 1024;
        NSInteger px = button.frame.origin.x-nx;
        NSInteger margin = (512-button.frame.size.width)/2;
        [button setFrame:CGRectMake(px+margin, 0, button.frame.size.width, button.frame.size.height)];
        [self labelHiddenChage:cmode];
        [buy setFrame:CGRectMake(575, 450, 50, 30)];
        [buy setBackgroundColor:[UIColor redColor]];
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
