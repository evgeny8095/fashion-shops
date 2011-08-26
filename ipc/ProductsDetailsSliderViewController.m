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
    NSURL *curl = [NSURL URLWithString:imageStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:curl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(256, 0, 512, 655)];
    [button addTarget:self action:@selector(revealDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    NSLog(@"name: %@", self.name);
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(522, 100, 150, 40)];
    [labelName setText:name];
    [labelName setHidden:YES];
    [self.view addSubview:labelName];
    
    labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(522, 160, 150, 40)];
    [labelPrice setHidden:YES];
    [labelPrice setText:price];
    [self.view addSubview:labelPrice];
    
    labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(522, 210, 150, 40)];
    [labelDesc setText:desc];
    [labelDesc setHidden:YES];
    [self.view addSubview:labelDesc];
    
    buy = [[UIButton alloc] initWithFrame:CGRectMake(900, 600, 50, 30)];
    [buy addTarget:self action:@selector(gotoShop:) forControlEvents:UIControlEventTouchUpInside];
    //[buy setHidden:YES];
    [buy setBackgroundColor:[UIColor blackColor]];
    [buy setTitle:@"Buy" forState:normal];
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
        [labelName setHidden:NO];
        [labelPrice setHidden:NO];
        [labelDesc setHidden:NO];
        [buy setHidden:NO];
        mode = NO;
    }else{
        NSInteger margin = 512-(button.frame.size.width/2);
        [thisButton setFrame:CGRectMake(margin, 0, thisButton.frame.size.width, thisButton.frame.size.height)];
        [labelName setHidden:YES];
        [labelPrice setHidden:YES];
        [labelDesc setHidden:YES];
        [buy setHidden:NO];
        mode = YES;
    }
    [delegate changeMode:self withMode:mode];
}

- (void)changeViewMode:(BOOL)cmode{
    if(cmode){
        NSInteger margin = 512-(button.frame.size.width/2);
        [button setFrame:CGRectMake(margin, 0, button.frame.size.width, button.frame.size.height)];
        [labelName setHidden:YES];
        [labelPrice setHidden:YES];
        [labelDesc setHidden:YES];
    }else{
        NSInteger nx = (NSInteger) button.frame.origin.x % 1024;
        NSInteger px = button.frame.origin.x-nx;
        NSInteger margin = (512-button.frame.size.width)/2;
        [button setFrame:CGRectMake(px+margin, 0, button.frame.size.width, button.frame.size.height)];
        [labelName setHidden:NO];
        [labelPrice setHidden:NO];
        [labelDesc setHidden:NO];
        //[buy setHidden:NO];
    }
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
