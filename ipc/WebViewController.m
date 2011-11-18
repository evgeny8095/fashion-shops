//
//  WebViewController.m
//  ipc
//
//  Created by SaRy on 8/24/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController
@synthesize stringUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (id)initWithStringURL:(NSString *)curl
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.stringUrl = curl;
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
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 655)];
    addressBar = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 1024, 20)];
    [addressBar setEditable:NO];
    [webView loadRequest:request];
    [addressBar setText:stringUrl];
    [self.view addSubview:webView];
    //[self.view addSubview:addressBar];
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
