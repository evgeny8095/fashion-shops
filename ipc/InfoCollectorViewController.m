//
//  InfoCollectorViewController.m
//  ipc
//
//  Created by Mahmood1 on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoCollectorViewController.h"


@implementation InfoCollectorViewController
@synthesize fullName, phone, email, pid, delegate = _delegate;

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
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - Main Process
- (BOOL) validateTextField
{
    Boolean flag = YES;
    if ([[fullName text] isEqualToString:@""]) {
        [fullName setPlaceholder:@"Họ và Tên đang bỏ trống"];
        [fullName setBackgroundColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:0.1]];
        flag = NO;
    }
    if ([[phone text] isEqualToString:@""]) {
        [phone setPlaceholder:@"Số điện thoại đang bỏ trống"];
        flag = NO;
    }
    if (![self isEmailValidated:[email text]]){
        [email setText:@""];
        [email setPlaceholder:@"Email không đúng định dạng"];
        flag = NO;
    }
    return flag;
}

- (IBAction) saveInfoOrSentRequest
{
    if ([self validateTextField])
    {
        REQ_SERVICE(reqSrv);
        PUR_SERVICE(purSrv);
        NSString *fullNameString = [[NSString alloc] initWithString:[fullName text]];
        [reqSrv setFullName:fullNameString];
        [fullNameString release];
        
        NSString *phoneString = [[NSString alloc] initWithString:[phone text]];
        [reqSrv setPhone:phoneString];
        [phoneString release];
        
        NSString *emailString = [[NSString alloc] initWithString:[email text]];
        [reqSrv setEmail:emailString];
        [emailString release];
        
        [reqSrv saveUserInformation];
        [reqSrv sentSingleProductRequest];
        [purSrv addPurchasedProduct:[[reqSrv pid] intValue]];
        [_delegate didSaveAndSentSuccessfuly];
    }
}
-(BOOL) isEmailValidated:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *filterString = @"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? filterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
