//
//  BigProductSliderViewController.m
//  ipc
//
//  Created by SaRy on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BigProductSliderViewController.h"

@implementation BigProductSliderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    NSArray *productArray = [[NSArray alloc] initWithObjects:@"San Pham 1",@"San Pham 2", @"San Pham 3", @"San Pham 4", @"San Pham 5", @"San Pham 6", @"San Pham 7", @"San Pham 8", @"San Pham 9", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 10", @"San Pham 11", @"San Pham 12", @"San Pham 13", @"San Pham 14", @"San Pham 15", @"San Pham 16", @"San Pham 17", @"San Pham 18", @"San Pham 19", @"San Pham 20", @"San Pham 21", @"San Pham 22", @"San Pham 23", @"San Pham 24", @"San Pham 25", @"San Pham 26", @"San Pham 27", @"San Pham 28", @"San Pham 29", @"San Pham 30", @"San Pham 31", @"San Pham 32", @"San Pham 33", @"San Pham 34", @"San Pham 35", @"San Pham 36", @"San Pham 37", @"San Pham 38", @"San Pham 39", @"San Pham 40", @"San Pham 41", @"San Pham 42", @"San Pham 43", @"San Pham 44", nil];
    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", nil];
    
    productBigSlider = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    NSInteger bx = 0;
    NSInteger by = 0;
    NSInteger bigSliderWidth;
    for (NSInteger i = 0; i < productArray.count; i++) {
        //image
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        NSInteger px = bx + (1024-image.size.width)/2;
        
        //big slider
        UIButton *bigButton = [[UIButton alloc] initWithFrame:CGRectMake(px, by, image.size.width, image.size.height)];
        //[bigButton setImage:image forState:normal];
        [bigButton setBackgroundImage:image forState:normal];
        [image release];
        //[bigButton setTitle:[productArray objectAtIndex:i] forState:normal];
        [bigButton addTarget:self action:@selector(revealDetails:) forControlEvents:UIControlEventTouchUpInside];
        [productBigSlider addSubview:bigButton];
        [bigButton release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(bx+522, 40, 100, 40)];
        [label setText:[productArray objectAtIndex:i]];
        [label setHidden:YES];
        [productBigSlider addSubview:label];
        [label release];
        
        bx = bx + 1024;
    }
    bigSliderWidth = bx;
    productBigSlider.pagingEnabled = YES;
    productBigSlider.contentSize = CGSizeMake(bigSliderWidth, 655);
    
    [self.view addSubview:productBigSlider];    
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

-(void)revealDetails:(id)sender{
    UIButton *button = (UIButton *) sender;
    NSInteger nx = (NSInteger) button.frame.origin.x % 1024;
    NSInteger px = button.frame.origin.x-nx;
    NSInteger margin = (512-button.frame.size.width)/2;
    [button setFrame:CGRectMake(px+margin, 0, button.frame.size.width, button.frame.size.height)];
    
}

@end
