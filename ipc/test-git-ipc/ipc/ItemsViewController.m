//
//  ItemsViewController.m
//  ipc
//
//  Created by SaRy on 7/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemDetailsViewController.h"

@implementation ItemsViewController

@synthesize itemLabel;

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
    
    NSArray *itemName = [[NSArray alloc] initWithObjects:@"Ao Kieu 1", @"Ao Kieu 2", @"Ao Kieu 3", @"Ao Kieu 4", @"Ao Kieu 5", @"Ao Kieu 6", @"Ao Kieu 7", @"Ao Kieu 8", @"Ao Kieu 9", @"Ao Kieu 10", @"Ao Kieu 11", @"Ao Kieu 12", @"Ao Kieu 13", @"Ao Kieu 14", @"Ao Kieu 15", @"Ao Kieu 16", nil];
    NSArray *itemPrice = [[NSArray alloc] initWithObjects:@"200000", @"300000", @"400000", @"500000", @"600000", @"700000", @"800000", @"900000", @"200000", @"300000", @"400000", @"500000", @"600000", @"700000", @"800000", @"900000", nil];
    itemDict = [[NSDictionary alloc] initWithObjects:itemPrice forKeys:itemName];
    [itemName release];
    [itemPrice release];
    
    BOOL overLoad = NO;
    NSInteger x = 1044;
    NSInteger y = 20;
    NSInteger scrollWidth = 0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    UIImage *shopDecorator = [UIImage imageNamed:@"2308.jpg"];
    UIImageView *shopDecoratorView = [[UIImageView alloc] initWithImage:shopDecorator];
    [shopDecorator release];
    [shopDecoratorView setFrame:CGRectMake(0, 0, 1024, 768)];
    [scrollView addSubview:shopDecoratorView];
    [shopDecoratorView release];
    
    for (id key in itemDict){
        UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 156, 156)];
        UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(x+166, y+20, 300, 15)];
        [itemName setText:key];
        UILabel *itemDesc = [[UILabel alloc] initWithFrame:CGRectMake(x+166, y+40, 300, 15)];
        UIImage *itemImage = [UIImage imageNamed:@"image1.png"];
        
        [itemButton addTarget:self action:@selector(gotoItem:) forControlEvents:UIControlEventTouchUpInside];
        [itemButton setImage:itemImage forState:normal];
        [itemButton setTitle:key forState:normal];
        [itemButton setTitleColor:[UIColor blackColor] forState:normal];
        [itemDesc setText:[itemDict objectForKey:key]];
        
        [itemImage release];
        
        [scrollView addSubview:itemButton];
        [scrollView addSubview:itemName];
        [scrollView addSubview:itemDesc];
        
        [self.view addSubview:scrollView];
        [itemButton release];
        
        [itemName release];
        [itemDesc release];
        y = y + 20 + 156;
        overLoad = YES;
        if (y > 500){
            y = 20;
            x = x + 156 + 20 + 300 + 20;
            overLoad = NO;
        }
        if (overLoad)
            scrollWidth = x + 156 + 20 + 300;
        else
            scrollWidth = x;
    }
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollWidth, 700);
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    
    //scrollView.scrollsToTop = NO;
    //scrollView.delegate = self;
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

-(IBAction)gotoItem:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    
    ItemDetailsViewController *detailViewController = [[ItemDetailsViewController alloc] init];
    
    detailViewController.navigationItem.title = title;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
}

@end
