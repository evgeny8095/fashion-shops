//
//  ItemDetailsViewController.m
//  ipc
//
//  Created by SaRy on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemDetailsViewController.h"

@implementation ItemDetailsViewController


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
    NSArray *categoryImage = [[NSArray alloc] initWithObjects:@"image1.png", @"image2.png", @"image3.png", @"image4.png", @"image5.png", @"image6.png", @"image7.png", @"image8.png", @"image1.png", @"image2.png", @"image3.png", @"image4.png", @"image5.png", @"image6.png", @"image7.png", @"image8.png", nil];
    
    UIScrollView *imageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 450, 1024, 128)];
    
    [imageScroll setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat curXLoc = 0;
    for (NSInteger i = 0; i < categoryImage.count; i++) {
        UIImage *icon = [UIImage imageNamed:[categoryImage objectAtIndex:i]];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
        [icon release];
        CGRect rect = imageScroll.frame;

        rect.size.height = 128;
        rect.size.width = 128;
        iconView.tag = i;
        iconView.frame = rect;

        [imageScroll addSubview:iconView];
        
        CGRect frame = iconView.frame;
        frame.origin = CGPointMake(curXLoc, 0);
        iconView.frame = frame;
        
        curXLoc += (128);
        [iconView release];
    }
    
    imageScroll.pagingEnabled = NO;
    imageScroll.showsHorizontalScrollIndicator = YES;
    imageScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:imageScroll];
    
    imageScroll.showsHorizontalScrollIndicator = NO;
    imageScroll.showsVerticalScrollIndicator = NO;
    NSInteger scrollWidth = (categoryImage.count)*128;
	[imageScroll setContentSize:CGSizeMake(scrollWidth, [imageScroll bounds].size.height)];
    
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

@end
