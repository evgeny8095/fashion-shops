//
//  CatalogueViewController.m
//  ipc
//
//  Created by SaRy on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CatalogueViewController.h"
#import "ItemsViewController.h"

@implementation CatalogueViewController

@synthesize catelogueLabel;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [catelogueDict release];
    [super dealloc];
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
    NSArray *catalogueName = [[NSArray alloc] initWithObjects:@"Shop 1", @"Shop 2", @"Shop 3", @"Shop 4", @"Shop 5", @"Shop 6", @"Shop 7", @"Shop 8", @"Shop 9", @"Shop 10", @"Shop 11", @"Shop 12", @"Shop 13", @"Shop 14", @"Shop 15", @"Shop 16", nil];
    NSArray *catalogueDesc = [[NSArray alloc] initWithObjects:@"Hang Nhap", @"Hang VNCLC", @"Hang Thai", @"Hang Tau", @"Hang Sida", @"Hang Nhai", @"Hang Hieu", @"Hang Hieu", @"Hang Hieu", @"Hang Hieu", @"Hang Hieu", @"Hang Hieu", @"Hang Hieu", @"Hang Hieu", @"Hang Hieu", @"Hang Hieu", nil];
    catelogueDict = [[NSDictionary alloc] initWithObjects:catalogueDesc forKeys:catalogueName];
    
    [catalogueName release];
    [catalogueDesc release];
    
    BOOL overLoad = NO;
    NSInteger x = 20;
    NSInteger y = 20;
    NSInteger scrollWidth = 0;
    for (id key in catelogueDict){
        UIButton *cataButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 128, 128)];
        UILabel *cataLabel = [[UILabel alloc] initWithFrame:CGRectMake(x+138, y+20, 175, 15)];
        [cataLabel setText:key];
        UILabel *cataDesc = [[UILabel alloc] initWithFrame:CGRectMake(x+138, y+40, 175, 15)];
        UIImage *cataButtonImage = [UIImage imageNamed:@"lion.png"];
        
        [cataButton addTarget:self action:@selector(gotoCatalogue:) forControlEvents:UIControlEventTouchUpInside];
        [cataButton setImage:cataButtonImage forState:normal];
        [cataButton setTitle:key forState:normal];
        [cataButton setTitleColor:[UIColor blackColor] forState:normal];
        [cataDesc setText:[catelogueDict objectForKey:key]];
        [cataButtonImage release];
        
        [scrollView addSubview:cataButton];
        [scrollView addSubview:cataLabel];
        [scrollView addSubview:cataDesc];
        
        //[self.view addSubview:scrollView];
        [cataButton release];
        
        [cataLabel release];
        [cataDesc release];
        y = y + 20 + 128;
        overLoad = YES;
        if (y > 500){
            y = 20;
            x = x + 128 + 20 + 175 + 20;
            overLoad = NO;
        }
        if (overLoad)
            scrollWidth = x + 156 + 20 + 300;
        else
            scrollWidth = x;
    }
    scrollView.pagingEnabled = NO;
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

-(IBAction)gotoCatalogue:(id)sender{
    NSString *title = ((UIButton *) sender).titleLabel.text;
    
    ItemsViewController *itemsViewController = [[ItemsViewController alloc] init];
    
    itemsViewController.navigationItem.title = title;
    
    [self.navigationController pushViewController:itemsViewController animated:YES];
    
    [itemsViewController release];
}
@end
