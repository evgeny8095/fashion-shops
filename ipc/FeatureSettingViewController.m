//
//  FeatureSettingViewController.m
//  ipc
//
//  Created on 11/4/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "FeatureSettingViewController.h"
#import "ipcGlobal.h"

@implementation FeatureSettingViewController

@synthesize toolbar, numberFav, numberPur, buttonFav, buttonPur;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [buttonFav setBackgroundImage:[[UIImage imageNamed:@"btn-black.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [buttonPur setBackgroundImage:[[UIImage imageNamed:@"btn-black.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:spacer];
    [spacer release];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 0.0f, self.view.frame.size.width, 28.0f)];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"Tính Năng"];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:spacer2];
    [spacer2 release];
    
    UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    [items addObject:title];
    [title release];
    
    [self.toolbar setItems:items animated:YES];
    [items release];
    
    FAV_SERVICE(favSrv);
    [numberFav setText:[NSString stringWithFormat:@"%i", [[favSrv favouriteProducts] count]]];
    PUR_SERVICE(purSrv);
    [numberPur setText:[NSString stringWithFormat:@"%i", [[purSrv purchasedProducts] count]]];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.toolbar = nil;
}

- (IBAction) clearAllFavoriteProducts
{
    if (![numberFav.text isEqualToString:@"0"]) {
        FAV_SERVICE(favSrv);
        [favSrv clearAllFavoriteProducts];
        [numberFav setText:@"0"];
    }
}

- (IBAction) clearAllPurchasedProducts
{
    if (![numberPur.text isEqualToString:@"0"]) {
        PUR_SERVICE(purSrv);
        [purSrv clearAllPurchasedProducs];
        [numberPur setText:@"0"];
    }
}

#pragma mark -
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Add the popover button to the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray insertObject:barButtonItem atIndex:0];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}


#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [toolbar release];
    [titleLabel release];
    [super dealloc];
}	


@end
