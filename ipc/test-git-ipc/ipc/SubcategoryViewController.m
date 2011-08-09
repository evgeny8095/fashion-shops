//
//  SubcategoryViewController.m
//  ipc
//
//  Created by SaRy on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubcategoryViewController.h"
#import "ProductSliderViewController.h"

@implementation SubcategoryViewController

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
    NSArray *subCategoryArray = [[NSArray alloc] initWithObjects:@"All", @"Somi", @"Thun", @"Do Tam", @"Ao Kieu", @"Quan Short", @"Vay Dam", @"Jean", @"Underwear", @"Cavat Khan", @"Quan Tay", @"The Thao", @"Dam Bau", @"Mat Kinh", @"Trang Suc", @"Phu Kien", @"Vi bop", @"Dong Ho", @"Tui Sach", @"Thac Lung", nil];
    NSArray *subImageArray = [[NSArray alloc] initWithObjects:@"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", @"sub_category1.png", nil];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    BOOL overLoad = NO;
    NSInteger x = 25;
    NSInteger y = 25;
    NSInteger scrollWidth = 0;
    for (NSInteger i = 0; i < subCategoryArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[subImageArray objectAtIndex:i]];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 308, 100)];
        [button addTarget:self action:@selector(gotoSubCatalogue:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:normal];
        [image release];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y+80, 308, 20)];
        [label setText:[subCategoryArray objectAtIndex:i]];
        [label setAlpha:0.7];
        [label setTextAlignment:UITextAlignmentRight];
        [scrollView addSubview:button];
        [scrollView addSubview:label];
        [button release];
        [label release];
        
        y = y + 25 + 100;
        overLoad = YES;
        if (y > 600){
            y = 25;
            x = x + 308 + 25;
            overLoad = NO;
        }
        if (overLoad)
            scrollWidth = x + 308 + 25;
        else
            scrollWidth = x;
    }
    
    scrollView.pagingEnabled = NO;
    scrollView.contentSize = CGSizeMake(scrollWidth, 700);
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    [subCategoryArray release];
    [subImageArray release];
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

-(IBAction)gotoSubCatalogue:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    
    //ItemsViewController *itemsViewController = [[ItemsViewController alloc] init];
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] init];
    
    //itemsViewController.navigationItem.title = title;
    productSliderViewController.navigationItem.title = title;
    
    //[self.navigationController pushViewController:itemsViewController animated:YES];
    [self.navigationController pushViewController:productSliderViewController animated:YES];
    
    //[itemsViewController release];
    [productSliderViewController release];
}

@end
