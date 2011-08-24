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
@synthesize name;
@synthesize price;
@synthesize desc;

bool mode = YES;


- (id)initWithImage:(UIImage *)imagex hasName:(NSString *)strName hasPrice:(NSString *)strPrice hasDesc:(NSString *)strDesc{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.image = imagex;
        self.name = strName;
        self.price = strPrice;
        self.desc = strDesc;
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
    CGFloat x = (1024-image.size.width)/2;
    button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(revealDetails:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:normal];
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
    [buy setHidden:YES];
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
        [buy setHidden:YES];
        mode = YES;
    }
}

- (void)buy:(id)sender{
    
}

- (IBAction)gotoShop:(id)sender{
    WebViewController *webViewController = [[WebViewController alloc] init];
    [webViewController.navigationController setTitle:@"Web"];
//    UIViewController *topVC = (UIViewController *)self.parentViewController.navigationController.delegate;
//	[topVC.navigationController pushViewController:webViewController animated:YES];
//    [self.parentViewController.parentViewController.navigationController pushViewController:webViewController animated:YES];
//    [webViewController release];
    
}

@end
