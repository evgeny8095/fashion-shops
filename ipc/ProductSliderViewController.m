//
//  ProductSliderViewController.m
//  ipc
//
//  Created by SaRy on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProductSliderViewController.h"
#import "BigProductSliderViewController.h"

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
    NSArray *productArray = [[NSArray alloc] initWithObjects:@"San Pham 1",@"San Pham 2", @"San Pham 3", @"San Pham 4", @"San Pham 5", @"San Pham 6", @"San Pham 7", @"San Pham 8", @"San Pham 9", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 1", @"San Pham 10", @"San Pham 11", @"San Pham 12", @"San Pham 13", @"San Pham 14", @"San Pham 15", @"San Pham 16", @"San Pham 17", @"San Pham 18", @"San Pham 19", @"San Pham 20", @"San Pham 21", @"San Pham 22", @"San Pham 23", @"San Pham 24", @"San Pham 25", @"San Pham 26", @"San Pham 27", @"San Pham 28", @"San Pham 29", @"San Pham 30", @"San Pham 31", @"San Pham 32", @"San Pham 33", @"San Pham 34", @"San Pham 35", @"San Pham 36", @"San Pham 37", @"San Pham 38", @"San Pham 39", @"San Pham 40", @"San Pham 41", @"San Pham 42", @"San Pham 43", @"San Pham 44", nil];
    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", @"san_pham1a.png", nil];
    
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
        [smallButton setTitle:self.navigationItem.title forState:normal];
        [smallButton addTarget:self action:@selector(gotoProductDetails:) forControlEvents:UIControlEventTouchUpInside];
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

- (IBAction)gotoProductDetails:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    
    BigProductSliderViewController *bigProductSliderViewController = [[BigProductSliderViewController alloc] init];
    
    bigProductSliderViewController.navigationItem.title = title;
    bigProductSliderViewController.navigationController.navigationBar.backItem.title = @"All";
    
    [self.navigationController pushViewController:bigProductSliderViewController animated:YES];
    
    [bigProductSliderViewController release];
}

@end
