//
//  SubcategoryViewController.m
//  ipc
//
//  Created by SaRy on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubcategoryViewController.h"
#import "ProductSliderViewController.h"
#import "WebViewController.h"

@implementation SubcategoryViewController
@synthesize sex, myPopOver, popoverController;

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
    NSArray *subCategoryArray = [[NSArray alloc] initWithObjects:@"  ALL", @"  SHIRT", @"  T-SHIRT", @"  SWIMWEAR", @"  DESIGNED SHIRT", @"  SHORT", @"  SKIRT", @"  JEAN", @"  UNDERWARE", @"  CRAVAT", @"  TROUSER", @"  SPORT", @"  EYESWEAR", @"  ACCESSORY", @"  BAG", @"  WATCH", nil];
    NSArray *subImageArray = [[NSArray alloc] initWithObjects:@"sub_category1.png", @"sub_category2.png", @"sub_category3.png", @"sub_category4.png", @"sub_category5.png", @"sub_category6.png", @"sub_category7.png", @"sub_category8.png", @"sub_category9.png", @"sub_category10.png", @"sub_category11.png", @"sub_category12.png", @"sub_category13.png", @"sub_category14.png", @"sub_category15.png", @"sub_category16.png", nil];
    
    //search bar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [searchBar setDelegate:self];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    [searchBar release];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    BOOL overLoad = NO;
    NSInteger x = 25;
    NSInteger y = 45;
    NSInteger scrollWidth = 0;
    for (NSInteger i = 0; i < subCategoryArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[subImageArray objectAtIndex:i]];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 308, 100)];
        [button addTarget:self action:@selector(gotoSubCatalogue:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:normal];
        [button setTag:i];
        [button setTitle:[subCategoryArray objectAtIndex:i] forState:normal];
        [image release];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y+100, 308, 30)];
        [label setText:[subCategoryArray objectAtIndex:i]];
        //[label setAlpha:0.7];
        [label setTextAlignment:UITextAlignmentLeft];
        [label setBackgroundColor:[UIColor blackColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName: @"Helvetica" size: 32]];
        [scrollView addSubview:button];
        [scrollView addSubview:label];
        [button release];
        [label release];
        
        y = y + 45 + 100;
        overLoad = YES;
        if (y > 600){
            y = 45;
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
    scrollView.backgroundColor = [UIColor grayColor];
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
    NSInteger sub = ((UIButton *) sender).tag;
    
    ProductSliderViewController *productSliderViewController = [[ProductSliderViewController alloc] init];
    productSliderViewController.sex = sex;
    productSliderViewController.sub = sub;
    //productSliderViewController.navigationItem.title = title;
    productSliderViewController.title = title;
    
    [self.navigationController pushViewController:productSliderViewController animated:YES];
    
    [productSliderViewController release];
}

#pragma mark searchbar delegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    myPopOver = [[MyPopOverView alloc] initWithNibName:@"MyPopOverView" bundle:nil];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:myPopOver];
    
    
    [popoverController setPopoverContentSize:CGSizeMake(300.0f, 300.0f)];
    //		[popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // Or use the following line to display it from a given rectangle
    [popoverController presentPopoverFromRect:CGRectMake(824, 0, 200, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [popoverController dismissPopoverAnimated:YES];
}

@end
