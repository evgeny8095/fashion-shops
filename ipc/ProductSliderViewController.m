//
//  ProductSliderViewController.m
//  ipc
//
//  Created by SaRy on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProductSliderViewController.h"

@implementation ProductSliderViewController

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
    NSArray *productArray = [[NSArray alloc] initWithObjects:@"San Pham 1",@"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", nil];
    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", @"san_pham1.jpg", nil];
    
    productSmallSlider = [[UIScrollView alloc] initWithFrame:self.view.frame];
    productBigSlider = [[UIScrollView alloc] initWithFrame:self.view.frame];
    //productDetailSlider = [[UIScrollView alloc] init];
    
    NSInteger sx = 25, bx = 0;
    NSInteger sy = 25, by = 0;
    NSInteger smallSliderWidth, bigSliderWidth;
    for (NSInteger i = 0; i < productArray.count; i++) {
        //image
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [image stretchableImageWithLeftCapWidth:0 topCapHeight:655];
        
        //big slider
        //UIImageView *bigImageView = [[UIImageView alloc] initWithImage:image];
        UIButton *bigButton = [[UIButton alloc] initWithFrame:CGRectMake(bx, by, 1024, 655)];
        [bigButton setImage:image forState:normal];
        //[bigButton setTitle:[productArray objectAtIndex:i] forState:normal];
        [bigButton addTarget:self action:@selector(swapViewBigToSmall:) forControlEvents:UIControlEventTouchUpInside];
        [productBigSlider addSubview:bigButton];
        [bigButton release];
        
        bx = bx + 1024;
        
        //small slider
        UIButton *smallButton = [[UIButton alloc] initWithFrame:CGRectMake(sx, sy, 225, 290)];
        [smallButton setImage:image forState:normal];
        [smallButton setTitle:[productArray objectAtIndex:i] forState:normal];
        [smallButton addTarget:self action:@selector(swapViewSmallToBig:) forControlEvents:UIControlEventTouchUpInside];
        [productSmallSlider addSubview:smallButton];
        [smallButton release];
        
        sy = sy + 25 + 290;
        if (sy > 600){
            sy = 25;
            sx = sx + 225 + 25;
        }
        if (i % 8 == 7) {
            sx = sx + 25;
        }
        
        if (i % 8 == 1) {
            smallSliderWidth = sx + 749;
        }  
    }
    bigSliderWidth = bx;
    productSmallSlider.pagingEnabled = YES;
    productSmallSlider.contentSize = CGSizeMake(smallSliderWidth, 655);
    productSmallSlider.backgroundColor = [UIColor grayColor];
    productSmallSlider.showsHorizontalScrollIndicator = YES;
    productSmallSlider.showsVerticalScrollIndicator = NO;
    
    productBigSlider.pagingEnabled = YES;
    productBigSlider.contentSize = CGSizeMake(bigSliderWidth, 655);
    
    [self.view addSubview:productSmallSlider];
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

- (IBAction)swapViewSmallToBig:(id)sender{
    [productSmallSlider removeFromSuperview];
    [self.view addSubview:productBigSlider];
}

- (IBAction)swapViewBigToSmall:(id)sender{
    [productBigSlider removeFromSuperview];
    [self.view addSubview:productSmallSlider];
}

@end
